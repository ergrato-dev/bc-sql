-- ============================================
-- Semana 08: Capstone — Ejercicio 02 — Setup
-- ============================================

PRAGMA foreign_keys = ON;

DROP TABLE IF EXISTS employees;
DROP TABLE IF EXISTS departments;
DROP TABLE IF EXISTS locations;

CREATE TABLE locations (
    id      INTEGER PRIMARY KEY,
    name    TEXT    NOT NULL UNIQUE,
    country TEXT    NOT NULL DEFAULT 'Colombia'
);

CREATE TABLE departments (
    id          INTEGER PRIMARY KEY,
    name        TEXT    NOT NULL UNIQUE,
    budget      REAL    CHECK (budget > 0),
    location_id INTEGER NOT NULL REFERENCES locations(id)
);

CREATE TABLE employees (
    id            INTEGER PRIMARY KEY,
    first_name    TEXT    NOT NULL,
    last_name     TEXT    NOT NULL,
    email         TEXT    UNIQUE,
    salary        REAL    NOT NULL CHECK (salary > 0),
    level         TEXT    CHECK (level IN ('junior', 'mid', 'senior')),
    is_active     INTEGER NOT NULL DEFAULT 1,
    department_id INTEGER NOT NULL REFERENCES departments(id)
);

INSERT INTO locations VALUES (1, 'Bogotá', 'Colombia'), (2, 'Medellín', 'Colombia');
INSERT INTO departments VALUES
    (1, 'Engineering', 500000.00, 1),
    (2, 'Marketing',   200000.00, 2),
    (3, 'Finance',     300000.00, 1);
INSERT INTO employees (id, first_name, last_name, email, salary, level, is_active, department_id) VALUES
    (1, 'Alice',  'Johnson', 'alice@co.com',  72000.00, 'senior', 1, 1),
    (2, 'Bob',    'Smith',   NULL,             65000.00, 'mid',    1, 1),
    (3, 'Carol',  'White',   'carol@co.com',  58000.00, 'junior', 1, 2),
    (4, 'Dan',    'Brown',   'dan@co.com',    81000.00, 'senior', 1, 3),
    (5, 'Eva',    'Green',   NULL,             69500.00, 'mid',    1, 2),
    (6, 'Frank',  'Miller',  'frank@co.com',  55000.00, 'junior', 0, 3),
    (7, 'Grace',  'Davis',   'grace@co.com',  74500.00, 'senior', 1, 1);
