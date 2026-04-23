-- ============================================================
-- DEMOS INSTRUCTOR — Semana 21: Full-Text Search
-- Base de datos: northwind (PostgreSQL 16 · Docker)
-- ⚠️  SOLO USO INTERNO — No compartir con aprendices
-- ============================================================
-- Conectar al contenedor:
--   docker compose -f scripts/docker-compose.yml exec postgres \
--     psql -U bootcamp -d northwind
-- ============================================================
-- NOTA: Northwind no tiene columnas de texto largo nativas.
--   Usamos product_name y creamos una tabla temporal enriquecida
--   con descripciones ficticias para demostrar FTS.
-- ============================================================


-- ── 0. Preparar sandbox con descripciones de texto ───────────
CREATE TEMP TABLE demo_catalog AS
SELECT
    p.product_id,
    p.product_name,
    c.category_name,
    p.unit_price,
    -- Descripción generada para demo FTS
    p.product_name || '. ' || c.category_name || ' product from Northwind. '
    || CASE c.category_id
        WHEN 1 THEN 'Soft drinks, coffees, teas, beers, ales.'
        WHEN 2 THEN 'Sweet and savory sauces, relishes, spreads, seasonings.'
        WHEN 3 THEN 'Desserts, candies, sweet breads and confections.'
        WHEN 4 THEN 'Cheeses and dairy products.'
        WHEN 5 THEN 'Breads, crackers, pasta and cereal.'
        WHEN 6 THEN 'Prepared meats and canned goods.'
        WHEN 7 THEN 'Dried fruit and bean curd.'
        WHEN 8 THEN 'Seaweed and fish.'
        ELSE 'General grocery item.'
       END  AS descripcion
FROM products p
JOIN categories c ON p.category_id = c.category_id;


-- ── 1. to_tsvector y to_tsquery básicos ──────────────────────
-- Mostrar qué produce to_tsvector:
SELECT
    product_name,
    to_tsvector('english', descripcion) AS tsvector_demo
FROM demo_catalog
LIMIT 3;

-- Buscar productos que mencionen 'sauce':
SELECT product_name, descripcion
FROM demo_catalog
WHERE to_tsvector('english', descripcion) @@ to_tsquery('english', 'sauce');


-- ── 2. Operadores de tsquery ─────────────────────────────────
-- AND implícito (&): debe contener ambas palabras
SELECT product_name FROM demo_catalog
WHERE to_tsvector('english', descripcion) @@ to_tsquery('english', 'sweet & bread');

-- OR (|): alguna de las palabras
SELECT product_name FROM demo_catalog
WHERE to_tsvector('english', descripcion) @@ to_tsquery('english', 'beer | tea | coffee');

-- NOT (!): excluir
SELECT product_name FROM demo_catalog
WHERE to_tsvector('english', descripcion) @@ to_tsquery('english', 'sauce & !sweet');


-- ── 3. Índice GIN para acelerar FTS ──────────────────────────
-- Agregar columna tsvector calculada:
ALTER TABLE demo_catalog ADD COLUMN tsv tsvector
    GENERATED ALWAYS AS (
        to_tsvector('english', descripcion)
    ) STORED;

-- Crear índice GIN:
CREATE INDEX idx_demo_catalog_tsv ON demo_catalog USING GIN(tsv);

-- Buscar usando la columna indexada:
SELECT product_name, unit_price
FROM demo_catalog
WHERE tsv @@ to_tsquery('english', 'dairy | cheese');


-- ── 4. ts_rank — relevancia de resultados ────────────────────
SELECT
    product_name,
    unit_price,
    ts_rank(tsv, query) AS relevancia
FROM demo_catalog,
     to_tsquery('english', 'sauce | sweet | bread') query
WHERE tsv @@ query
ORDER BY relevancia DESC;


-- ── 5. ts_headline — resaltar coincidencias ───────────────────
SELECT
    product_name,
    ts_headline(
        'english',
        descripcion,
        to_tsquery('english', 'sauce | sweet'),
        'MaxWords=10, MinWords=5, StartSel=**, StopSel=**'
    ) AS fragmento
FROM demo_catalog
WHERE tsv @@ to_tsquery('english', 'sauce | sweet');

DROP TABLE IF EXISTS demo_catalog;
