-- ============================================================
-- DEMOS INSTRUCTOR — Semana 02: DDL — Diseño de esquemas
-- Base de datos: northwind (PostgreSQL 16 · Docker)
-- ⚠️  SOLO USO INTERNO — No compartir con aprendices
-- ============================================================
-- Conectar al contenedor:
--   docker compose -f scripts/docker-compose.yml exec postgres \
--     psql -U bootcamp -d northwind
-- ============================================================
-- ESTRATEGIA: NO alterar el esquema de Northwind.
--   Usar TEMP TABLE para CREATE/ALTER/DROP sin efectos secundarios.
--   Al cerrar la sesión psql, las tablas temporales desaparecen.
-- ============================================================


-- ── 1. INSPECCIONAR TABLAS EXISTENTES (como referencia DDL) ──
-- Mostrar qué tipos de datos usa Northwind en la práctica.

SELECT
    column_name,
    data_type,
    character_maximum_length,
    is_nullable,
    column_default
FROM information_schema.columns
WHERE table_name = 'customers'
ORDER BY ordinal_position;


-- ── 2. CREATE TABLE — tipos de datos comunes ─────────────────
-- Crear una tabla espejo de 'products' para demostrar sintaxis.
-- TEMP → solo existe en esta sesión, no contamina la BD.

CREATE TEMP TABLE demo_products (
    product_id      INTEGER     PRIMARY KEY,
    product_name    TEXT        NOT NULL,
    unit_price      NUMERIC(10, 2),
    units_in_stock  INTEGER     DEFAULT 0,
    discontinued    BOOLEAN     DEFAULT FALSE,
    created_at      TIMESTAMPTZ DEFAULT NOW()
);


-- ── 3. INSERT para verificar la tabla ────────────────────────

INSERT INTO demo_products (product_id, product_name, unit_price, units_in_stock)
VALUES
    (1, 'Chai',         18.00, 39),
    (2, 'Chang',        19.00, 17),
    (3, 'Aniseed Syrup', 10.00, 13);

SELECT * FROM demo_products;


-- ── 4. ALTER TABLE — agregar y modificar columnas ────────────

ALTER TABLE demo_products
    ADD COLUMN supplier_id INTEGER;

ALTER TABLE demo_products
    ALTER COLUMN product_name SET NOT NULL;

-- Ver el resultado
SELECT column_name, data_type, is_nullable
FROM information_schema.columns
WHERE table_name = 'demo_products'
ORDER BY ordinal_position;


-- ── 5. CONSTRAINTS — integridad en la definición ─────────────

CREATE TEMP TABLE demo_order_items (
    item_id     INTEGER PRIMARY KEY,
    product_id  INTEGER NOT NULL REFERENCES demo_products(product_id),
    quantity    INTEGER NOT NULL CHECK (quantity > 0),
    unit_price  NUMERIC(10, 2) NOT NULL CHECK (unit_price >= 0),
    discount    NUMERIC(4, 2)  DEFAULT 0 CHECK (discount BETWEEN 0 AND 1)
);

-- Insertar un ítem válido
INSERT INTO demo_order_items VALUES (1, 1, 5, 18.00, 0.10);

-- Intentar violar CHECK (descomentar para mostrar el error):
-- INSERT INTO demo_order_items VALUES (2, 1, -3, 18.00, 0);


-- ── 6. DROP TABLE ─────────────────────────────────────────────
-- Mostrar que DROP elimina estructura + datos (irreversible en producción).

DROP TABLE IF EXISTS demo_order_items;
DROP TABLE IF EXISTS demo_products;
