-- ============================================================
-- DEMOS INSTRUCTOR — Semana 22: JSON y JSONB
-- Base de datos: northwind (PostgreSQL 16 · Docker)
-- ⚠️  SOLO USO INTERNO — No compartir con aprendices
-- ============================================================
-- Conectar al contenedor:
--   docker compose -f scripts/docker-compose.yml exec postgres \
--     psql -U bootcamp -d northwind
-- ============================================================


-- ── 0. Tabla temporal con columna JSONB ──────────────────────
-- Enriquecer productos con metadatos variables por tipo:
CREATE TEMP TABLE demo_products_meta AS
SELECT
    p.product_id,
    p.product_name,
    p.unit_price,
    c.category_name,
    CASE c.category_id
        WHEN 1 THEN '{"alcohol": false, "caffeine": true, "volume_ml": 330}'::JSONB
        WHEN 2 THEN '{"spicy": false, "vegan": true, "allergens": ["gluten"]}'::JSONB
        WHEN 3 THEN '{"sugar_g": 24, "vegan": false, "allergens": ["nuts", "dairy"]}'::JSONB
        WHEN 4 THEN '{"fat_g": 8, "lactose_free": false, "pasteurized": true}'::JSONB
        WHEN 5 THEN '{"gluten_free": false, "fiber_g": 3, "allergens": ["gluten"]}'::JSONB
        ELSE         '{"notes": "generic product"}'::JSONB
    END AS metadata
FROM products p
JOIN categories c ON p.category_id = c.category_id;


-- ── 1. Acceso a campos JSONB ──────────────────────────────────
-- Operador ->> devuelve texto; -> devuelve JSONB
SELECT
    product_name,
    metadata ->> 'vegan'        AS es_vegano,
    metadata ->> 'caffeine'     AS tiene_cafeina,
    metadata -> 'allergens'     AS alergenos_json
FROM demo_products_meta
LIMIT 10;


-- ── 2. Filtrar por valor en JSONB ────────────────────────────
-- Productos veganos:
SELECT product_name, unit_price, metadata
FROM demo_products_meta
WHERE (metadata ->> 'vegan')::BOOLEAN = TRUE;

-- Productos con cafeína:
SELECT product_name FROM demo_products_meta
WHERE (metadata ->> 'caffeine')::BOOLEAN = TRUE;


-- ── 3. Buscar dentro de arrays JSONB ─────────────────────────
-- Productos con 'gluten' en la lista de alérgenos:
SELECT product_name, metadata -> 'allergens' AS alergenos
FROM demo_products_meta
WHERE metadata -> 'allergens' @> '["gluten"]'::JSONB;


-- ── 4. Índice GIN sobre JSONB ─────────────────────────────────
CREATE INDEX idx_demo_metadata ON demo_products_meta USING GIN(metadata);

EXPLAIN
SELECT product_name FROM demo_products_meta
WHERE metadata @> '{"vegan": true}'::JSONB;


-- ── 5. Agregar información JSON — jsonb_agg ───────────────────
-- Agrupar alérgenos por categoría:
SELECT
    category_name,
    jsonb_agg(
        jsonb_build_object(
            'producto', product_name,
            'alergenos', metadata -> 'allergens'
        )
    ) AS productos_con_alergenos
FROM demo_products_meta
WHERE metadata ? 'allergens'
GROUP BY category_name;


-- ── 6. Actualizar un campo JSONB ─────────────────────────────
BEGIN;
    UPDATE demo_products_meta
    SET metadata = metadata || '{"organic": true}'::JSONB
    WHERE category_name = 'Produce';

    -- Ver resultado:
    SELECT product_name, metadata FROM demo_products_meta
    WHERE metadata ->> 'organic' = 'true';
ROLLBACK;

DROP TABLE IF EXISTS demo_products_meta;
