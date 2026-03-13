-- ============================================
-- Semana 03: DML — Ejercicio 01 — Setup
-- Recrea el esquema limpio de employees + departments
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
