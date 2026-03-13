-- Semana 11: Subqueries
-- Setup: locations + departments + employees
-- Un departamento inactivo para demostrar IN/NOT IN

PRAGMA foreign_keys = ON;

DROP TABLE IF EXISTS employees;
DROP TABLE IF EXISTS departments;
DROP TABLE IF EXISTS locations;

CREATE TABLE locations (
    id      INTEGER PRIMARY KEY AUTOINCREMENT,
    name    TEXT    NOT NULL UNIQUE,
    country TEXT    NOT NULL
);

CREATE TABLE departments (
    id          INTEGER PRIMARY KEY AUTOINCREMENT,
    name        TEXT    NOT NULL UNIQUE,
    budget      REAL    NOT NULL CHECK (budget > 0),
    location_id INTEGER REFERENCES locations (id),
    is_active   INTEGER NOT NULL DEFAULT 1
);

CREATE TABLE employees (
    id            INTEGER PRIMARY KEY AUTOINCREMENT,
    first_name    TEXT    NOT NULL,
    last_name     TEXT    NOT NULL,
    salary        REAL    NOT NULL CHECK (salary > 0),
    level         TEXT    NOT NULL CHECK (level IN ('jr', 'mid', 'sr')),
    department_id INTEGER REFERENCES departments (id)
);

-- ============================================
-- DATOS DE PRUEBA
-- Engineering: budget > 100 000
-- Legacy: inactivo (is_active = 0)
-- ============================================
INSERT INTO locations (name, country) VALUES
    ('New York', 'USA'),
    ('London',   'UK');

INSERT INTO departments (name, budget, location_id, is_active) VALUES
    ('Engineering',  130000.00, 1, 1),
    ('Marketing',     75000.00, 2, 1),
    ('Sales',         60000.00, 1, 1),
    ('Legacy',        20000.00, 2, 0);  -- inactivo

-- Promedio salarial aproximado: ~67 400
INSERT INTO employees (first_name, last_name, salary, level, department_id)
VALUES
    ('Alice',  'Smith',  90000, 'sr',  1),
    ('Bob',    'Jones',  70000, 'mid', 1),
    ('Carol',  'White',  55000, 'jr',  2),
    ('David',  'Brown',  82000, 'sr',  2),
    ('Eve',    'Davis',  48000, 'jr',  3),
    ('Frank',  'Wilson', 63000, 'mid', 4);  -- depto inactivo
