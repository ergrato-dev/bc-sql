-- Semana 12: CTEs y CASE WHEN — Ejercicio 02 (setup)
-- Mismo esquema que ejercicio-01
-- ============================================

PRAGMA foreign_keys = ON;

DROP TABLE IF EXISTS employees;
DROP TABLE IF EXISTS departments;
DROP TABLE IF EXISTS locations;

CREATE TABLE locations (
    id      INTEGER PRIMARY KEY AUTOINCREMENT,
    city    TEXT    NOT NULL,
    country TEXT    NOT NULL DEFAULT 'México'
);

CREATE TABLE departments (
    id          INTEGER PRIMARY KEY AUTOINCREMENT,
    name        TEXT    NOT NULL,
    location_id INTEGER REFERENCES locations (id)
);

CREATE TABLE employees (
    employee_id   INTEGER PRIMARY KEY AUTOINCREMENT,
    first_name    TEXT    NOT NULL,
    last_name     TEXT    NOT NULL,
    salary        REAL    NOT NULL,
    department_id INTEGER REFERENCES departments (id),
    is_active     INTEGER NOT NULL DEFAULT 1 CHECK (is_active IN (0, 1))
);

INSERT INTO locations (city, country) VALUES
    ('Ciudad de México', 'México'),
    ('Guadalajara',      'México'),
    ('Monterrey',        'México');

INSERT INTO departments (name, location_id) VALUES
    ('Engineering',  1),
    ('Marketing',    2),
    ('HR',           3),
    ('Finance',      1);

INSERT INTO employees (first_name, last_name, salary, department_id, is_active) VALUES
    ('Ana',     'García',    82000, 1, 1),
    ('Carlos',  'Pérez',     76000, 1, 1),
    ('Lucía',   'Méndez',    55000, 2, 1),
    ('Miguel',  'Torres',    48000, 2, 1),
    ('Sofia',   'Ramírez',   62000, 3, 1),
    ('Diego',   'López',     45000, 3, 0),
    ('Valeria', 'Hernández', 90000, 4, 1),
    ('Andrés',  'Martínez',  71000, 4, 1),
    ('Carla',   'Sánchez',   39000, 1, 0),
    ('Omar',    'Díaz',      58000, 2, 1);
