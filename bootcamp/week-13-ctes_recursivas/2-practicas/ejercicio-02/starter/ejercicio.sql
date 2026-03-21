-- Semana 13: CTEs Recursivas — Ejercicio 02
-- Ejecuta primero: setup.sql
-- PostgreSQL 16
-- ============================================

-- ============================================
-- PASO 1: Serie numérica del 1 al 10
-- ============================================

-- CTE recursiva que genera los números 1 al 10
-- Caso base: n = 1
-- Caso recursivo: n + 1, parar cuando n < 10
-- Descomenta las siguientes líneas:

-- WITH RECURSIVE serie AS (
--     SELECT 1 AS n
--     UNION ALL
--     SELECT n + 1
--     FROM serie
--     WHERE n < 10
-- )
-- SELECT n FROM serie;


-- ============================================
-- PASO 2: Serie de fechas — primera semana
-- ============================================

-- Genera los 7 días desde 2024-01-01 hasta 2024-01-07
-- Usa INTERVAL '1 day' para incrementar la fecha
-- Descomenta las siguientes líneas:

-- WITH RECURSIVE calendario AS (
--     SELECT CAST('2024-01-01' AS DATE) AS dia
--     UNION ALL
--     SELECT (dia + INTERVAL '1 day')::DATE
--     FROM calendario
--     WHERE dia < '2024-01-07'
-- )
-- SELECT dia FROM calendario;


-- ============================================
-- PASO 3: Calendario con ventas — días sin actividad
-- ============================================

-- Une el calendario con daily_sales usando LEFT JOIN
-- COALESCE garantiza que los días sin ventas muestren 0
-- Descomenta las siguientes líneas:

-- WITH RECURSIVE calendario AS (
--     SELECT CAST('2024-01-01' AS DATE) AS dia
--     UNION ALL
--     SELECT (dia + INTERVAL '1 day')::DATE
--     FROM calendario
--     WHERE dia < '2024-01-07'
-- )
-- SELECT
--     c.dia                      AS fecha,
--     COALESCE(SUM(s.amount), 0) AS total_ventas,
--     COALESCE(COUNT(s.id), 0)   AS num_transacciones
-- FROM calendario c
-- LEFT JOIN daily_sales s ON s.sale_date = c.dia
-- GROUP BY c.dia
-- ORDER BY c.dia;


-- ============================================
-- PASO 4: generate_series() — alternativa PostgreSQL
-- ============================================

-- Reemplaza el CTE recursivo por generate_series()
-- Más eficiente en PostgreSQL para series grandes
-- Descomenta las siguientes líneas:

-- SELECT
--     gs.dia::DATE               AS fecha,
--     COALESCE(SUM(s.amount), 0) AS total_ventas
-- FROM generate_series(
--     '2024-01-01'::DATE,
--     '2024-01-07'::DATE,
--     '1 day'::INTERVAL
-- ) AS gs(dia)
-- LEFT JOIN daily_sales s ON s.sale_date = gs.dia::DATE
-- GROUP BY gs.dia
-- ORDER BY gs.dia;
