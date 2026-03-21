-- ============================================
-- Semana 04: SELECT — Ejercicio 01
-- ============================================
-- Ejecuta primero: setup.sql
-- Descomenta cada sección según el paso del README

-- ============================================
-- PASO 1: Seleccionar columnas específicas
-- ============================================

-- Muestra solo first_name, last_name y email de todos los empleados:

-- SELECT first_name, last_name, email
-- FROM   employees;


-- ============================================
-- PASO 2: Alias con AS
-- ============================================

-- Muestra first_name como "nombre", last_name como "apellido"
-- y salary*12 como "salario_anual":

-- SELECT
--     first_name  AS nombre,
--     last_name   AS apellido,
--     salary * 12 AS salario_anual
-- FROM employees;


-- ============================================
-- PASO 3: Filtrar con WHERE
-- ============================================

-- Muestra first_name y salary de empleados del departamento 1:

-- SELECT first_name, salary
-- FROM   employees
-- WHERE  department_id = 1;


-- ============================================
-- PASO 4: Alias + WHERE combinados
-- ============================================

-- Lista nombre, apellido y salario de empleados del departamento 2,
-- usando alias en español para cada columna:

-- SELECT
--     first_name  AS nombre,
--     last_name   AS apellido,
--     salary      AS salario
-- FROM   employees
-- WHERE  department_id = 2;
