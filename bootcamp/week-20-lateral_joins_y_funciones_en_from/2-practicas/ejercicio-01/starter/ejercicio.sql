-- ============================================
-- Semana 20: LATERAL Joins
-- Ejercicio 01 — JOIN LATERAL básico
-- Motor: PostgreSQL 16
-- ============================================

-- ============================================
-- PASO 1: La venta más reciente de cada empleado
-- ============================================

-- JOIN LATERAL para obtener la venta más reciente de cada empleado
-- Descomenta las siguientes líneas:

-- SELECT
--     e.id,
--     e.name,
--     last_sale.product_name,
--     last_sale.amount,
--     last_sale.sale_date
-- FROM employees e
-- JOIN LATERAL (
--     SELECT product_name, amount, sale_date
--     FROM sales
--     WHERE employee_id = e.id
--     ORDER BY sale_date DESC
--     LIMIT 1
-- ) AS last_sale ON TRUE
-- ORDER BY e.id;


-- ============================================
-- PASO 2: Empleados SIN ventas con LEFT JOIN LATERAL
-- ============================================

-- LEFT JOIN LATERAL para incluir empleados sin ventas
-- Descomenta las siguientes líneas:

-- SELECT
--     e.id,
--     e.name,
--     last_sale.product_name,
--     last_sale.amount
-- FROM employees e
-- LEFT JOIN LATERAL (
--     SELECT product_name, amount
--     FROM sales
--     WHERE employee_id = e.id
--     ORDER BY amount DESC
--     LIMIT 1
-- ) AS last_sale ON TRUE
-- ORDER BY e.id;


-- ============================================
-- PASO 3: Total y promedio por empleado con LATERAL
-- ============================================

-- CROSS JOIN LATERAL para obtener múltiples agregados en una subquery
-- Descomenta las siguientes líneas:

-- SELECT
--     e.id,
--     e.name,
--     stats.total_sales,
--     stats.avg_amount,
--     stats.num_sales
-- FROM employees e
-- CROSS JOIN LATERAL (
--     SELECT
--         COUNT(*)                     AS num_sales,
--         COALESCE(SUM(amount), 0)     AS total_sales,
--         COALESCE(AVG(amount), 0)     AS avg_amount
--     FROM sales
--     WHERE employee_id = e.id
-- ) AS stats
-- ORDER BY stats.total_sales DESC;


-- ============================================
-- PASO 4: Subquery correlacionada vs LATERAL
-- ============================================

-- Versión SIN LATERAL (múltiples subqueries en SELECT)
-- Descomenta las siguientes líneas:

-- SELECT
--     e.name,
--     (SELECT COUNT(*)
--      FROM sales WHERE employee_id = e.id)           AS num_sales,
--     (SELECT COALESCE(SUM(amount), 0)
--      FROM sales WHERE employee_id = e.id)           AS total_sales
-- FROM employees e;

-- Versión CON LATERAL (una sola subquery, más mantenible)
-- Descomenta las siguientes líneas:

-- SELECT e.name, s.num_sales, s.total_sales
-- FROM employees e
-- CROSS JOIN LATERAL (
--     SELECT COUNT(*) AS num_sales,
--            COALESCE(SUM(amount), 0) AS total_sales
--     FROM sales WHERE employee_id = e.id
-- ) AS s;
