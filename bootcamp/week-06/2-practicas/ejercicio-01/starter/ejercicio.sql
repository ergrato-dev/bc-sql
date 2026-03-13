-- ============================================
-- Semana 06: Agregación — Ejercicio 01
-- COUNT, SUM, AVG, MIN, MAX
-- ============================================
-- Ejecuta primero: setup.sql

-- ============================================
-- PASO 1: COUNT — total de empleados
-- ============================================

-- SELECT COUNT(*) AS total_empleados
-- FROM   employees;


-- ============================================
-- PASO 2: SUM y AVG del salario
-- ============================================

-- SELECT
--     SUM(salary) AS masa_salarial,
--     AVG(salary) AS salario_promedio
-- FROM employees;


-- ============================================
-- PASO 3: MIN y MAX
-- ============================================

-- SELECT
--     MIN(salary) AS salario_minimo,
--     MAX(salary) AS salario_maximo
-- FROM employees;


-- ============================================
-- PASO 4: Agregación con WHERE
-- ============================================

-- Calcula el promedio salarial del departamento 1 (Engineering):

-- SELECT AVG(salary) AS promedio_engineering
-- FROM   employees
-- WHERE  department_id = 1;
