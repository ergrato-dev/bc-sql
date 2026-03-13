-- Semana 15: Window Functions Navegación — Ejercicio 02
-- Ejecuta primero: setup.sql
-- PostgreSQL 16
-- ============================================

-- ============================================
-- PASO 1: FIRST_VALUE por departamento
-- ============================================

-- El mayor monto de cada departamento aparece en todas sus filas
-- FIRST_VALUE ordena por amount DESC → la primera = la más alta
-- Descomenta las siguientes líneas:

-- SELECT
--     sale_month,
--     department_id,
--     amount,
--     FIRST_VALUE(amount) OVER (
--         PARTITION BY department_id
--         ORDER BY amount DESC
--     ) AS dept_best
-- FROM monthly_sales
-- ORDER BY department_id, sale_month;


-- ============================================
-- PASO 2: LAST_VALUE con frame extendido
-- ============================================

-- Sin ROWS BETWEEN ... UNBOUNDED FOLLOWING, LAST_VALUE
-- devuelve el valor de la FILA ACTUAL, no el último de la partición
-- Descomenta las siguientes líneas:

-- SELECT
--     sale_month,
--     department_id,
--     amount,
--     LAST_VALUE(amount) OVER (
--         PARTITION BY department_id
--         ORDER BY amount DESC
--         ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
--     ) AS dept_worst
-- FROM monthly_sales
-- ORDER BY department_id, sale_month;


-- ============================================
-- PASO 3: Alias de ventana con WINDOW
-- ============================================

-- WINDOW w AS (...) evita repetir la misma definición
-- Ambas funciones comparten la misma ventana "w"
-- Descomenta las siguientes líneas:

-- SELECT
--     sale_month,
--     department_id,
--     amount,
--     FIRST_VALUE(amount) OVER w AS dept_best,
--     LAST_VALUE(amount)  OVER w AS dept_worst
-- FROM monthly_sales
-- WINDOW w AS (
--     PARTITION BY department_id
--     ORDER BY amount DESC
--     ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
-- )
-- ORDER BY department_id, sale_month;


-- ============================================
-- PASO 4: CREATE VIEW y consulta a la vista
-- ============================================

-- Guarda la consulta como vista reutilizable
-- Luego consulta la vista como si fuera una tabla
-- Descomenta las siguientes líneas:

-- CREATE OR REPLACE VIEW v_dept_sales_analysis AS
-- SELECT
--     sale_month,
--     department_id,
--     amount,
--     FIRST_VALUE(amount) OVER w AS dept_best,
--     LAST_VALUE(amount)  OVER w AS dept_worst
-- FROM monthly_sales
-- WINDOW w AS (
--     PARTITION BY department_id
--     ORDER BY amount DESC
--     ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
-- );

-- SELECT *
-- FROM v_dept_sales_analysis
-- WHERE department_id = 1
-- ORDER BY sale_month;
