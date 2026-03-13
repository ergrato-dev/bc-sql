-- ============================================
-- Semana 21: Full-Text Search
-- Ejercicio 02 — Ranking, setweight y ts_headline
-- Motor: PostgreSQL 16
-- ============================================

-- ============================================
-- PASO 1: Ranking con ts_rank()
-- ============================================

-- Ordenar resultados por relevancia descendente
-- Descomenta las siguientes líneas:

-- SELECT
--     id,
--     title,
--     ts_rank(search_vector, query) AS rank
-- FROM articles,
--      plainto_tsquery('spanish', 'índice consulta') AS query
-- WHERE search_vector @@ query
-- ORDER BY rank DESC;


-- ============================================
-- PASO 2: setweight — recalcular con pesos
-- ============================================

-- El título debe pesar más que el cuerpo (A > B)
-- Descomenta las siguientes líneas:

-- UPDATE articles
-- SET search_vector =
--     setweight(to_tsvector('spanish', COALESCE(title, '')), 'A') ||
--     setweight(to_tsvector('spanish', COALESCE(body,  '')), 'B');

-- Repite la búsqueda del paso 1 y observa si el ranking cambia
-- SELECT
--     id,
--     title,
--     ts_rank(search_vector, query) AS rank
-- FROM articles,
--      plainto_tsquery('spanish', 'índice consulta') AS query
-- WHERE search_vector @@ query
-- ORDER BY rank DESC;


-- ============================================
-- PASO 3: ts_headline — resaltar fragmentos
-- ============================================

-- Muestra el fragmento más relevante con coincidencias marcadas
-- Descomenta las siguientes líneas:

-- SELECT
--     title,
--     ts_headline(
--         'spanish',
--         body,
--         plainto_tsquery('spanish', 'índice GIN'),
--         'StartSel=[, StopSel=], MaxWords=25, MinWords=10'
--     ) AS extracto
-- FROM articles
-- WHERE search_vector @@ plainto_tsquery('spanish', 'índice GIN');


-- ============================================
-- PASO 4: Búsqueda con frase (operador <->)
-- ============================================

-- Palabras que aparecen en secuencia inmediata
-- Descomenta las siguientes líneas:

-- SELECT id, title
-- FROM articles
-- WHERE search_vector @@
--     to_tsquery('spanish', 'base <-> dato')
-- ORDER BY id;

-- Verificar cuáles artículos mencionan 'índice GIN' como frase
-- SELECT id, title
-- FROM articles
-- WHERE search_vector @@
--     to_tsquery('spanish', 'índic <-> gin')
-- ORDER BY id;
