-- ============================================
-- PROYECTO SEMANAL: DDL de tu Dominio
-- Semana 02 — DDL: Diseño de Esquemas
-- ============================================

-- NOTA PARA EL APRENDIZ:
-- Adapta este esquema al dominio que te fue asignado.
-- Renombra tablas y columnas según corresponda.

-- ============================================
-- LIMPIEZA: eliminar tablas si existen
-- ============================================

-- TODO: Agregar DROP TABLE IF EXISTS para cada tabla de tu dominio
-- Ejemplo:
-- DROP TABLE IF EXISTS items;
-- DROP TABLE IF EXISTS entities;

-- ============================================
-- TABLA 1: Entidad principal de tu dominio
-- ============================================

-- TODO: Renombrar 'items' según tu dominio
-- TODO: Definir columnas con tipos y constraints apropiados
CREATE TABLE IF NOT EXISTS items (
    id          INTEGER PRIMARY KEY,
    name        TEXT    NOT NULL,
    -- TODO: Agregar columna con DEFAULT
    -- TODO: Agregar columna con CHECK
    -- TODO: Agregar columna con UNIQUE si aplica
    is_active   INTEGER NOT NULL DEFAULT 1
);

-- ============================================
-- TABLA 2: Segunda entidad de tu dominio
-- ============================================

-- TODO: Renombrar y adaptar
CREATE TABLE IF NOT EXISTS entities (
    id          INTEGER PRIMARY KEY,
    name        TEXT    NOT NULL
    -- TODO: Agregar columnas relevantes con constraints
);

-- ============================================
-- TABLA 3: Tercera entidad o tabla de relación
-- ============================================

-- TODO: Crear la tercera tabla del dominio
-- Si es una tabla de relación, incluir dos FK
-- CREATE TABLE IF NOT EXISTS relations (
--     id         INTEGER PRIMARY KEY,
--     item_id    INTEGER NOT NULL,
--     entity_id  INTEGER NOT NULL,
--     FOREIGN KEY (item_id)   REFERENCES items(id),
--     FOREIGN KEY (entity_id) REFERENCES entities(id)
-- );

-- ============================================
-- VERIFICACIÓN
-- ============================================

-- TODO: Descomentar para verificar estructura
-- .tables
-- PRAGMA table_info(items);
-- PRAGMA table_info(entities);
