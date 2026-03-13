-- ============================================
-- Semana 03: DML — Ejercicio 01 — INSERT INTO
-- ============================================
-- Ejecuta primero: setup.sql
-- Descomenta cada sección según el paso del README

-- ============================================
-- PASO 1: Insertar un departamento
-- ============================================

-- Inserta el departamento de Engineering en el piso 3:

-- INSERT INTO departments (id, name, location)
-- VALUES (1, 'Engineering', 'Floor 3');


-- ============================================
-- PASO 2: Insertar múltiples departamentos
-- ============================================

-- Inserta Marketing en Floor 1 y Finance en Floor 2 en una sola sentencia:

-- INSERT INTO departments (id, name, location)
-- VALUES
--     (2, 'Marketing', 'Floor 1'),
--     (3, 'Finance',   'Floor 2');


-- ============================================
-- PASO 3: Insertar empleados
-- ============================================

-- Inserta los siguientes empleados en la tabla employees:
-- id=1  Alice Johnson    alice@company.com   72000  dept=1
-- id=2  Bob   Smith      bob@company.com     65000  dept=1
-- id=3  Carol White      carol@company.com   58000  dept=2
-- id=4  Dan   Brown      dan@company.com     81000  dept=3

-- INSERT INTO employees (id, first_name, last_name, email, salary, department_id)
-- VALUES
--     (1, 'Alice', 'Johnson', 'alice@company.com', 72000.00, 1),
--     (2, 'Bob',   'Smith',   'bob@company.com',   65000.00, 1),
--     (3, 'Carol', 'White',   'carol@company.com', 58000.00, 2),
--     (4, 'Dan',   'Brown',   'dan@company.com',   81000.00, 3);


-- ============================================
-- PASO 4: Verificar los datos insertados
-- ============================================

-- Muestra todas las filas de departments y employees:

-- SELECT * FROM departments;
-- SELECT * FROM employees;
