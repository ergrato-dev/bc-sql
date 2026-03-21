-- ============================================
-- Semana 20: LATERAL Joins
-- Ejercicio 01 — Configuración del esquema
-- Motor: PostgreSQL 16
-- ============================================

DROP TABLE IF EXISTS sales;
DROP TABLE IF EXISTS employees;
DROP TABLE IF EXISTS departments;

CREATE TABLE departments (
    id      SERIAL  PRIMARY KEY,
    name    TEXT    NOT NULL
);

CREATE TABLE employees (
    id              SERIAL  PRIMARY KEY,
    name            TEXT    NOT NULL,
    department_id   INT     NOT NULL REFERENCES departments (id)
);

CREATE TABLE sales (
    id              SERIAL          PRIMARY KEY,
    employee_id     INT             NOT NULL REFERENCES employees (id),
    product_name    TEXT            NOT NULL,
    amount          NUMERIC(10, 2)  NOT NULL CHECK (amount > 0),
    sale_date       DATE            NOT NULL
);

INSERT INTO departments (name) VALUES ('Ventas'), ('Tecnología'), ('Marketing');

INSERT INTO employees (name, department_id)
VALUES
    ('Ana García',    1),
    ('Luis Pérez',    1),
    ('Sara Nieto',    2),
    ('Carlos Vega',   2),
    ('Marta Ruiz',    3),
    ('Diego León',    3);

-- Ana
INSERT INTO sales (employee_id, product_name, amount, sale_date)
VALUES
    (1, 'Laptop Pro',      1200.00, '2024-01-10'),
    (1, 'Monitor 4K',       450.00, '2024-02-15'),
    (1, 'Teclado Mecánico',  85.00, '2024-03-20');

-- Luis
INSERT INTO sales (employee_id, product_name, amount, sale_date)
VALUES
    (2, 'Silla Ergonómica',  560.00, '2024-01-05'),
    (2, 'Escritorio',        320.00, '2024-02-28');

-- Sara
INSERT INTO sales (employee_id, product_name, amount, sale_date)
VALUES
    (3, 'Software ERP',    3500.00, '2024-01-18'),
    (3, 'Licencia Cloud',   850.00, '2024-03-01');

-- Carlos — sin ventas (para TEST de LEFT JOIN LATERAL)

-- Marta
INSERT INTO sales (employee_id, product_name, amount, sale_date)
VALUES
    (5, 'Campaña SEO',     1100.00, '2024-02-10'),
    (5, 'Anuncio Digital',  400.00, '2024-03-25'),
    (5, 'Consultoría',      750.00, '2024-04-02');

-- Diego
INSERT INTO sales (employee_id, product_name, amount, sale_date)
VALUES
    (6, 'Diseño UX',        900.00, '2024-01-30');
