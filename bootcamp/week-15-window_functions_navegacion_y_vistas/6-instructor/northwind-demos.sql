-- ============================================================
-- DEMOS INSTRUCTOR — Semana 15: Window Functions — Navegación y Vistas
-- Base de datos: northwind (PostgreSQL 16 · Docker)
-- ⚠️  SOLO USO INTERNO — No compartir con aprendices
-- ============================================================
-- Conectar al contenedor:
--   docker compose -f scripts/docker-compose.yml exec postgres \
--     psql -U bootcamp -d northwind
-- ============================================================


-- ── 1. LAG — comparar con el período anterior ─────────────────
-- Ventas mensuales y diferencia respecto al mes anterior:
WITH ventas_mes AS (
    SELECT
        DATE_TRUNC('month', o.order_date)::DATE             AS mes,
        ROUND(SUM(od.unit_price * od.quantity * (1 - od.discount)), 2) AS ventas
    FROM orders o
    JOIN order_details od ON o.order_id = od.order_id
    GROUP BY mes
)
SELECT
    mes,
    ventas,
    LAG(ventas) OVER (ORDER BY mes)                           AS ventas_mes_anterior,
    ROUND(ventas - LAG(ventas) OVER (ORDER BY mes), 2)        AS diferencia,
    ROUND(
        (ventas - LAG(ventas) OVER (ORDER BY mes))
        / NULLIF(LAG(ventas) OVER (ORDER BY mes), 0) * 100, 1
    )                                                         AS variacion_pct
FROM ventas_mes
ORDER BY mes;


-- ── 2. LEAD — anticipar el valor siguiente ────────────────────
-- Para cada pedido, cuándo fue el siguiente pedido del mismo cliente:
SELECT
    customer_id,
    order_id,
    order_date,
    LEAD(order_date) OVER (
        PARTITION BY customer_id
        ORDER BY order_date
    )                                             AS siguiente_pedido,
    LEAD(order_date) OVER (PARTITION BY customer_id ORDER BY order_date)
        - order_date                              AS dias_hasta_siguiente
FROM orders
ORDER BY customer_id, order_date
LIMIT 20;


-- ── 3. FIRST_VALUE y LAST_VALUE ───────────────────────────────
-- Para cada producto, comparar su precio con el más barato y el más caro
-- dentro de su categoría:
SELECT
    p.product_name,
    c.category_name,
    p.unit_price,
    FIRST_VALUE(p.unit_price) OVER (
        PARTITION BY c.category_name
        ORDER BY p.unit_price
        ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
    )  AS mas_barato_categoria,
    LAST_VALUE(p.unit_price) OVER (
        PARTITION BY c.category_name
        ORDER BY p.unit_price
        ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
    )  AS mas_caro_categoria
FROM products p
JOIN categories c ON p.category_id = c.category_id
ORDER BY c.category_name, p.unit_price;


-- ── 4. Acumulado mensual con SUM OVER ────────────────────────
-- Ventas acumuladas por mes (running total):
WITH ventas_mes AS (
    SELECT
        DATE_TRUNC('month', o.order_date)::DATE             AS mes,
        ROUND(SUM(od.unit_price * od.quantity * (1 - od.discount)), 2) AS ventas
    FROM orders o
    JOIN order_details od ON o.order_id = od.order_id
    GROUP BY mes
)
SELECT
    mes,
    ventas,
    SUM(ventas) OVER (ORDER BY mes
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)  AS acumulado
FROM ventas_mes
ORDER BY mes;


-- ── 5. VISTAS — encapsular consultas complejas ────────────────
-- Crear una vista de ventas mensuales para reutilizarla:

CREATE OR REPLACE VIEW v_ventas_mensuales AS
WITH base AS (
    SELECT
        DATE_TRUNC('month', o.order_date)::DATE                        AS mes,
        ROUND(SUM(od.unit_price * od.quantity * (1 - od.discount)), 2) AS ventas
    FROM orders o
    JOIN order_details od ON o.order_id = od.order_id
    GROUP BY mes
)
SELECT
    mes,
    ventas,
    LAG(ventas) OVER (ORDER BY mes)                  AS mes_anterior,
    SUM(ventas) OVER (ORDER BY mes
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS acumulado
FROM base;

-- Consultar la vista como si fuera una tabla:
SELECT * FROM v_ventas_mensuales ORDER BY mes;

-- ── 6. DROP VIEW al terminar la demo ─────────────────────────
DROP VIEW IF EXISTS v_ventas_mensuales;
