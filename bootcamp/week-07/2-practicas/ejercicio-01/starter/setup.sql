-- ============================================
-- Semana 07: NULL — Ejercicio 01 — Setup
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
    email         TEXT    UNIQUE,          -- puede ser NULL
    bonus         REAL,                   -- puede ser NULL
    salary        REAL    NOT NULL CHECK (salary > 0),
    department_id INTEGER NOT NULL REFERENCES departments(id)
);

INSERT INTO departments (id, name, location) VALUES
    (1, 'Engineering', 'Floor 3'),
    (2, 'Marketing',   'Floor 1'),
    (3, 'Finance',     'Floor 2');

INSERT INTO employees
    (id, first_name, last_name, email, bonus, salary, department_id)
VALUES
    (1, 'Alice', 'Johnson', 'alice@co.com',  1200.00, 72000.00, 1),
    (2, 'Bob',   'Smith',   NULL,            800.00,  65000.00, 1),
    (3, 'Carol', 'White',   'carol@co.com',  NULL,    58000.00, 2),
    (4, 'Dan',   'Brown',   'dan@co.com',    2000.00, 81000.00, 3),
    (5, 'Eva',   'Green',   NULL,            NULL,    69500.00, 2),
    (6, 'Frank', 'Miller',  'frank@co.com',  500.00,  55000.00, 3),
    (7, 'Grace', 'Davis',   'grace@co.com',  NULL,    74500.00, 1);
