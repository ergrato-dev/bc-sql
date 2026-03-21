-- ============================================
-- Semana 07: Constraints — Ejercicio 02 — Setup
-- ============================================

-- Activar cumplimiento de claves foráneas en SQLite
PRAGMA foreign_keys = ON;

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
    email         TEXT    UNIQUE,
    salary        REAL    NOT NULL CHECK (salary > 0),
    bonus         REAL,
    level         TEXT    CHECK (level IN ('junior', 'mid', 'senior')),
    is_active     INTEGER NOT NULL DEFAULT 1,
    department_id INTEGER NOT NULL
        REFERENCES departments(id) ON DELETE RESTRICT
);

INSERT INTO departments (id, name, location) VALUES
    (1, 'Engineering', 'Floor 3'),
    (2, 'Marketing',   'Floor 1'),
    (3, 'Finance',     'Floor 2');

INSERT INTO employees
    (id, first_name, last_name, email, salary, bonus, level, department_id)
VALUES
    (1, 'Alice', 'Johnson', 'alice@co.com', 72000.00, 1200.00, 'senior', 1),
    (2, 'Bob',   'Smith',   NULL,           65000.00,  800.00, 'mid',    1),
    (3, 'Carol', 'White',   'carol@co.com', 58000.00,     NULL, 'junior', 2),
    (4, 'Dan',   'Brown',   'dan@co.com',   81000.00, 2000.00, 'senior', 3),
    (5, 'Eva',   'Green',   NULL,           69500.00,     NULL, 'mid',    2);
