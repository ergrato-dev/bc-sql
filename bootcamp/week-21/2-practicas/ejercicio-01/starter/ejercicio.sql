-- ============================================
-- Semana 21: Full-Text Search
-- Ejercicio 01 — Indexación y búsqueda básica FTS
-- Motor: PostgreSQL 16
-- ============================================

-- ============================================
-- PASO 1: Inspeccionar tsvector
-- ============================================

-- Observa cómo to_tsvector normaliza y elimina stopwords
-- Descomenta las siguientes líneas:

-- SELECT to_tsvector('spanish',
--     'Las bases de datos relacionales permiten consultas SQL complejas');

-- SELECT to_tsvector('english',
--     'Relational databases allow complex SQL queries');


-- ============================================
-- PASO 2: Agregar columna tsvector + índice GIN
-- ============================================

-- Crea la columna generada y el índice
-- Descomenta las siguientes líneas:

-- ALTER TABLE articles
-- ADD COLUMN search_vector TSVECTOR
--     GENERATED ALWAYS AS (
--         to_tsvector('spanish',
--             COALESCE(title, '') || ' ' || COALESCE(body, ''))
--     ) STORED;

-- CREATE INDEX idx_articles_search
--     ON articles USING GIN (search_vector);

-- Verifica que la columna se llenó
-- SELECT id, title, search_vector FROM articles LIMIT 2;


-- ============================================
-- PASO 3: Búsqueda básica con @@
-- ============================================

-- Buscar artículos sobre 'base datos'
-- Descomenta las siguientes líneas:

-- SELECT id, title
-- FROM articles
-- WHERE search_vector @@ plainto_tsquery('spanish', 'base datos');

-- Con operadores explícitos AND
-- SELECT id, title
-- FROM articles
-- WHERE search_vector @@ to_tsquery('spanish', 'base & datos');


-- ============================================
-- PASO 4: Operadores OR y NOT en tsquery
-- ============================================

-- Artículos sobre 'transacción' o 'índice' pero NO 'trigger'
-- Descomenta las siguientes líneas:

-- SELECT id, title
-- FROM articles
-- WHERE search_vector @@
--     to_tsquery('spanish', '(transacción | índice) & !trigger')
-- ORDER BY id;
