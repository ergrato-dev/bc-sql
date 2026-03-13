-- ============================================
-- PROYECTO SEMANAL: Índices y Consultas Optimizadas
-- Semana 16 — Índices B-tree + Funciones integradas
-- PostgreSQL 16
-- ============================================

-- NOTA PARA EL APRENDIZ:
-- Adapta este esquema a tu dominio asignado.
-- Ejemplos:
--   Biblioteca  → books, members, loans (title, loan_date, fine_amount)
--   Farmacia    → medicines, sales (medicine_name, expiry_date, price)
--   Gimnasio    → members, attendance (name, registration_date, fee)
--   Restaurante → dishes, orders (dish_name, order_date, price)

-- TODO: Renombrar las tablas y columnas según tu dominio

DROP TABLE IF EXISTS records CASCADE;
DROP TABLE IF EXISTS categories CASCADE;

CREATE TABLE categories (
    id   SERIAL PRIMARY KEY,
    name TEXT   NOT NULL
);

CREATE TABLE records (
    id          SERIAL         PRIMARY KEY,
    name        TEXT           NOT NULL,             -- TODO: renombrar (title, dish_name, etc.)
    description TEXT,
    category_id INT            REFERENCES categories (id),
    price       NUMERIC(10, 2),                      -- TODO: renombrar (fine_amount, fee, etc.)
    created_at  DATE           NOT NULL DEFAULT CURRENT_DATE
    -- TODO: Agregar columnas específicas del dominio
);

-- TODO: Insertar datos representativos (mínimo 8 filas)
INSERT INTO categories (name) VALUES
    ('Categoría A'),
    ('Categoría B');

INSERT INTO records (name, description, category_id, price, created_at) VALUES
    ('Registro 1', 'Descripción 1', 1, 29.99, '2022-03-10'),
    ('Registro 2', 'Descripción 2', 1, 49.99, '2021-07-15'),
    ('Registro 3', 'Descripción 3', 2, 19.99, '2023-01-05'),
    ('Registro 4', 'Descripción 4', 2, 99.99, '2020-11-20'),
    ('Registro 5', 'Descripción 5', 1, 34.50, '2022-09-08'),
    ('Registro 6', 'Descripción 6', 1, 15.00, '2024-02-14'),
    ('Registro 7', 'Descripción 7', 2, 75.00, '2021-05-30'),
    ('Registro 8', 'Descripción 8', 2, 55.75, '2023-11-11');


-- ============================================
-- TODO 1: Crear un índice y verificar con EXPLAIN
-- ============================================
-- 1. Ejecuta EXPLAIN en una consulta con WHERE category_id = ...
--    ANTES de crear el índice. Observa "Seq Scan".
-- 2. Crea el índice con CREATE INDEX en la columna category_id.
-- 3. Ejecuta el mismo EXPLAIN de nuevo. Observa si cambia a "Index Scan".

-- TODO: Agregar EXPLAIN antes del índice
-- TODO: Crear el índice idx_records_category_id
-- TODO: Agregar EXPLAIN después del índice


-- ============================================
-- TODO 2: Reporte con funciones de texto y fecha
-- ============================================
-- Crea una consulta que muestre:
--   - name en MAYÚSCULAS
--   - created_at formateado como 'DD/MM/YYYY' con TO_CHAR
--   - Antigüedad del registro en años usando AGE + EXTRACT

-- TODO: Implementar la consulta de reporte con funciones de texto y fecha
-- Debe mostrar: name_upper, created_fmt, years_old


-- ============================================
-- TODO 3: Reporte numérico con descuento
-- ============================================
-- Calcula para cada registro:
--   - price original
--   - price con 15% de descuento (ROUND a 2 decimales)
--   - el ahorro (original - precio_con_descuento)
-- Ordena por precio descendente.

-- TODO: Implementar la consulta de precios con descuento del 15%
-- Debe mostrar: name, price, discounted_price, savings
