-- ============================================================
-- DEMOS INSTRUCTOR — Semana 14: Window Functions — Ranking
-- Base de datos: northwind (PostgreSQL 16 · Docker)
-- ⚠️  SOLO USO INTERNO — No compartir con aprendices
-- ============================================================
-- Conectar al contenedor:
--   docker compose -f scripts/docker-compose.yml exec postgres \
--     psql -U bootcamp -d northwind
-- ============================================================


-- ── 0. Preparar base: ventas por producto ────────────────────
-- Usaremos esta base en todos los ejemplos de ranking.
WITH ventas AS (
    SELECT
        p.product_id,
        p.product_name,
        c.category_name,
        ROUND(SUM(od.unit_price * od.quantity * (1 - od.discount)), 2) AS total_ventas
    FROM products p
    JOIN categories    c  ON p.category_id  = c.category_id
    JOIN order_details od ON p.product_id   = od.product_id
    GROUP BY p.product_id, p.product_name, c.category_name
)
SELECT * FROM ventas ORDER BY total_ventas DESC LIMIT 10;


-- ── 1. ROW_NUMBER — numeración única, sin empates ─────────────
WITH ventas AS (
    SELECT p.product_name, c.category_name,
           ROUND(SUM(od.unit_price * od.quantity * (1 - od.discount)), 2) AS total
    FROM products p
    JOIN categories c ON p.category_id = c.category_id
    JOIN order_details od ON p.product_id = od.product_id
    GROUP BY p.product_name, c.category_name
)
SELECT
    ROW_NUMBER() OVER (ORDER BY total DESC) AS nro,
    product_name,
    category_name,
    total
FROM ventas
LIMIT 10;


-- ── 2. RANK vs DENSE_RANK — diferencia con empates ───────────
-- Mostrar las diferencias cuando hay productos con ventas similares:
WITH ventas AS (
    SELECT p.product_name, c.category_name,
           ROUND(SUM(od.unit_price * od.quantity * (1 - od.discount)), 0) AS total
    FROM products p
    JOIN categories c ON p.category_id = c.category_id
    JOIN order_details od ON p.product_id = od.product_id
    GROUP BY p.product_name, c.category_name
)
SELECT
    product_name,
    total,
    RANK()       OVER (ORDER BY total DESC) AS rank_con_saltos,
    DENSE_RANK() OVER (ORDER BY total DESC) AS dense_rank_sin_saltos
FROM ventas
ORDER BY total DESC
LIMIT 15;


-- ── 3. PARTITION BY — ranking DENTRO de cada categoría ───────
-- Top 3 productos por categoría según ventas:
WITH ventas AS (
    SELECT p.product_name, c.category_name,
           ROUND(SUM(od.unit_price * od.quantity * (1 - od.discount)), 2) AS total
    FROM products p
    JOIN categories c ON p.category_id = c.category_id
    JOIN order_details od ON p.product_id = od.product_id
    GROUP BY p.product_name, c.category_name
),
ranked AS (
    SELECT
        product_name,
        category_name,
        total,
        RANK() OVER (PARTITION BY category_name ORDER BY total DESC) AS rk
    FROM ventas
)
SELECT category_name, rk, product_name, total
FROM ranked
WHERE rk <= 3
ORDER BY category_name, rk;


-- ── 4. Top-N por empleado (ventas por empleado × año) ─────────
WITH ventas_emp AS (
    SELECT
        e.first_name || ' ' || e.last_name          AS empleado,
        EXTRACT(YEAR FROM o.order_date)::INT         AS anio,
        ROUND(SUM(od.unit_price * od.quantity * (1 - od.discount)), 2) AS ventas
    FROM employees e
    JOIN orders       o  ON e.employee_id = o.employee_id
    JOIN order_details od ON o.order_id   = od.order_id
    GROUP BY empleado, anio
),
ranked AS (
    SELECT *,
           RANK() OVER (PARTITION BY anio ORDER BY ventas DESC) AS rk
    FROM ventas_emp
)
SELECT anio, rk AS posicion, empleado, ventas
FROM ranked
WHERE rk <= 3
ORDER BY anio, rk;
