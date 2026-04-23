-- ============================================================
-- DEMOS INSTRUCTOR — Semana 19: Triggers — Automatización
-- Base de datos: northwind (PostgreSQL 16 · Docker)
-- ⚠️  SOLO USO INTERNO — No compartir con aprendices
-- ============================================================
-- Conectar al contenedor:
--   docker compose -f scripts/docker-compose.yml exec postgres \
--     psql -U bootcamp -d northwind
-- ============================================================


-- ── 0. Tabla de auditoría para los demos ─────────────────────
CREATE TABLE IF NOT EXISTS audit_products (
    audit_id    SERIAL PRIMARY KEY,
    product_id  INTEGER      NOT NULL,
    campo       TEXT         NOT NULL,
    valor_viejo TEXT,
    valor_nuevo TEXT,
    operacion   TEXT         NOT NULL,   -- INSERT / UPDATE / DELETE
    usuario     TEXT         DEFAULT CURRENT_USER,
    ocurrido_en TIMESTAMPTZ  DEFAULT NOW()
);


-- ── 1. Trigger AFTER UPDATE — auditoría de cambios de precio ──
CREATE OR REPLACE FUNCTION trg_fn_audit_price()
RETURNS TRIGGER
LANGUAGE plpgsql
AS $$
BEGIN
    IF OLD.unit_price IS DISTINCT FROM NEW.unit_price THEN
        INSERT INTO audit_products (product_id, campo, valor_viejo, valor_nuevo, operacion)
        VALUES (NEW.product_id, 'unit_price', OLD.unit_price::TEXT, NEW.unit_price::TEXT, 'UPDATE');
    END IF;
    RETURN NEW;
END;
$$;

CREATE OR REPLACE TRIGGER trg_audit_price
AFTER UPDATE ON products
FOR EACH ROW
EXECUTE FUNCTION trg_fn_audit_price();

-- Probar (en transacción para revertir):
BEGIN;
    UPDATE products SET unit_price = unit_price * 1.20 WHERE category_id = 1;
    SELECT * FROM audit_products ORDER BY ocurrido_en DESC LIMIT 5;
ROLLBACK;


-- ── 2. Trigger BEFORE INSERT — validación y normalización ─────
-- Asegurar que product_name siempre empiece en mayúscula.

CREATE OR REPLACE FUNCTION trg_fn_normalize_name()
RETURNS TRIGGER
LANGUAGE plpgsql
AS $$
BEGIN
    NEW.product_name := INITCAP(TRIM(NEW.product_name));

    IF LENGTH(NEW.product_name) < 2 THEN
        RAISE EXCEPTION 'El nombre del producto debe tener al menos 2 caracteres.';
    END IF;

    RETURN NEW;
END;
$$;

CREATE OR REPLACE TRIGGER trg_normalize_product_name
BEFORE INSERT OR UPDATE ON products
FOR EACH ROW
EXECUTE FUNCTION trg_fn_normalize_name();

-- Probar:
BEGIN;
    INSERT INTO products (product_id, product_name, category_id, supplier_id,
                          quantity_per_unit, unit_price, units_in_stock,
                          units_on_order, reorder_level, discontinued)
    VALUES (9999, '  mate  ', 1, 1, '1 box', 5.00, 10, 0, 5, FALSE);
    SELECT product_id, product_name FROM products WHERE product_id = 9999;
ROLLBACK;


-- ── 3. Trigger AFTER DELETE — log de eliminaciones ───────────
CREATE OR REPLACE FUNCTION trg_fn_log_delete()
RETURNS TRIGGER
LANGUAGE plpgsql
AS $$
BEGIN
    INSERT INTO audit_products (product_id, campo, valor_viejo, valor_nuevo, operacion)
    VALUES (OLD.product_id, 'product_name', OLD.product_name, NULL, 'DELETE');
    RETURN OLD;
END;
$$;

CREATE OR REPLACE TRIGGER trg_log_product_delete
AFTER DELETE ON products
FOR EACH ROW
EXECUTE FUNCTION trg_fn_log_delete();

-- Probar con un producto temporal:
BEGIN;
    INSERT INTO products (product_id, product_name, category_id, supplier_id,
                          quantity_per_unit, unit_price, units_in_stock,
                          units_on_order, reorder_level, discontinued)
    VALUES (9998, 'Producto Demo', 1, 1, '1 bag', 9.99, 5, 0, 2, FALSE);

    DELETE FROM products WHERE product_id = 9998;
    SELECT * FROM audit_products WHERE campo = 'product_name';
ROLLBACK;


-- ── 4. Limpiar objetos de demo ────────────────────────────────
DROP TRIGGER IF EXISTS trg_audit_price            ON products;
DROP TRIGGER IF EXISTS trg_normalize_product_name ON products;
DROP TRIGGER IF EXISTS trg_log_product_delete     ON products;
DROP FUNCTION IF EXISTS trg_fn_audit_price();
DROP FUNCTION IF EXISTS trg_fn_normalize_name();
DROP FUNCTION IF EXISTS trg_fn_log_delete();
DROP TABLE  IF EXISTS audit_products;
