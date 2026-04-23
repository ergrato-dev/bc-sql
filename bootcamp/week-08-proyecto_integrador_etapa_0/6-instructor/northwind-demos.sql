-- ============================================================
-- DEMOS INSTRUCTOR — Semana 08: Proyecto Integrador Etapa 0
-- Base de datos: northwind (PostgreSQL 16 · Docker)
-- ⚠️  SOLO USO INTERNO — No compartir con aprendices
-- ============================================================
-- Conectar al contenedor:
--   docker compose -f scripts/docker-compose.yml exec postgres \
--     psql -U bootcamp -d northwind
-- ============================================================
-- PROPÓSITO: Demo de live-coding que integra DDL + DML +
--   SELECT + filtros + agregación + manejo de NULL.
--   Úsalo para mostrar cómo se construye un análisis real.
-- ============================================================


-- ── ANÁLISIS INTEGRADOR: Reporte de ventas Northwind ─────────


-- PASO 1: Exploración — entender el modelo antes de escribir queries

-- ¿Qué hay en la BD?
SELECT table_name FROM information_schema.tables WHERE table_schema = 'public';

-- ¿Qué columnas tiene orders?
SELECT column_name, data_type, is_nullable
FROM information_schema.columns
WHERE table_name = 'orders'
ORDER BY ordinal_position;


-- PASO 2: Volumen de datos

SELECT
    'orders'        AS tabla, COUNT(*) AS filas FROM orders        UNION ALL
SELECT 'order_details',       COUNT(*)          FROM order_details UNION ALL
SELECT 'products',            COUNT(*)          FROM products      UNION ALL
SELECT 'customers',           COUNT(*)          FROM customers;


-- PASO 3: Calidad de datos — ¿hay NULLs importantes?

SELECT
    COUNT(*)                              AS total_pedidos,
    COUNT(shipped_date)                   AS enviados,
    COUNT(*) - COUNT(shipped_date)        AS pendientes,
    COUNT(ship_region)                    AS con_region_envio
FROM orders;


-- PASO 4: Consulta básica con filtro y orden

-- Top 10 clientes por número de pedidos:
SELECT
    c.company_name,
    c.country,
    COUNT(o.order_id)   AS total_pedidos
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.company_name, c.country
ORDER BY total_pedidos DESC
LIMIT 10;


-- PASO 5: Agregación multi-nivel

-- Ventas brutas por país del cliente y año:
SELECT
    c.country,
    EXTRACT(YEAR FROM o.order_date)                               AS anio,
    COUNT(DISTINCT o.order_id)                                    AS pedidos,
    ROUND(SUM(od.unit_price * od.quantity * (1 - od.discount)), 2) AS ventas_brutas
FROM customers c
JOIN orders       o  ON c.customer_id  = o.customer_id
JOIN order_details od ON o.order_id    = od.order_id
WHERE o.order_date BETWEEN '1996-01-01' AND '1998-12-31'
GROUP BY c.country, anio
HAVING SUM(od.unit_price * od.quantity * (1 - od.discount)) > 5000
ORDER BY anio, ventas_brutas DESC;


-- PASO 6: Detección de anomalías

-- Pedidos con descuento inusualmente alto (> 20%):
SELECT
    od.order_id,
    p.product_name,
    od.unit_price,
    od.quantity,
    od.discount,
    ROUND(od.unit_price * od.quantity * od.discount, 2) AS monto_descuento
FROM order_details od
JOIN products p ON od.product_id = p.product_id
WHERE od.discount > 0.20
ORDER BY od.discount DESC;


-- PASO 7: Vista ejecutiva — resumen por empleado

SELECT
    e.first_name || ' ' || e.last_name             AS empleado,
    COUNT(DISTINCT o.order_id)                     AS pedidos_gestionados,
    COUNT(DISTINCT o.customer_id)                  AS clientes_atendidos,
    ROUND(SUM(od.unit_price * od.quantity * (1 - od.discount)), 2) AS ventas_totales,
    ROUND(AVG(od.unit_price * od.quantity * (1 - od.discount)), 2) AS ticket_promedio
FROM employees e
JOIN orders       o  ON e.employee_id  = o.employee_id
JOIN order_details od ON o.order_id    = od.order_id
GROUP BY empleado
ORDER BY ventas_totales DESC;
