-- ============================================
-- PROYECTO INTEGRADOR: Etapa 0 — Capstone
-- Semana 08 — DDL + DML + SELECT completo
-- ============================================
-- Ejemplo de referencia: Acuario (no usar este dominio)
-- Adapta a tu dominio asignado.

-- Activar claves foráneas (obligatorio)
PRAGMA foreign_keys = ON;

-- ============================================
-- PARTE 1: ESQUEMA (DDL)
-- ============================================

-- TODO: Crear tabla de referencia / categorías (ej: genres, locations)
--       Incluye PK, NOT NULL, UNIQUE
-- CREATE TABLE reference_table (
--     id   INTEGER PRIMARY KEY,
--     name TEXT    NOT NULL UNIQUE
--     -- TODO: agrega columnas de tu dominio
-- );

-- TODO: Crear tabla secundaria con FK a la anterior
--       Incluye PK, FK, al menos 1 CHECK, 1 DEFAULT
-- CREATE TABLE secondary_table (
--     id       INTEGER PRIMARY KEY,
--     name     TEXT    NOT NULL,
--     -- TODO: columna numérica con CHECK
--     -- TODO: columna con DEFAULT
--     parent_id INTEGER NOT NULL
--         REFERENCES reference_table(id) ON DELETE RESTRICT
-- );

-- TODO: Crear tabla principal con FK a la secundaria
--       Incluye PK, FK, UNIQUE, NOT NULL, columna opcional (NULL)
-- CREATE TABLE main_table (
--     id               INTEGER PRIMARY KEY,
--     name             TEXT    NOT NULL,
--     unique_code      TEXT    UNIQUE,         -- código único
--     optional_field   TEXT,                  -- puede ser NULL
--     numeric_col      REAL    NOT NULL CHECK (numeric_col > 0),
--     is_active        INTEGER NOT NULL DEFAULT 1,
--     secondary_id     INTEGER NOT NULL
--         REFERENCES secondary_table(id) ON DELETE RESTRICT
-- );


-- ============================================
-- PARTE 2: DATOS (DML)
-- ============================================

-- TODO: Insertar al menos 3 registros en reference_table
-- INSERT INTO reference_table ...;

-- TODO: Insertar al menos 3 registros en secondary_table
-- INSERT INTO secondary_table ...;

-- TODO: Insertar al menos 8 registros en main_table
--       Al menos 2 con optional_field = NULL
-- INSERT INTO main_table ...;


-- ============================================
-- PARTE 3: REPORTES (SELECT)
-- ============================================

-- REPORTE 1: Totales globales
-- TODO: COUNT(*), SUM o AVG de columna numérica principal
-- SELECT ... FROM main_table;


-- REPORTE 2: Totales por categoría (GROUP BY)
-- TODO: Agrupa por secondary_id con COUNT y AVG/SUM
-- SELECT
--     secondary_id,
--     COUNT(*)          AS total,
--     AVG(numeric_col)  AS promedio
-- FROM   main_table
-- WHERE  is_active = 1
-- GROUP BY secondary_id
-- ORDER BY total DESC;


-- REPORTE 3: Grupos con umbral (HAVING)
-- TODO: Mostrar solo grupos que superen un umbral de negocio
-- SELECT secondary_id, COUNT(*) AS total
-- FROM   main_table
-- GROUP BY secondary_id
-- HAVING total > 2;


-- REPORTE 4: Registros con NULL y COALESCE
-- TODO: Mostrar registros con optional_field NULL usando COALESCE
-- SELECT name, COALESCE(optional_field, 'Sin dato') AS campo_display
-- FROM   main_table
-- WHERE  optional_field IS NULL;


-- REPORTE 5: Búsqueda combinada
-- TODO: Filtrar por rango (BETWEEN), patrón (LIKE) o lista (IN)
-- SELECT name, numeric_col
-- FROM   main_table
-- WHERE  numeric_col BETWEEN valor1 AND valor2
--   AND  is_active = 1
-- ORDER BY numeric_col DESC
-- LIMIT 5;
