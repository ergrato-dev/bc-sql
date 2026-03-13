-- ============================================
-- Semana 05: Operadores — Ejercicio 02
-- LIKE y filtros combinados
-- ============================================
-- Ejecuta primero: setup.sql

-- ============================================
-- PASO 1: LIKE con % al final
-- ============================================

-- Empleados cuyo nombre empieza con 'A':

-- SELECT first_name, email
-- FROM   employees
-- WHERE  first_name LIKE 'A%';


-- ============================================
-- PASO 2: LIKE con % en ambos extremos
-- ============================================

-- Empleados cuyo apellido contiene la letra 'i':

-- SELECT first_name, last_name
-- FROM   employees
-- WHERE  last_name LIKE '%i%';


-- ============================================
-- PASO 3: LIKE con _ (un carácter exacto)
-- ============================================

-- Empleados cuya segunda letra del nombre es 'r':

-- SELECT first_name
-- FROM   employees
-- WHERE  first_name LIKE '_r%';


-- ============================================
-- PASO 4: Filtro combinado — BETWEEN + IN + LIKE
-- ============================================

-- Empleados de los deptos 1 o 2, con salario entre 60k y 80k
-- y apellido que contiene 'i':

-- SELECT first_name, last_name, salary, department_id
-- FROM   employees
-- WHERE  department_id IN (1, 2)
--   AND  salary BETWEEN 60000 AND 80000
--   AND  last_name LIKE '%i%';
