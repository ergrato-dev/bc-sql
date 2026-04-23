-- ============================================================
-- DEMOS INSTRUCTOR — Semana 18: Funciones y Procedimientos PL/pgSQL
-- Base de datos: northwind (PostgreSQL 16 · Docker)
-- ⚠️  SOLO USO INTERNO — No compartir con aprendices
-- ============================================================
-- Conectar al contenedor:
--   docker compose -f scripts/docker-compose.yml exec postgres \
--     psql -U bootcamp -d northwind
-- ============================================================


-- ── 1. Función escalar simple ────────────────────────────────
-- Calcular el subtotal de una línea de pedido con descuento:

CREATE OR REPLACE FUNCTION fn_subtotal(
    p_unit_price NUMERIC,
    p_quantity   INTEGER,
    p_discount   NUMERIC
)
RETURNS NUMERIC
LANGUAGE plpgsql
AS $$
BEGIN
    RETURN ROUND(p_unit_price * p_quantity * (1 - p_discount), 2);
END;
$$;

-- Probar:
SELECT fn_subtotal(18.00, 10, 0.05) AS subtotal;

-- Usar en una query real:
SELECT
    order_id,
    product_id,
    unit_price,
    quantity,
    discount,
    fn_subtotal(unit_price, quantity, discount) AS subtotal
FROM order_details
WHERE order_id = 10248;


-- ── 2. Función con lógica condicional ────────────────────────
-- Devolver el segmento de precio de un producto:

CREATE OR REPLACE FUNCTION fn_segmento_precio(p_precio NUMERIC)
RETURNS TEXT
LANGUAGE plpgsql
AS $$
BEGIN
    RETURN CASE
        WHEN p_precio < 10   THEN 'Económico'
        WHEN p_precio <= 30  THEN 'Estándar'
        WHEN p_precio <= 60  THEN 'Premium'
        ELSE                      'Lujo'
    END;
END;
$$;

-- Usar en una query:
SELECT product_name, unit_price, fn_segmento_precio(unit_price) AS segmento
FROM products
ORDER BY unit_price;


-- ── 3. Función que retorna una tabla ─────────────────────────
-- Top N productos por ventas:

CREATE OR REPLACE FUNCTION fn_top_productos(p_n INTEGER DEFAULT 5)
RETURNS TABLE (
    product_name  TEXT,
    category_name TEXT,
    total_ventas  NUMERIC
)
LANGUAGE plpgsql
AS $$
BEGIN
    RETURN QUERY
    SELECT
        p.product_name,
        c.category_name,
        ROUND(SUM(od.unit_price * od.quantity * (1 - od.discount)), 2)
    FROM products p
    JOIN categories    c  ON p.category_id  = c.category_id
    JOIN order_details od ON p.product_id   = od.product_id
    GROUP BY p.product_name, c.category_name
    ORDER BY 3 DESC
    LIMIT p_n;
END;
$$;

-- Probar:
SELECT * FROM fn_top_productos(10);


-- ── 4. Procedimiento con manejo de errores ───────────────────
-- Procedimiento para aplicar descuento a una categoría:

CREATE OR REPLACE PROCEDURE sp_aplicar_descuento_categoria(
    p_category_id INTEGER,
    p_porcentaje  NUMERIC
)
LANGUAGE plpgsql
AS $$
DECLARE
    v_afectados INTEGER;
BEGIN
    IF p_porcentaje <= 0 OR p_porcentaje >= 1 THEN
        RAISE EXCEPTION 'El porcentaje debe estar entre 0 y 1. Recibido: %', p_porcentaje;
    END IF;

    UPDATE products
    SET unit_price = ROUND(unit_price * (1 - p_porcentaje), 2)
    WHERE category_id = p_category_id
      AND discontinued = FALSE;

    GET DIAGNOSTICS v_afectados = ROW_COUNT;
    RAISE NOTICE '% productos actualizados en categoría %', v_afectados, p_category_id;

    -- NO hacemos COMMIT aquí para no alterar Northwind en la demo
    -- En producción real el procedimiento haría COMMIT o llamaría desde un bloque BEGIN
END;
$$;

-- Probar (envuelto en transacción para revertir al final):
BEGIN;
    CALL sp_aplicar_descuento_categoria(1, 0.10);
    SELECT product_id, product_name, unit_price FROM products WHERE category_id = 1;
ROLLBACK;


-- ── 5. Limpiar objetos de demo ────────────────────────────────
DROP FUNCTION IF EXISTS fn_subtotal(NUMERIC, INTEGER, NUMERIC);
DROP FUNCTION IF EXISTS fn_segmento_precio(NUMERIC);
DROP FUNCTION IF EXISTS fn_top_productos(INTEGER);
DROP PROCEDURE IF EXISTS sp_aplicar_descuento_categoria(INTEGER, NUMERIC);
