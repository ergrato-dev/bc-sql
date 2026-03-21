-- ============================================
-- PROYECTO SEMANAL: NULL y Constraints
-- Semana 07 — NOT NULL, UNIQUE, CHECK, FK
-- ============================================

-- NOTA: Adapta nombres a tu dominio asignado.

-- Activar claves foráneas (obligatorio)
PRAGMA foreign_keys = ON;

-- ============================================
-- PARTE 1: ESQUEMA CON CONSTRAINTS
-- ============================================

-- TODO: Crear la tabla de categorías/grupos de tu dominio
--       Incluir: PK, NOT NULL, UNIQUE donde aplique
-- CREATE TABLE categories (
--     id   INTEGER PRIMARY KEY,
--     name TEXT    NOT NULL UNIQUE
--     -- TODO: agregar columnas de tu dominio
-- );

-- TODO: Crear la tabla principal con todos los constraints
--       Incluir: PK, FK, NOT NULL, UNIQUE, CHECK, DEFAULT
-- CREATE TABLE items (
--     id          INTEGER PRIMARY KEY,
--     name        TEXT    NOT NULL,
--     -- TODO: columna con UNIQUE (código, matrícula, ISBN, etc.)
--     -- TODO: columna numérica con CHECK (precio > 0, edad > 0, etc.)
--     -- TODO: columna con DEFAULT (is_active, status, etc.)
--     category_id INTEGER NOT NULL
--         REFERENCES categories(id) ON DELETE RESTRICT
-- );


-- ============================================
-- PARTE 2: DATOS DE PRUEBA
-- ============================================

-- TODO: Insertar 3 categorías
-- INSERT INTO categories (id, name) VALUES
--     (1, 'categoria_1'),
--     (2, 'categoria_2'),
--     (3, 'categoria_3');

-- TODO: Insertar 6 items, al menos 2 con columna_opcional = NULL
-- INSERT INTO items (...) VALUES ...;


-- ============================================
-- PARTE 3: CONSULTAS CON NULL
-- ============================================

-- TODO: Mostrar items donde columna_opcional IS NULL
-- SELECT id, name
-- FROM   items
-- WHERE  columna_opcional IS NULL;

-- TODO: Mostrar todos los items usando COALESCE para reemplazar NULL
-- SELECT
--     name,
--     COALESCE(columna_opcional, 'Sin valor') AS col_display
-- FROM items;
