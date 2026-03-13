-- ============================================
-- Semana 08: Capstone — Ejercicio 01
-- DDL + DML integrado (3 tablas)
-- ============================================
-- Ejecuta primero: setup.sql

-- ============================================
-- PASO 1: Activar FK + crear locations
-- ============================================

-- PRAGMA foreign_keys = ON;

-- CREATE TABLE locations (
--     id      INTEGER PRIMARY KEY,
--     name    TEXT    NOT NULL UNIQUE,
--     country TEXT    NOT NULL DEFAULT 'Colombia'
-- );


-- ============================================
-- PASO 2: Crear departments con FK
-- ============================================

-- CREATE TABLE departments (
--     id          INTEGER PRIMARY KEY,
--     name        TEXT    NOT NULL UNIQUE,
--     budget      REAL    CHECK (budget > 0),
--     location_id INTEGER NOT NULL
--         REFERENCES locations(id) ON DELETE RESTRICT
-- );


-- ============================================
-- PASO 3: Crear employees con constraints
-- ============================================

-- CREATE TABLE employees (
--     id            INTEGER PRIMARY KEY,
--     first_name    TEXT    NOT NULL,
--     last_name     TEXT    NOT NULL,
--     email         TEXT    UNIQUE,
--     salary        REAL    NOT NULL CHECK (salary > 0),
--     level         TEXT    CHECK (level IN ('junior', 'mid', 'senior')),
--     is_active     INTEGER NOT NULL DEFAULT 1,
--     department_id INTEGER NOT NULL
--         REFERENCES departments(id) ON DELETE RESTRICT
-- );


-- ============================================
-- PASO 4: Insertar datos y verificar
-- ============================================

-- INSERT INTO locations (id, name) VALUES
--     (1, 'Bogotá'),
--     (2, 'Medellín');

-- INSERT INTO departments (id, name, budget, location_id) VALUES
--     (1, 'Engineering', 500000.00, 1),
--     (2, 'Marketing',   200000.00, 2),
--     (3, 'Finance',     300000.00, 1);

-- INSERT INTO employees
--     (id, first_name, last_name, email, salary, level, department_id)
-- VALUES
--     (1, 'Alice',  'Johnson', 'alice@co.com', 72000.00, 'senior', 1),
--     (2, 'Bob',    'Smith',   NULL,            65000.00, 'mid',    1),
--     (3, 'Carol',  'White',   'carol@co.com', 58000.00, 'junior', 2),
--     (4, 'Dan',    'Brown',   'dan@co.com',   81000.00, 'senior', 3),
--     (5, 'Eva',    'Green',   NULL,            69500.00, 'mid',    2);

-- Verificar estructura:
-- PRAGMA table_info(employees);
-- SELECT COUNT(*) FROM employees;
