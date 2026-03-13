-- Semana 10: SELF JOIN
-- Setup: employees con manager_id auto-referencial
-- Jerarquía: CEO → 2 managers → 4 empleados

PRAGMA foreign_keys = ON;

DROP TABLE IF EXISTS employees;

CREATE TABLE employees (
    id         INTEGER PRIMARY KEY,
    first_name TEXT    NOT NULL,
    last_name  TEXT    NOT NULL,
    salary     REAL    NOT NULL CHECK (salary > 0),
    level      TEXT    NOT NULL CHECK (level IN ('jr', 'mid', 'sr', 'mgr', 'dir')),
    manager_id INTEGER REFERENCES employees (id)  -- auto-referencial
);

-- ============================================
-- DATOS DE PRUEBA
-- Diana Fox: CEO (nivel dir, sin manager)
-- Alice Smith, Bob Jones: managers (nivel mgr)
-- Carol, David, Eve, Frank: empleados (nivel mid/jr)
-- ============================================

-- CEO primero (sin manager_id)
INSERT INTO employees (first_name, last_name, salary, level, manager_id)
VALUES ('Diana', 'Fox', 150000, 'dir', NULL);

-- Managers (reportan a Diana: id=1)
INSERT INTO employees (first_name, last_name, salary, level, manager_id)
VALUES ('Alice', 'Smith', 110000, 'mgr', 1);

INSERT INTO employees (first_name, last_name, salary, level, manager_id)
VALUES ('Bob', 'Jones', 105000, 'mgr', 1);

-- Empleados de Alice (id=2)
INSERT INTO employees (first_name, last_name, salary, level, manager_id)
VALUES ('Carol', 'White', 75000, 'sr', 2);

INSERT INTO employees (first_name, last_name, salary, level, manager_id)
VALUES ('David', 'Brown', 55000, 'mid', 2);

-- Empleados de Bob (id=3)
INSERT INTO employees (first_name, last_name, salary, level, manager_id)
VALUES ('Eve', 'Davis', 62000, 'mid', 3);

INSERT INTO employees (first_name, last_name, salary, level, manager_id)
VALUES ('Frank', 'Wilson', 48000, 'jr', 3);
