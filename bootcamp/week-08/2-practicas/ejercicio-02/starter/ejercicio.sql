-- ============================================
-- Semana 08: Capstone — Ejercicio 02
-- 5 reportes analíticos integrados
-- ============================================
-- Ejecuta primero: setup.sql

-- ============================================
-- PASO 1: Totales por departamento
-- ============================================

-- SELECT
--     department_id,
--     COUNT(*)               AS total,
--     ROUND(AVG(salary), 2)  AS promedio_salarial
-- FROM   employees
-- WHERE  is_active = 1
-- GROUP BY department_id
-- ORDER BY promedio_salarial DESC;


-- ============================================
-- PASO 2: Empleados sin email
-- ============================================

-- SELECT
--     first_name,
--     last_name,
--     COALESCE(email, 'N/A') AS email_display
-- FROM   employees
-- WHERE  email IS NULL;


-- ============================================
-- PASO 3: Top 3 salarios activos
-- ============================================

-- SELECT first_name, last_name, salary
-- FROM   employees
-- WHERE  is_active = 1
-- ORDER BY salary DESC
-- LIMIT 3;


-- ============================================
-- PASO 4: Departamentos con >1 activo (HAVING)
-- ============================================

-- SELECT department_id, COUNT(*) AS activos
-- FROM   employees
-- WHERE  is_active = 1
-- GROUP BY department_id
-- HAVING activos > 1;


-- ============================================
-- PASO 5: Rango de salario y nivel
-- ============================================

-- SELECT first_name, salary, level
-- FROM   employees
-- WHERE  salary BETWEEN 60000 AND 80000
--   AND  level IN ('mid', 'senior')
-- ORDER BY level, salary DESC;
