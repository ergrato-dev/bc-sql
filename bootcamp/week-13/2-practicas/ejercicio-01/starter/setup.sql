-- Semana 13: CTEs Recursivas — Ejercicio 01 (setup)
-- PostgreSQL 16
-- ============================================

DROP TABLE IF EXISTS employees CASCADE;

CREATE TABLE employees (
    employee_id  SERIAL  PRIMARY KEY,
    first_name   TEXT    NOT NULL,
    job_title    TEXT    NOT NULL,
    salary       NUMERIC(10, 2) NOT NULL,
    manager_id   INT     REFERENCES employees (employee_id)
);

-- Nivel 1: CEO (sin manager)
INSERT INTO employees (first_name, job_title, salary, manager_id) VALUES
    ('Laura',   'CEO',                  120000, NULL);

-- Nivel 2: Directores reportan a Laura (id=1)
INSERT INTO employees (first_name, job_title, salary, manager_id) VALUES
    ('Ana',     'Engineering Director', 95000,  1),
    ('Carlos',  'Finance Director',     92000,  1),
    ('Isabel',  'Marketing Director',   88000,  1);

-- Nivel 3: Reportan a Ana (id=2)
INSERT INTO employees (first_name, job_title, salary, manager_id) VALUES
    ('Miguel',  'Senior Dev',           78000,  2),
    ('Sofia',   'QA Lead',              72000,  2),
    ('Andrés',  'DevOps',               75000,  2);

-- Nivel 3: Reportan a Carlos (id=3)
INSERT INTO employees (first_name, job_title, salary, manager_id) VALUES
    ('Lucía',   'Financial Analyst',    65000,  3),
    ('Diego',   'Accountant',           58000,  3);

-- Nivel 3: Reportan a Isabel (id=4)
INSERT INTO employees (first_name, job_title, salary, manager_id) VALUES
    ('Valeria', 'Marketing Specialist', 62000,  4);

-- Nivel 4: Reportan a Miguel (id=5)
INSERT INTO employees (first_name, job_title, salary, manager_id) VALUES
    ('Omar',    'Junior Dev',           48000,  5),
    ('Carla',   'Junior Dev',           47000,  5);
