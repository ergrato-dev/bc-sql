-- ============================================
-- Semana 17: Transacciones y ACID
-- Ejercicio 02 — Configuración del esquema
-- Motor: PostgreSQL 16
-- ============================================

DROP TABLE IF EXISTS accounts;

CREATE TABLE accounts (
    id      SERIAL          PRIMARY KEY,
    owner   TEXT            NOT NULL,
    balance NUMERIC(12, 2)  NOT NULL CHECK (balance >= 0)
);

INSERT INTO accounts (owner, balance)
VALUES
    ('Laura Méndez',    1500.00),
    ('Carlos Ríos',     800.00),
    ('Diana Flores',    2200.00);
