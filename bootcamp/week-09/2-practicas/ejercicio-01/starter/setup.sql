-- Semana 09: INNER JOIN
-- Setup: locations + departments + employees

PRAGMA foreign_keys = ON;

-- ============================================
-- TABLA: locations
-- ============================================
DROP TABLE IF EXISTS employees;
DROP TABLE IF EXISTS departments;
DROP TABLE IF EXISTS locations;

CREATE TABLE locations (
    id      INTEGER PRIMARY KEY AUTOINCREMENT,
    name    TEXT    NOT NULL UNIQUE,
    country TEXT    NOT NULL,
    region  TEXT
);

-- ============================================
-- TABLA: departments
-- ============================================
CREATE TABLE departments (
    id          INTEGER PRIMARY KEY AUTOINCREMENT,
    name        TEXT    NOT NULL UNIQUE,
    budget      REAL    NOT NULL CHECK (budget > 0),
    location_id INTEGER REFERENCES locations (id),
    is_active   INTEGER NOT NULL DEFAULT 1
);

-- ============================================
-- TABLA: employees
-- ============================================
CREATE TABLE employees (
    id            INTEGER PRIMARY KEY AUTOINCREMENT,
    first_name    TEXT    NOT NULL,
    last_name     TEXT    NOT NULL,
    email         TEXT    UNIQUE,
    salary        REAL    NOT NULL CHECK (salary > 0),
    level         TEXT    NOT NULL CHECK (level IN ('jr', 'mid', 'sr')),
    is_active     INTEGER NOT NULL DEFAULT 1,
    department_id INTEGER REFERENCES departments (id)
);

-- ============================================
-- DATOS DE PRUEBA
-- ============================================
INSERT INTO locations (name, country, region) VALUES
    ('New York',   'USA',    'East'),
    ('London',     'UK',     'Europe'),
    ('São Paulo',  'Brazil', 'South America');

INSERT INTO departments (name, budget, location_id) VALUES
    ('Engineering',  120000.00, 1),
    ('Marketing',     80000.00, 2),
    ('Sales',         60000.00, 3),
    ('HR',            40000.00, 1);

-- Nota: employee_id 6 tiene department_id = NULL (sin asignación)
INSERT INTO employees (first_name, last_name, email, salary, level, department_id) VALUES
    ('Alice',   'Smith',   'alice@example.com',   85000, 'sr',  1),
    ('Bob',     'Jones',   'bob@example.com',     62000, 'mid', 1),
    ('Carol',   'White',   'carol@example.com',   71000, 'sr',  2),
    ('David',   'Brown',   'david@example.com',   48000, 'jr',  3),
    ('Eve',     'Davis',   'eve@example.com',     55000, 'mid', 3),
    ('Frank',   'Wilson',  'frank@example.com',   90000, 'sr',  NULL);
