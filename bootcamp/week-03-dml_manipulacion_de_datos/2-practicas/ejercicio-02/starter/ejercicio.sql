-- ============================================
-- Semana 03: DML — Ejercicio 02 — UPDATE y DELETE
-- ============================================
-- Ejecuta primero: setup.sql
-- Descomenta cada sección según el paso del README

-- ============================================
-- PASO 1: Actualizar el salario de un empleado
-- ============================================

-- Actualiza el salario de Bob (id=2) a 70000.00:

-- UPDATE employees
-- SET    salary = 70000.00
-- WHERE  id = 2;

-- Verifica el cambio:
-- SELECT id, first_name, salary FROM employees WHERE id = 2;


-- ============================================
-- PASO 2: Actualizar múltiples columnas
-- ============================================

-- Actualiza el salario de Carol (id=3) a 62000.00
-- y corrige su apellido a 'Clark':

-- UPDATE employees
-- SET    salary    = 62000.00,
--        last_name = 'Clark'
-- WHERE  id = 3;

-- SELECT id, first_name, last_name, salary FROM employees WHERE id = 3;


-- ============================================
-- PASO 3: Actualizar varias filas con condición
-- ============================================

-- Aplica un aumento del 10% a todos los empleados del departamento 1:

-- UPDATE employees
-- SET    salary = salary * 1.10
-- WHERE  department_id = 1;

-- SELECT id, first_name, salary, department_id FROM employees
-- WHERE  department_id = 1;


-- ============================================
-- PASO 4: DELETE seguro
-- ============================================

-- Primero verifica qué filas se borrarán:
-- SELECT id, first_name, email FROM employees WHERE department_id = 3;

-- Ahora ejecuta el DELETE con el mismo WHERE:
-- DELETE FROM employees
-- WHERE  department_id = 3;


-- ============================================
-- PASO 5: Estado final
-- ============================================

-- Muestra todos los empleados restantes ordenados por id:

-- SELECT * FROM employees ORDER BY id;
