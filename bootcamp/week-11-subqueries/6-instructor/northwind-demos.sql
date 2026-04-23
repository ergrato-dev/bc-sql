-- ============================================================
-- DEMOS INSTRUCTOR — Semana 11: Subqueries
-- Base de datos: northwind (PostgreSQL 16 · Docker)
-- ⚠️  SOLO USO INTERNO — No compartir con aprendices
-- ============================================================
-- Conectar al contenedor:
--   docker compose -f scripts/docker-compose.yml exec postgres \
--     psql -U bootcamp -d northwind
-- ============================================================


-- ── 1. Subquery escalar en SELECT ────────────────────────────
-- Para cada producto, mostrar cuánto cuesta respecto al promedio:
SELECT
    product_name,
    unit_price,
    (SELECT ROUND(AVG(unit_price), 2) FROM products)  AS precio_promedio,
    ROUND(unit_price - (SELECT AVG(unit_price) FROM products), 2) AS diferencia
FROM products
ORDER BY diferencia DESC;


-- ── 2. Subquery en WHERE con valor escalar ───────────────────
-- Productos más caros que el precio promedio:
SELECT product_name, unit_price
FROM products
WHERE unit_price > (SELECT AVG(unit_price) FROM products)
ORDER BY unit_price DESC;


-- ── 3. Subquery con IN ────────────────────────────────────────
-- Clientes que hicieron pedidos en 1997:
SELECT company_name, country
FROM customers
WHERE customer_id IN (
    SELECT DISTINCT customer_id
    FROM orders
    WHERE EXTRACT(YEAR FROM order_date) = 1997
)
ORDER BY company_name;


-- ── 4. Subquery con NOT IN ────────────────────────────────────
-- Clientes que NUNCA hicieron un pedido en 1997:
SELECT company_name, country
FROM customers
WHERE customer_id NOT IN (
    SELECT DISTINCT customer_id
    FROM orders
    WHERE EXTRACT(YEAR FROM order_date) = 1997
)
ORDER BY company_name;


-- ── 5. EXISTS ─────────────────────────────────────────────────
-- Clientes que tienen al menos un pedido sin fecha de envío:
SELECT company_name, country
FROM customers c
WHERE EXISTS (
    SELECT 1
    FROM orders o
    WHERE o.customer_id = c.customer_id
      AND o.shipped_date IS NULL
);


-- ── 6. NOT EXISTS ─────────────────────────────────────────────
-- Productos que nunca han sido pedidos:
SELECT product_id, product_name, unit_price
FROM products p
WHERE NOT EXISTS (
    SELECT 1
    FROM order_details od
    WHERE od.product_id = p.product_id
);


-- ── 7. Subquery como tabla derivada en FROM ───────────────────
-- Top 5 clientes por gasto total, mostrando su rango:
SELECT
    rk.company_name,
    rk.total_compras,
    rk.rango
FROM (
    SELECT
        c.company_name,
        ROUND(SUM(od.unit_price * od.quantity * (1 - od.discount)), 2) AS total_compras,
        RANK() OVER (ORDER BY SUM(od.unit_price * od.quantity * (1 - od.discount)) DESC) AS rango
    FROM customers c
    JOIN orders o        ON c.customer_id = o.customer_id
    JOIN order_details od ON o.order_id   = od.order_id
    GROUP BY c.company_name
) rk
WHERE rk.rango <= 5;
