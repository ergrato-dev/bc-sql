-- Semana 15: Window Functions Navegación — Ejercicio 02 (setup)
-- PostgreSQL 16
-- Reutiliza el esquema del ejercicio 01
-- ============================================

DROP TABLE IF EXISTS monthly_sales CASCADE;
DROP TABLE IF EXISTS departments CASCADE;

CREATE TABLE departments (
    id   SERIAL PRIMARY KEY,
    name TEXT   NOT NULL
);

CREATE TABLE monthly_sales (
    id            SERIAL         PRIMARY KEY,
    sale_month    DATE           NOT NULL,
    department_id INT            REFERENCES departments (id),
    amount        NUMERIC(12, 2) NOT NULL
);

INSERT INTO departments (name) VALUES
    ('Engineering'),
    ('Marketing');

INSERT INTO monthly_sales (sale_month, department_id, amount) VALUES
    ('2024-01-01', 1, 45000),
    ('2024-02-01', 1, 52000),
    ('2024-03-01', 1, 48000),
    ('2024-04-01', 1, 61000),
    ('2024-05-01', 1, 58000),
    ('2024-06-01', 1, 67000),
    ('2024-01-01', 2, 32000),
    ('2024-02-01', 2, 29000),
    ('2024-03-01', 2, 35000),
    ('2024-04-01', 2, 38000),
    ('2024-05-01', 2, 42000),
    ('2024-06-01', 2, 44000);
