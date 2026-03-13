-- Semana 14: Window Functions — Ejercicio 02
-- Ejecuta primero: setup.sql
-- PostgreSQL 16
-- ============================================

-- ============================================
-- PASO 1: DENSE_RANK() por departamento
-- ============================================

-- Clasifica por salario dentro de cada departamento
-- Los empates comparten el mismo número sin saltarse posiciones
-- Descomenta las siguientes líneas:

-- SELECT
--     first_name,
--     department_id,
--     salary,
--     DENSE_RANK() OVER (
--         PARTITION BY department_id
--         ORDER BY salary DESC
--     ) AS dept_rank
-- FROM employees
-- ORDER BY department_id, salary DESC;


-- ============================================
-- PASO 2: El más alto por departamento (top-1)
-- ============================================

-- No se puede filtrar por dept_rank en el mismo SELECT
-- Solución: CTE que calcula el rank, luego WHERE dept_rank = 1
-- Descomenta las siguientes líneas:

-- WITH ranked AS (
--     SELECT
--         first_name,
--         department_id,
--         salary,
--         DENSE_RANK() OVER (
--             PARTITION BY department_id
--             ORDER BY salary DESC
--         ) AS dept_rank
--     FROM employees
-- )
-- SELECT first_name, department_id, salary
-- FROM ranked
-- WHERE dept_rank = 1;


-- ============================================
-- PASO 3: Top-2 por departamento
-- ============================================

-- Filtra WHERE dept_rank <= 2 para obtener los dos primeros
-- Si hay empate en la posición 2, aparecerán ambos
-- Descomenta las siguientes líneas:

-- WITH ranked AS (
--     SELECT
--         first_name,
--         department_id,
--         salary,
--         DENSE_RANK() OVER (
--             PARTITION BY department_id
--             ORDER BY salary DESC
--         ) AS dept_rank
--     FROM employees
-- )
-- SELECT first_name, department_id, salary, dept_rank
-- FROM ranked
-- WHERE dept_rank <= 2
-- ORDER BY department_id, dept_rank;


-- ============================================
-- PASO 4: Top-3 global de la empresa
-- ============================================

-- Sin PARTITION BY el ranking es global (toda la empresa)
-- DENSE_RANK asegura que los empates no salten posición
-- Descomenta las siguientes líneas:

-- WITH global_ranked AS (
--     SELECT
--         first_name,
--         salary,
--         DENSE_RANK() OVER (ORDER BY salary DESC) AS company_rank
--     FROM employees
-- )
-- SELECT first_name, salary, company_rank
-- FROM global_ranked
-- WHERE company_rank <= 3
-- ORDER BY company_rank;
