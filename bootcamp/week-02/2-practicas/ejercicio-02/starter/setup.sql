-- ============================================
-- Semana 02: DDL — Diseño de Esquemas
-- Setup — Ejercicio 02
-- ============================================

DROP TABLE IF EXISTS employees;
DROP TABLE IF EXISTS departments;

CREATE TABLE IF NOT EXISTS departments (
    id   INTEGER PRIMARY KEY,
    name TEXT    NOT NULL UNIQUE
);

-- Tabla employees con columnas básicas (incompleta a propósito)
CREATE TABLE IF NOT EXISTS employees (
    id         INTEGER PRIMARY KEY,
    first_name TEXT    NOT NULL,
    last_name  TEXT    NOT NULL,
    email      TEXT    NOT NULL UNIQUE,
    salary     REAL    NOT NULL DEFAULT 0.00 CHECK (salary >= 0)
);

-- Datos de prueba
INSERT INTO departments (id, name) VALUES (1, 'engineering'), (2, 'marketing');

INSERT INTO employees (id, first_name, last_name, email, salary) VALUES
    (1, 'Alice',  'Johnson', 'alice@example.com',  72000.00),
    (2, 'Bob',    'Smith',   'bob@example.com',    65000.00),
    (3, 'Carlos', 'Rivera',  'carlos@example.com', 58000.00);
