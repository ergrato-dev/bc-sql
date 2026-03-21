-- Semana 11: Subqueries
-- Ejercicio 01 — Descomenta cada bloque en orden

-- ============================================
-- PASO 1: Subquery escalar en WHERE
-- ============================================

-- Empleados con sueldo sobre el promedio general
-- Descomenta las siguientes líneas:

-- SELECT
--     first_name,
--     salary
-- FROM employees
-- WHERE salary > (SELECT AVG(salary) FROM employees)
-- ORDER BY salary DESC;


-- ============================================
-- PASO 2: Subquery escalar en SELECT
-- ============================================

-- Cada fila muestra el promedio global como columna extra
-- Descomenta las siguientes líneas:

-- SELECT
--     first_name,
--     salary,
--     ROUND((SELECT AVG(salary) FROM employees), 2) AS company_avg
-- FROM employees
-- ORDER BY salary DESC;


-- ============================================
-- PASO 3: Filtrar con IN
-- ============================================

-- Empleados en departamentos activos
-- Descomenta las siguientes líneas:

-- SELECT
--     first_name,
--     department_id
-- FROM employees
-- WHERE department_id IN (
--     SELECT id
--     FROM departments
--     WHERE is_active = 1
-- );


-- ============================================
-- PASO 4: NOT IN con protección NULL
-- ============================================

-- Empleados en departamentos con presupuesto <= 100 000
-- Proteger la subquery contra NULLs con IS NOT NULL
-- Descomenta las siguientes líneas:

-- SELECT first_name
-- FROM employees
-- WHERE department_id NOT IN (
--     SELECT id
--     FROM departments
--     WHERE budget > 100000
--       AND id IS NOT NULL
-- );
