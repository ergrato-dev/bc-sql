-- Semana 14: Window Functions — Ejercicio 01
-- Ejecuta primero: setup.sql
-- PostgreSQL 16
-- ============================================

-- ============================================
-- PASO 1: ROW_NUMBER() global — sin PARTITION BY
-- ============================================

-- Numera todos los empleados por salario descendente
-- row_num 1 = el de mayor salario en toda la empresa
-- Descomenta las siguientes líneas:

-- SELECT
--     first_name,
--     salary,
--     ROW_NUMBER() OVER (ORDER BY salary DESC) AS global_rank
-- FROM employees
-- ORDER BY salary DESC;


-- ============================================
-- PASO 2: ROW_NUMBER() con PARTITION BY
-- ============================================

-- La numeración reinicia en 1 para cada departamento
-- Agrupa por department_id, ordena por salary DESC dentro del grupo
-- Descomenta las siguientes líneas:

-- SELECT
--     first_name,
--     department_id,
--     salary,
--     ROW_NUMBER() OVER (
--         PARTITION BY department_id
--         ORDER BY salary DESC
--     ) AS dept_row_num
-- FROM employees
-- ORDER BY department_id, salary DESC;


-- ============================================
-- PASO 3: RANK() — compara con ROW_NUMBER()
-- ============================================

-- Carlos y Omar tienen el mismo salario (76000)
-- RANK() les asigna el mismo rango; ROW_NUMBER() los diferencia
-- Descomenta las siguientes líneas:

-- SELECT
--     first_name,
--     salary,
--     ROW_NUMBER() OVER (ORDER BY salary DESC) AS row_num,
--     RANK()       OVER (ORDER BY salary DESC) AS rnk
-- FROM employees
-- ORDER BY salary DESC;


-- ============================================
-- PASO 4: Las tres funciones en paralelo
-- ============================================

-- Observa cómo difieren con los empleados empatados en 76000
-- ROW_NUMBER: 2, 3 / RANK: 2, 2 / DENSE_RANK: 2, 2
-- Descomenta las siguientes líneas:

-- SELECT
--     first_name,
--     salary,
--     ROW_NUMBER() OVER (ORDER BY salary DESC) AS row_num,
--     RANK()       OVER (ORDER BY salary DESC) AS rnk,
--     DENSE_RANK() OVER (ORDER BY salary DESC) AS dense_rnk
-- FROM employees
-- ORDER BY salary DESC;
