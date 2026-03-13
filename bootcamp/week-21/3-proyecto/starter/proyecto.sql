-- ============================================
-- PROYECTO SEMANAL: Búsqueda de Texto Completo
-- Semana 21 — Full-Text Search
-- Motor: PostgreSQL 16
-- ============================================

-- NOTA PARA EL APRENDIZ:
-- Adapta este esquema a tu dominio asignado.
-- Ejemplos:
--   Biblioteca  → books (title, description)
--   Farmacia    → medicines (name, indications)
--   Gimnasio    → routines (name, description)
--   Restaurante → dishes (name, ingredients)
--
-- Renombra la tabla y las columnas según tu dominio.

-- ============================================
-- PASO 1: Crear la tabla con search_vector
-- ============================================

DROP TABLE IF EXISTS items;

-- TODO: Renombrar 'items' según tu dominio (books, medicines, etc.)
-- TODO: Agregar columnas específicas de tu dominio
CREATE TABLE items (
    id             SERIAL       PRIMARY KEY,
    name           TEXT         NOT NULL,
    description    TEXT         NOT NULL,
    created_at     DATE         NOT NULL DEFAULT CURRENT_DATE,
    search_vector  TSVECTOR
    -- TODO: Agregar columnas adicionales (precio, categoría, etc.)
);

-- ============================================
-- PASO 2: Insertar al menos 10 filas de prueba
-- ============================================

-- TODO: Reemplazar con datos reales de tu dominio
INSERT INTO items (name, description) VALUES
('Nombre 1', 'Descripción representativa del dominio'),
('Nombre 2', 'Otra descripción con términos relevantes'),
('Nombre 3', 'Descripción con palabras clave del dominio');
-- TODO: Agregar hasta completar al menos 10 filas

-- ============================================
-- PASO 3: Poblar search_vector con setweight
-- ============================================

-- TODO: Ajustar las columnas según tu dominio
-- El nombre/título recibe peso A (más importante)
-- La descripción recibe peso B
UPDATE items
SET search_vector =
    setweight(to_tsvector('spanish', COALESCE(name,        '')), 'A') ||
    setweight(to_tsvector('spanish', COALESCE(description, '')), 'B');

-- ============================================
-- PASO 4: Crear índice GIN
-- ============================================

-- TODO: Reemplazar 'items' con el nombre de tu tabla
CREATE INDEX idx_items_sv ON items USING GIN (search_vector);

-- ============================================
-- PASO 5: Consulta de búsqueda con @@
-- ============================================

-- TODO: Reemplazar 'término de búsqueda' con términos relevantes
--       del dominio de tu proyecto
SELECT
    id,
    name,
    description
FROM items
WHERE search_vector @@ plainto_tsquery('spanish', 'término de búsqueda')
ORDER BY id;

-- ============================================
-- PASO 6: Ranking con ts_rank
-- ============================================

-- TODO: Ajustar el término de búsqueda
SELECT
    id,
    name,
    ts_rank(search_vector, query) AS relevancia
FROM items,
     plainto_tsquery('spanish', 'término de búsqueda') AS query
WHERE search_vector @@ query
ORDER BY relevancia DESC;

-- ============================================
-- PASO 7: Resaltado con ts_headline
-- ============================================

-- TODO: Ajustar el término y la columna de texto
SELECT
    name,
    ts_headline(
        'spanish',
        description,
        plainto_tsquery('spanish', 'término de búsqueda'),
        'StartSel=[, StopSel=], MaxWords=20, MinWords=8'
    ) AS extracto
FROM items
WHERE search_vector @@ plainto_tsquery('spanish', 'término de búsqueda');
