-- ============================================
-- Semana 19: Triggers
-- Ejercicio 01 — Configuración del esquema
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
    table_name  TEXT      NOT NULL,
    action      TEXT      NOT NULL,
    record_id   INT,
    detail      TEXT,
    executed_at TIMESTAMP NOT NULL DEFAULT NOW()
);

INSERT INTO products (name, price, stock, category)
VALUES
    ('Laptop Pro',       1299.99,  5,  'electronics'),
    ('Teclado mecánico',  89.99,  18,  'electronics'),
    ('Monitor 27"',      449.00,   7,  'electronics'),
    ('Escritorio',       320.00,   3,  'furniture'),
    ('Silla ergonómica', 560.00,   2,  'furniture');
