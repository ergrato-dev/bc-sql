-- ============================================
-- Semana 04: SELECT — Ejercicio 02 — Setup
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
    email         TEXT    NOT NULL UNIQUE,
    salary        REAL    NOT NULL CHECK (salary > 0),
    department_id INTEGER NOT NULL REFERENCES departments(id)
);

INSERT INTO departments (id, name, location) VALUES
    (1, 'Engineering', 'Floor 3'),
    (2, 'Marketing',   'Floor 1'),
    (3, 'Finance',     'Floor 2');

INSERT INTO employees (id, first_name, last_name, email, salary, department_id) VALUES
    (1, 'Alice', 'Johnson', 'alice@company.com', 72000.00, 1),
    (2, 'Bob',   'Smith',   'bob@company.com',   65000.00, 1),
    (3, 'Carol', 'White',   'carol@company.com', 58000.00, 2),
    (4, 'Dan',   'Brown',   'dan@company.com',   81000.00, 3),
    (5, 'Eva',   'Green',   'eva@company.com',   69500.00, 2);
