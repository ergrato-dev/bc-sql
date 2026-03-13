-- ============================================
-- Semana 23: Optimización y EXPLAIN ANALYZE
-- Ejercicio 02 — Setup del esquema
-- Motor: PostgreSQL 16
-- ============================================

DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS customers;

CREATE TABLE customers (
    id      SERIAL      PRIMARY KEY,
    name    TEXT        NOT NULL,
    email   TEXT        NOT NULL UNIQUE,
    region  TEXT        NOT NULL
);

CREATE TABLE orders (
    id             SERIAL          PRIMARY KEY,
    customer_id    INTEGER         NOT NULL REFERENCES customers(id),
    status         TEXT            NOT NULL
                       CHECK (status IN ('pending','processing','completed','cancelled')),
    total_amount   NUMERIC(10, 2)  NOT NULL,
    created_at     DATE            NOT NULL DEFAULT CURRENT_DATE
);

INSERT INTO customers (name, email, region)
SELECT
    'Cliente ' || g,
    'cliente' || g || '@mail.com',
    CASE (g % 4)
        WHEN 0 THEN 'norte'
        WHEN 1 THEN 'sur'
        WHEN 2 THEN 'este'
        ELSE 'oeste'
    END
FROM generate_series(1, 200) AS g;

INSERT INTO orders (customer_id, status, total_amount, created_at)
SELECT
    (random() * 199 + 1)::INTEGER,
    CASE (g % 4)
        WHEN 0 THEN 'pending'
        WHEN 1 THEN 'processing'
        WHEN 2 THEN 'completed'
        ELSE 'cancelled'
    END,
    ROUND((random() * 4900 + 100)::NUMERIC, 2),
    CURRENT_DATE - (random() * 365)::INTEGER
FROM generate_series(1, 2000) AS g;

-- Simular filas muertas con UPDATE masivo
UPDATE orders SET total_amount = total_amount + 0.01;

ANALYZE customers, orders;
