-- ============================================
-- Semana 18: Funciones y Procedimientos PL/pgSQL
-- Ejercicio 02 — Configuración del esquema
-- Motor: PostgreSQL 16
-- ============================================

DROP TABLE IF EXISTS audit_log;
DROP TABLE IF EXISTS products;

CREATE TABLE products (
    id          SERIAL          PRIMARY KEY,
    name        TEXT            NOT NULL,
    price       NUMERIC(10, 2)  NOT NULL CHECK (price > 0),
    stock       INT             NOT NULL DEFAULT 0 CHECK (stock >= 0),
    category    TEXT            NOT NULL
);

CREATE TABLE audit_log (
    id          SERIAL    PRIMARY KEY,
    action      TEXT      NOT NULL,
    detail      TEXT,
    executed_at TIMESTAMP NOT NULL DEFAULT NOW()
);

INSERT INTO products (name, price, stock, category)
VALUES
    ('Laptop Pro',       1299.99,  5,  'electronics'),
    ('Teclado mecánico',  89.99,  18,  'electronics'),
    ('Monitor 27"',      449.00,   7,  'electronics'),
    ('Escritorio',       320.00,   3,  'furniture'),
    ('Silla ergonómica', 560.00,   2,  'furniture'),
    ('Lámpara LED',       35.50,  22,  'furniture'),
    ('Cuaderno A4',        4.99,  80,  'stationery'),
    ('Bolígrafos x10',     6.50, 120,  'stationery'),
    ('Mochila',           75.00,  15,  'accessories'),
    ('Auriculares BT',   149.99,   9,  'electronics');
