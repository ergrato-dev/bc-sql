-- Semana 10: CROSS JOIN
-- Setup: departments + job_levels

PRAGMA foreign_keys = ON;

DROP TABLE IF EXISTS job_levels;
DROP TABLE IF EXISTS departments;

-- ============================================
-- TABLA: departments (4 registros)
-- ============================================
CREATE TABLE departments (
    id   INTEGER PRIMARY KEY,
    name TEXT    NOT NULL UNIQUE
);

-- ============================================
-- TABLA: job_levels (3 registros)
-- ============================================
CREATE TABLE job_levels (
    id          INTEGER PRIMARY KEY,
    name        TEXT  NOT NULL UNIQUE,
    rank        INTEGER NOT NULL,  -- 1=jr, 2=mid, 3=sr
    base_salary REAL  NOT NULL
);

-- ============================================
-- DATOS DE PRUEBA
-- 4 departamentos × 3 niveles = 12 combinaciones
-- ============================================
INSERT INTO departments (name) VALUES
    ('Engineering'),
    ('Marketing'),
    ('Sales'),
    ('HR');

INSERT INTO job_levels (name, rank, base_salary) VALUES
    ('jr',  1, 45000.00),
    ('mid', 2, 65000.00),
    ('sr',  3, 90000.00);
