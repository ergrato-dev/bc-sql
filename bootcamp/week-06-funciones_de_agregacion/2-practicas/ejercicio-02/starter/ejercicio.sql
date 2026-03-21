-- ============================================
-- Semana 06: Agregación — Ejercicio 02
-- GROUP BY y HAVING
-- ============================================
-- Ejecuta primero: setup.sql

-- ============================================
-- PASO 1: GROUP BY básico
-- ============================================

-- Cuenta cuántos empleados hay en cada departamento:

-- SELECT
--     department_id,
--     COUNT(*) AS total
-- FROM   employees
-- GROUP BY department_id
-- ORDER BY total DESC;


-- ============================================
-- PASO 2: GROUP BY con múltiples funciones
-- ============================================

-- Muestra department_id, total de empleados, promedio y masa salarial:

-- SELECT
--     department_id,
--     COUNT(*)               AS total,
--     ROUND(AVG(salary), 2)  AS promedio,
--     SUM(salary)            AS masa_salarial
-- FROM   employees
-- GROUP BY department_id;


-- ============================================
-- PASO 3: HAVING — filtrar grupos
-- ============================================

-- Muestra solo departamentos con más de 1 empleado:

-- SELECT department_id, COUNT(*) AS total
-- FROM   employees
-- GROUP BY department_id
-- HAVING COUNT(*) > 1;


-- ============================================
-- PASO 4: WHERE + GROUP BY + HAVING
-- ============================================

-- Departamentos con promedio > 65000,
-- considerando solo empleados con salary > 55000:

-- SELECT
--     department_id,
--     ROUND(AVG(salary), 2) AS promedio
-- FROM   employees
-- WHERE  salary > 55000
-- GROUP BY department_id
-- HAVING AVG(salary) > 65000
-- ORDER BY promedio DESC;
