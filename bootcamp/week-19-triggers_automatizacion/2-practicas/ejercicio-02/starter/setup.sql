-- ============================================
-- Semana 19: Triggers
-- Ejercicio 02 — Configuración del esquema
-- Motor: PostgreSQL 16
-- ============================================

DROP TABLE IF EXISTS price_history;
DROP TABLE IF EXISTS products;

CREATE TABLE products (
    id          SERIAL          PRIMARY KEY,
    name        TEXT            NOT NULL,
    price       NUMERIC(10, 2)  NOT NULL CHECK (price > 0),
    stock       INT             NOT NULL DEFAULT 0 CHECK (stock >= 0),
    category    TEXT            NOT NULL
);

CREATE TABLE price_history (
    id          SERIAL          PRIMARY KEY,
    product_id  INT             NOT NULL REFERENCES products (id),
    old_price   NUMERIC(10, 2)  NOT NULL,
    new_price   NUMERIC(10, 2)  NOT NULL,
    changed_at  TIMESTAMP       NOT NULL DEFAULT NOW()
);

INSERT INTO products (name, price, stock, category)
VALUES
    ('LAPTOP PRO',       1299.99,  5,  'electronics'),
    ('TECLADO MECANICO',  89.99,  18,  'electronics'),
    ('MONITOR 27',       449.00,   7,  'electronics'),
    ('ESCRITORIO',       320.00,   3,  'furniture'),
    ('SILLA ERGONOMICA', 560.00,   2,  'furniture');
