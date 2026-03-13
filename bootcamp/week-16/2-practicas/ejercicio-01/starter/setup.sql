-- Semana 16: Índices y Funciones — Ejercicio 01 (setup)
-- PostgreSQL 16
-- ============================================

DROP TABLE IF EXISTS employees CASCADE;
DROP TABLE IF EXISTS departments CASCADE;

CREATE TABLE departments (
    id   SERIAL PRIMARY KEY,
    name TEXT   NOT NULL
);

CREATE TABLE employees (
    employee_id   SERIAL         PRIMARY KEY,
    first_name    TEXT           NOT NULL,
    last_name     TEXT           NOT NULL,
    email         TEXT           NOT NULL,
    salary        NUMERIC(10, 2) NOT NULL,
    hire_date     DATE           NOT NULL DEFAULT CURRENT_DATE,
    department_id INT            REFERENCES departments (id),
    is_active     BOOLEAN        NOT NULL DEFAULT TRUE
);

INSERT INTO departments (name) VALUES
    ('Engineering'),
    ('Marketing'),
    ('HR'),
    ('Finance');

INSERT INTO employees
    (first_name, last_name, email, salary, hire_date, department_id) VALUES
    ('Ana',     'García',    'ana.garcia@empresa.com',    82000, '2021-03-15', 1),
    ('Carlos',  'Pérez',     'carlos.perez@empresa.com',  76000, '2020-07-01', 1),
    ('Omar',    'Díaz',      'omar.diaz@empresa.com',     76000, '2022-01-10', 1),
    ('Sofia',   'Ramírez',   'sofia.ramirez@empresa.com', 48000, '2023-05-20', 1),
    ('Lucía',   'Méndez',    'lucia.mendez@empresa.com',  65000, '2019-11-08', 2),
    ('Miguel',  'Torres',    'miguel.torres@empresa.com', 58000, '2021-09-14', 2),
    ('Valeria', 'Hernández', 'valeria.h@empresa.com',     90000, '2018-04-22', 4),
    ('Andrés',  'Martínez',  'andres.m@empresa.com',      71000, '2020-12-01', 4),
    ('Isabel',  'Castro',    'isabel.castro@empresa.com', 62000, '2022-08-30', 3),
    ('Diego',   'López',     'diego.lopez@empresa.com',   45000, '2023-02-14', 3);
