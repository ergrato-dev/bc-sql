-- ============================================
-- Semana 06: Agregación — Ejercicio 02 — Setup
-- ============================================

DROP TABLE IF EXISTS employees;
DROP TABLE IF EXISTS departments;

CREATE TABLE departments (
    id       INTEGER PRIMARY KEY,
    name     TEXT    NOT NULL UNIQUE,
    location TEXT    NOT NULL
);

CREATE TABLE employees (
    id            INTEGER PRIMARY KEY,
    first_name    TEXT    NOT NULL,
    last_name     TEXT    NOT NULL,
    salary        REAL    NOT NULL CHECK (salary > 0),
    department_id INTEGER NOT NULL REFERENCES departments(id)
);

INSERT INTO departments (id, name, location) VALUES
    (1, 'Engineering', 'Floor 3'),
    (2, 'Marketing',   'Floor 1'),
    (3, 'Finance',     'Floor 2');

INSERT INTO employees (id, first_name, last_name, salary, department_id) VALUES
    (1, 'Alice', 'Johnson', 72000.00, 1),
    (2, 'Bob',   'Smith',   65000.00, 1),
    (3, 'Carol', 'White',   58000.00, 2),
    (4, 'Dan',   'Brown',   81000.00, 3),
    (5, 'Eva',   'Green',   69500.00, 2),
    (6, 'Frank', 'Miller',  55000.00, 3),
    (7, 'Grace', 'Davis',   74500.00, 1);
