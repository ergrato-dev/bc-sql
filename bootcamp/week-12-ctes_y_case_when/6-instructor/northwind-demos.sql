-- ============================================================
-- DEMOS INSTRUCTOR — Semana 12: CTEs y CASE WHEN
-- Base de datos: northwind (PostgreSQL 16 · Docker)
-- ⚠️  SOLO USO INTERNO — No compartir con aprendices
-- ============================================================
-- Conectar al contenedor:
--   docker compose -f scripts/docker-compose.yml exec postgres \
--     psql -U bootcamp -d northwind
-- ============================================================


-- ── 1. CTE simple — nombrar un resultado intermedio ──────────
-- Calcular ventas por cliente y luego filtrar sobre ese resultado:
WITH ventas_por_cliente AS (
    SELECT
        c.customer_id,
        c.company_name,
        c.country,
        ROUND(SUM(od.unit_price * od.quantity * (1 - od.discount)), 2) AS total_comprado
    FROM customers c
    JOIN orders       o  ON c.customer_id = o.customer_id
    JOIN order_details od ON o.order_id   = od.order_id
    GROUP BY c.customer_id, c.company_name, c.country
)
SELECT *
FROM ventas_por_cliente
WHERE total_comprado > 10000
ORDER BY total_comprado DESC;


-- ── 2. CTEs encadenados ───────────────────────────────────────
-- CTE 1: ventas brutas por producto
-- CTE 2: promedio de esas ventas
-- Query final: productos por encima del promedio
WITH ventas_producto AS (
    SELECT
        p.product_id,
        p.product_name,
        c.category_name,
        ROUND(SUM(od.unit_price * od.quantity * (1 - od.discount)), 2) AS ventas
    FROM products p
    JOIN categories    c  ON p.category_id  = c.category_id
    JOIN order_details od ON p.product_id   = od.product_id
    GROUP BY p.product_id, p.product_name, c.category_name
),
promedio AS (
    SELECT ROUND(AVG(ventas), 2) AS avg_ventas FROM ventas_producto
)
SELECT
    vp.product_name,
    vp.category_name,
    vp.ventas,
    p.avg_ventas,
    ROUND(vp.ventas - p.avg_ventas, 2) AS diferencia
FROM ventas_producto vp
CROSS JOIN promedio p
WHERE vp.ventas > p.avg_ventas
ORDER BY vp.ventas DESC;


-- ── 3. CASE WHEN — clasificación por rangos ───────────────────
-- Clasificar productos por nivel de precio:
SELECT
    product_name,
    unit_price,
    CASE
        WHEN unit_price < 10            THEN 'Económico'
        WHEN unit_price BETWEEN 10 AND 30 THEN 'Estándar'
        WHEN unit_price BETWEEN 30 AND 60 THEN 'Premium'
        ELSE                                 'Lujo'
    END AS segmento_precio
FROM products
ORDER BY unit_price;


-- ── 4. CASE WHEN en GROUP BY ─────────────────────────────────
-- Cuántos productos hay en cada segmento:
SELECT
    CASE
        WHEN unit_price < 10            THEN 'Económico'
        WHEN unit_price BETWEEN 10 AND 30 THEN 'Estándar'
        WHEN unit_price BETWEEN 30 AND 60 THEN 'Premium'
        ELSE                                 'Lujo'
    END                     AS segmento,
    COUNT(*)                AS total_productos,
    ROUND(AVG(unit_price), 2) AS precio_promedio
FROM products
GROUP BY segmento
ORDER BY precio_promedio;


-- ── 5. CTE + CASE WHEN juntos ────────────────────────────────
-- Reporte de rendimiento por empleado con etiqueta de performance:
WITH rendimiento AS (
    SELECT
        e.first_name || ' ' || e.last_name                            AS empleado,
        COUNT(DISTINCT o.order_id)                                    AS pedidos,
        ROUND(SUM(od.unit_price * od.quantity * (1 - od.discount)), 2) AS ventas
    FROM employees e
    JOIN orders       o  ON e.employee_id = o.employee_id
    JOIN order_details od ON o.order_id   = od.order_id
    GROUP BY e.employee_id, e.first_name, e.last_name
)
SELECT
    empleado,
    pedidos,
    ventas,
    CASE
        WHEN ventas >= 100000 THEN '⭐ Top Performer'
        WHEN ventas >= 70000  THEN '✅ On Track'
        ELSE                       '⚠️  Needs Review'
    END AS performance
FROM rendimiento
ORDER BY ventas DESC;
