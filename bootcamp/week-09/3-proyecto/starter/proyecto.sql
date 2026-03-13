-- ============================================
-- PROYECTO SEMANAL: JOINs aplicados a tu dominio
-- Semana 09 — INNER JOIN y LEFT JOIN
-- ============================================

-- NOTA PARA EL APRENDIZ:
-- Adapta este esquema a tu dominio asignado.
-- Ejemplos de adaptación:
--   Biblioteca  → books, members, loans
--   Farmacia    → medicines, suppliers, sales
--   Gimnasio    → members, trainers, routines
--   Restaurante → dishes, categories, orders
-- NO copies uno de estos ejemplos; usa tu dominio propio.

PRAGMA foreign_keys = ON;

-- ============================================
-- TODO: Renombrar las tablas según tu dominio
-- ============================================

DROP TABLE IF EXISTS child_records;
DROP TABLE IF EXISTS main_items;
DROP TABLE IF EXISTS reference_table;

-- Tabla de referencia (categorías, ubicaciones, tipos, etc.)
CREATE TABLE reference_table (
    id   INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT    NOT NULL UNIQUE
    -- TODO: Agregar columnas específicas de tu dominio
);

-- Tabla principal de tu dominio
CREATE TABLE main_items (
    id           INTEGER PRIMARY KEY AUTOINCREMENT,
    name         TEXT    NOT NULL,
    -- TODO: Agregar columnas específicas
    reference_id INTEGER REFERENCES reference_table (id)
);

-- Tabla hija (transacciones, préstamos, ventas, etc.)
CREATE TABLE child_records (
    id           INTEGER PRIMARY KEY AUTOINCREMENT,
    recorded_at  TEXT    NOT NULL DEFAULT (DATE('now')),
    -- TODO: Agregar columnas específicas
    item_id      INTEGER REFERENCES main_items (id)
);

-- ============================================
-- TODO: Insertar datos de prueba realistas
-- Incluir al menos 1 registro "huérfano" en main_items
-- (un item sin ningún child_record asociado)
-- ============================================

-- INSERT INTO reference_table (name) VALUES (...);
-- INSERT INTO main_items (name, reference_id) VALUES (...);
-- INSERT INTO child_records (item_id) VALUES (...);


-- ============================================
-- CONSULTA 1: INNER JOIN principal
-- TODO: Une las dos tablas más importantes
-- Muestra solo los registros con relación en ambas
-- ============================================

-- SELECT
--     mi.name     AS item,
--     cr.recorded_at
-- FROM main_items  mi
-- INNER JOIN child_records cr ON cr.item_id = mi.id;


-- ============================================
-- CONSULTA 2: JOIN con tres tablas
-- TODO: Encadena main_items + child_records + reference_table
-- ============================================

-- SELECT
--     mi.name  AS item,
--     rt.name  AS category,
--     cr.recorded_at
-- FROM main_items mi
-- INNER JOIN reference_table rt ON mi.reference_id = rt.id
-- INNER JOIN child_records   cr ON cr.item_id      = mi.id;


-- ============================================
-- CONSULTA 3: LEFT JOIN — todos los registros
-- TODO: Obtén todos los items aunque no tengan child_records
-- ============================================

-- SELECT
--     mi.name        AS item,
--     cr.recorded_at AS activity
-- FROM main_items  mi
-- LEFT JOIN child_records cr ON cr.item_id = mi.id;


-- ============================================
-- CONSULTA 4: Detectar huérfanos (registros sin actividad)
-- TODO: Agrega WHERE para mostrar solo ítems sin child_records
-- ============================================

-- SELECT
--     mi.name AS item_sin_actividad
-- FROM main_items  mi
-- LEFT JOIN child_records cr ON cr.item_id = mi.id
-- WHERE cr.id IS NULL;


-- ============================================
-- CONSULTA 5: Reporte agregado con LEFT JOIN + COUNT
-- TODO: Cantidad de child_records por item (incluye 0)
-- ============================================

-- SELECT
--     mi.name       AS item,
--     COUNT(cr.id)  AS total_records
-- FROM main_items  mi
-- LEFT JOIN child_records cr ON cr.item_id = mi.id
-- GROUP BY mi.name
-- ORDER BY total_records DESC;
