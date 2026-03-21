-- ============================================
-- PROYECTO SEMANAL: Conoce tu Dominio
-- Semana 01 — Introducción a Bases de Datos Relacionales
-- ============================================

-- NOTA PARA EL APRENDIZ:
-- Adapta este esquema al dominio que te fue asignado.
-- Renombra las tablas y columnas según corresponda.
-- Ejemplos:
--   Biblioteca  → books, members, loans
--   Farmacia    → medicines, sales, inventory
--   Gimnasio    → members, routines, attendance
--   Restaurante → dishes, tables, orders

-- ============================================
-- PASO 1: Crear la entidad principal
-- ============================================

-- TODO: Renombrar 'items' según tu dominio (ej: books, medicines, dishes)
-- TODO: Agregar columnas específicas de tu entidad principal
CREATE TABLE items (
    id          INTEGER PRIMARY KEY,
    name        TEXT    NOT NULL
    -- TODO: Agregar al menos 2 columnas más relevantes para tu dominio
    -- Ejemplos: price REAL, description TEXT, is_active INTEGER DEFAULT 1
);

-- ============================================
-- PASO 2: Crear una segunda entidad
-- ============================================

-- TODO: Renombrar 'entities' según tu dominio (ej: members, clients, users)
-- TODO: Agregar columnas específicas
CREATE TABLE entities (
    id          INTEGER PRIMARY KEY,
    name        TEXT    NOT NULL
    -- TODO: Agregar columnas relevantes
    -- Ejemplos: email TEXT, phone TEXT, created_at TEXT
);

-- ============================================
-- PASO 3: Insertar datos de prueba
-- ============================================

-- TODO: Insertar al menos 5 registros en cada tabla
-- Usa datos realistas relacionados con tu dominio
INSERT INTO items (id, name) VALUES
    (1, 'CAMBIAR POR DATO REAL');
    -- TODO: Agregar más registros

INSERT INTO entities (id, name) VALUES
    (1, 'CAMBIAR POR DATO REAL');
    -- TODO: Agregar más registros

-- ============================================
-- PASO 4: Consultas SELECT básicas
-- ============================================

-- TODO: Mostrar todos los items con todas sus columnas
SELECT *
FROM   items;

-- TODO: Mostrar solo el nombre de los items ordenados alfabéticamente
-- SELECT ...
-- FROM   items
-- ORDER BY ...;

-- TODO: Contar cuántos items tienes en total
-- SELECT COUNT(*) AS total_items
-- FROM   items;
