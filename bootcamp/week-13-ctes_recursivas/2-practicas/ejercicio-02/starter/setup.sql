-- Semana 13: CTEs Recursivas — Ejercicio 02 (setup)
-- PostgreSQL 16
-- ============================================

DROP TABLE IF EXISTS daily_sales;

CREATE TABLE daily_sales (
    id        SERIAL  PRIMARY KEY,
    sale_date DATE    NOT NULL,
    amount    NUMERIC(10, 2) NOT NULL CHECK (amount > 0),
    category  TEXT    NOT NULL
);

-- Ventas de la primera semana de enero 2024
-- Nota: el 3 y el 6 no tienen ventas (días sin actividad)
INSERT INTO daily_sales (sale_date, amount, category) VALUES
    ('2024-01-01', 1500.00, 'Electronics'),
    ('2024-01-01',  800.00, 'Clothing'),
    ('2024-01-02', 2200.00, 'Electronics'),
    ('2024-01-02',  350.00, 'Food'),
    ('2024-01-04', 1100.00, 'Electronics'),
    ('2024-01-04',  620.00, 'Clothing'),
    ('2024-01-05', 1750.00, 'Food'),
    ('2024-01-07', 3000.00, 'Electronics'),
    ('2024-01-07',  450.00, 'Clothing');
