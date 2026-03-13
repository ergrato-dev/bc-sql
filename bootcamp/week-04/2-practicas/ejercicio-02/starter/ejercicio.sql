-- ============================================
-- Semana 04: SELECT — Ejercicio 02
-- ORDER BY, LIMIT y OFFSET
-- ============================================
-- Ejecuta primero: setup.sql
-- Descomenta cada sección según el paso del README

-- ============================================
-- PASO 1: ORDER BY simple
-- ============================================

-- Lista first_name y salary ordenados por salario de mayor a menor:

-- SELECT first_name, salary
-- FROM   employees
-- ORDER BY salary DESC;


-- ============================================
-- PASO 2: ORDER BY múltiples columnas
-- ============================================

-- Lista first_name, last_name y department_id
-- ordenados por departamento ASC y luego por apellido ASC:

-- SELECT first_name, last_name, department_id
-- FROM   employees
-- ORDER BY department_id ASC,
--          last_name     ASC;


-- ============================================
-- PASO 3: Top-3 salarios más altos
-- ============================================

-- Muestra los 3 empleados con mayor salario:

-- SELECT first_name, salary
-- FROM   employees
-- ORDER BY salary DESC
-- LIMIT 3;


-- ============================================
-- PASO 4: Paginación (2 empleados por página)
-- ============================================

-- Página 1 (primeros 2):
-- SELECT first_name, salary
-- FROM   employees
-- ORDER BY salary DESC
-- LIMIT  2
-- OFFSET 0;

-- Página 2 (siguientes 2):
-- SELECT first_name, salary
-- FROM   employees
-- ORDER BY salary DESC
-- LIMIT  2
-- OFFSET 2;

-- Página 3 (últimos):
-- SELECT first_name, salary
-- FROM   employees
-- ORDER BY salary DESC
-- LIMIT  2
-- OFFSET 4;
