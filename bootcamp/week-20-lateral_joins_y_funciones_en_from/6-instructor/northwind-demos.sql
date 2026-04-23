-- ============================================================
-- DEMOS INSTRUCTOR — Semana 20: LATERAL Joins y funciones en FROM
-- Base de datos: northwind (PostgreSQL 16 · Docker)
-- ⚠️  SOLO USO INTERNO — No compartir con aprendices
-- ============================================================
-- Conectar al contenedor:
--   docker compose -f scripts/docker-compose.yml exec postgres \
--     psql -U bootcamp -d northwind
-- ============================================================


-- ── 1. Problema sin LATERAL — subquery independiente ─────────
-- Top 3 pedidos por cliente, sin LATERAL:
-- Esto NO funciona: la subquery no puede referenciar la tabla exterior.
-- La solución "clásica" sería con ROW_NUMBER():

SELECT customer_id, order_id, order_date
FROM (
    SELECT
        customer_id, order_id, order_date,
        ROW_NUMBER() OVER (PARTITION BY customer_id ORDER BY order_date DESC) AS rn
    FROM orders
) ranked
WHERE rn <= 3
ORDER BY customer_id, order_date DESC;


-- ── 2. Con LATERAL — el sub-query puede referenciar la fila padre ──
-- Top 3 pedidos recientes por cliente usando LATERAL:
SELECT
    c.customer_id,
    c.company_name,
    latest.order_id,
    latest.order_date
FROM customers c
CROSS JOIN LATERAL (
    SELECT order_id, order_date
    FROM orders o
    WHERE o.customer_id = c.customer_id    -- ← referencia a la fila de customers
    ORDER BY order_date DESC
    LIMIT 3
) latest
ORDER BY c.customer_id, latest.order_date DESC;


-- ── 3. LEFT JOIN LATERAL — incluir clientes sin pedidos ───────
SELECT
    c.customer_id,
    c.company_name,
    COALESCE(latest.order_id::TEXT, 'Sin pedidos')  AS ultimo_pedido,
    latest.order_date
FROM customers c
LEFT JOIN LATERAL (
    SELECT order_id, order_date
    FROM orders o
    WHERE o.customer_id = c.customer_id
    ORDER BY order_date DESC
    LIMIT 1
) latest ON TRUE
ORDER BY c.company_name;


-- ── 4. LATERAL con cálculo complejo por fila padre ─────────────
-- Para cada categoría, obtener su producto más vendido:
SELECT
    c.category_name,
    top_prod.product_name,
    top_prod.total_vendido
FROM categories c
CROSS JOIN LATERAL (
    SELECT
        p.product_name,
        ROUND(SUM(od.unit_price * od.quantity * (1 - od.discount)), 2) AS total_vendido
    FROM products p
    JOIN order_details od ON p.product_id = od.product_id
    WHERE p.category_id = c.category_id     -- ← referencia a la categoría padre
    GROUP BY p.product_name
    ORDER BY total_vendido DESC
    LIMIT 1
) top_prod
ORDER BY c.category_name;


-- ── 5. UNNEST — función tabular en FROM ───────────────────────
-- Expandir un array de períodos de análisis:
SELECT
    anio,
    COUNT(DISTINCT order_id) AS pedidos
FROM orders
CROSS JOIN LATERAL (
    SELECT EXTRACT(YEAR FROM order_date)::INT AS anio
) t
GROUP BY anio
ORDER BY anio;

-- UNNEST directo (común con columnas tipo ARRAY):
SELECT unnest(ARRAY['Q1','Q2','Q3','Q4']) AS trimestre;
