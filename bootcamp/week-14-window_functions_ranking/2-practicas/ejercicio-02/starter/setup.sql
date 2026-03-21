-- Semana 14: Window Functions — Ejercicio 02 (setup)
-- PostgreSQL 16
-- Reutiliza el mismo esquema del ejercicio 01
-- ============================================

DROP TABLE IF EXISTS employees CASCADE;
DROP TABLE IF EXISTS departments CASCADE;

CREATE TABLE departments (
    id   SERIAL PRIMARY KEY,
    name TEXT   NOT NULL
);

CREATE TABLE employees (
    employee_id   SERIAL  PRIMARY KEY,
    first_name    TEXT    NOT NULL,
    last_name     TEXT    NOT NULL,
    salary        NUMERIC(10, 2) NOT NULL,
    department_id INT     REFERENCES departments (id),
    is_active     BOOLEAN NOT NULL DEFAULT TRUE
);

INSERT INTO departments (name) VALUES
    ('Engineering'),
    ('Marketing'),
    ('HR'),
    ('Finance');

INSERT INTO employees (first_name, last_name, salary, department_id, is_active) VALUES
    ('Ana',     'García',    82000, 1, TRUE),
    ('Carlos',  'Pérez',     76000, 1, TRUE),
    ('Omar',    'Díaz',      76000, 1, TRUE),   -- empate en Engineering
    ('Sofia',   'Ramírez',   48000, 1, TRUE),
    ('Lucía',   'Méndez',    65000, 2, TRUE),
    ('Miguel',  'Torres',    58000, 2, TRUE),
    ('Valeria', 'Hernández', 90000, 4, TRUE),
    ('Andrés',  'Martínez',  71000, 4, TRUE),
    ('Isabel',  'Castro',    62000, 3, TRUE),
    ('Diego',   'López',     45000, 3, FALSE);
