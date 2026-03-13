-- ============================================
-- Semana 05: Operadores — Ejercicio 01
-- BETWEEN e IN
-- ============================================
-- Ejecuta primero: setup.sql

-- ============================================
-- PASO 1: BETWEEN rango de salario
-- ============================================

-- Empleados con salario entre 60000 y 75000 (ambos inclusive):

-- SELECT first_name, salary
-- FROM   employees
-- WHERE  salary BETWEEN 60000 AND 75000;


-- ============================================
-- PASO 2: NOT BETWEEN
-- ============================================

-- Empleados con salario fuera de ese rango:

-- SELECT first_name, salary
-- FROM   employees
-- WHERE  salary NOT BETWEEN 60000 AND 75000;


-- ============================================
-- PASO 3: IN — lista de departamentos
-- ============================================

-- Empleados de los departamentos 1 o 3:

-- SELECT first_name, department_id
-- FROM   employees
-- WHERE  department_id IN (1, 3);


-- ============================================
-- PASO 4: NOT IN
-- ============================================

-- Empleados que NO pertenecen al departamento 2:

-- SELECT first_name, department_id
-- FROM   employees
-- WHERE  department_id NOT IN (2);
