-- Semana 12: CTEs y CASE WHEN — Ejercicio 01
-- Ejecuta primero: setup.sql
-- ============================================

-- ============================================
-- PASO 1: CTE simple — empleados activos
-- ============================================

-- Crea un CTE llamado "activos" con los empleados donde is_active = 1
-- La consulta principal ordena por salario descendente
-- Descomenta las siguientes líneas:

-- WITH activos AS (
--     SELECT
--         employee_id,
--         first_name,
--         last_name,
--         salary,
--         department_id
--     FROM employees
--     WHERE is_active = 1
-- )
-- SELECT first_name, last_name, salary
-- FROM activos
-- ORDER BY salary DESC;


-- ============================================
-- PASO 2: CTE con JOIN en la consulta principal
-- ============================================

-- El CTE pre-filtra activos; el JOIN se hace en la consulta exterior
-- Descomenta las siguientes líneas:

-- WITH activos AS (
--     SELECT employee_id, first_name, salary, department_id
--     FROM employees
--     WHERE is_active = 1
-- )
-- SELECT
--     a.first_name,
--     d.name AS department_name,
--     a.salary
-- FROM activos a
-- INNER JOIN departments d ON a.department_id = d.id
-- ORDER BY d.name, a.salary DESC;


-- ============================================
-- PASO 3: Dos CTEs encadenados
-- ============================================

-- Primer CTE: promedio salarial por departamento
-- Segundo CTE: filtra deptos con avg_sal > 55000
-- Consulta final: empleados en esos deptos
-- Descomenta las siguientes líneas:

-- WITH promedios AS (
--     SELECT
--         department_id,
--         AVG(salary) AS avg_sal
--     FROM employees
--     WHERE is_active = 1
--     GROUP BY department_id
-- ),
-- deptos_premium AS (
--     SELECT department_id
--     FROM promedios
--     WHERE avg_sal > 55000
-- )
-- SELECT
--     e.first_name,
--     e.salary
-- FROM employees e
-- WHERE e.department_id IN (SELECT department_id FROM deptos_premium)
-- ORDER BY e.salary DESC;


-- ============================================
-- PASO 4: CTE que resume, consulta que filtra
-- ============================================

-- El CTE calcula total_employees y avg_salary por depto
-- La consulta principal retorna solo deptos con total_employees >= 2
-- Descomenta las siguientes líneas:

-- WITH resumen_depto AS (
--     SELECT
--         d.name   AS department_name,
--         COUNT(e.employee_id) AS total_employees,
--         ROUND(AVG(e.salary), 2) AS avg_salary
--     FROM departments d
--     LEFT JOIN employees e ON e.department_id = d.id
--     GROUP BY d.id, d.name
-- )
-- SELECT department_name, total_employees, avg_salary
-- FROM resumen_depto
-- WHERE total_employees >= 2
-- ORDER BY avg_salary DESC;
