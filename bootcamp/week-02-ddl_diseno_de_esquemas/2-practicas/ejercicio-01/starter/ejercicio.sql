-- ============================================
-- Semana 02: DDL — Diseño de Esquemas
-- Ejercicio 01 — Crear un Esquema desde Cero
-- ============================================
-- Instrucción: descomenta cada sección al llegar al paso del README.

-- ============================================
-- PASO 2: Crear tabla departments
-- ============================================

-- Descomenta las siguientes líneas:
-- CREATE TABLE IF NOT EXISTS departments (
--     id   INTEGER PRIMARY KEY,
--     name TEXT    NOT NULL UNIQUE
-- );

-- ============================================
-- PASO 3: Crear tabla employees con FK y constraints
-- ============================================

-- Descomenta las siguientes líneas:
-- CREATE TABLE IF NOT EXISTS employees (
--     id            INTEGER PRIMARY KEY,
--     first_name    TEXT    NOT NULL,
--     last_name     TEXT    NOT NULL,
--     email         TEXT    NOT NULL UNIQUE,
--     salary        REAL    NOT NULL DEFAULT 0.00 CHECK (salary >= 0),
--     department_id INTEGER,
--     FOREIGN KEY (department_id) REFERENCES departments(id)
-- );

-- ============================================
-- PASO 4: Crear tabla projects con CHECK en status
-- ============================================

-- Descomenta las siguientes líneas:
-- CREATE TABLE IF NOT EXISTS projects (
--     id     INTEGER PRIMARY KEY,
--     name   TEXT    NOT NULL,
--     budget REAL    NOT NULL CHECK (budget > 0),
--     status TEXT    NOT NULL DEFAULT 'active'
--                    CHECK (status IN ('active', 'paused', 'closed'))
-- );

-- ============================================
-- PASO 5: Verificar estructura de las tablas
-- ============================================

-- Descomenta las siguientes líneas:
-- PRAGMA table_info(departments);
-- PRAGMA table_info(employees);
-- PRAGMA table_info(projects);
