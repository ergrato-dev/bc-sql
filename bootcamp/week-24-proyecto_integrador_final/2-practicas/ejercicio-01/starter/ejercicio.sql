-- Semana 24: Proyecto Integrador Final
-- ejercicio.sql — Ejercicio 01 (starter)
-- Motor: PostgreSQL 16
-- Instrucciones: descomenta cada sección cuando llegues al paso correspondiente
-- ============================================

-- ============================================
-- PASO 1: JOIN base — ventas por producto
-- ============================================

-- Combina categories, products y order_items para obtener total vendido
-- Descomenta las siguientes líneas:

-- SELECT
--     c.name              AS category_name,
--     p.name              AS product_name,
--     SUM(oi.quantity)    AS total_sold
-- FROM categories c
-- JOIN products p       ON p.category_id = c.id
-- JOIN order_items oi   ON oi.product_id = p.id
-- GROUP BY c.name, p.name
-- ORDER BY total_sold DESC
-- LIMIT 10;


-- ============================================
-- PASO 2: CTE + ROW_NUMBER — top-2 por categoría
-- ============================================

-- Usa una CTE para rankear productos dentro de cada categoría
-- Descomenta las siguientes líneas:

-- WITH ranked_products AS (
--     SELECT
--         c.name                                  AS category_name,
--         p.name                                  AS product_name,
--         SUM(oi.quantity)                        AS total_sold,
--         ROW_NUMBER() OVER (
--             PARTITION BY c.id
--             ORDER BY SUM(oi.quantity) DESC
--         )                                       AS rn
--     FROM categories c
--     JOIN products p     ON p.category_id = c.id
--     JOIN order_items oi ON oi.product_id = p.id
--     GROUP BY c.id, c.name, p.id, p.name
-- )
-- SELECT category_name, product_name, total_sold
-- FROM ranked_products
-- WHERE rn <= 2
-- ORDER BY category_name, rn;


-- ============================================
-- PASO 3: Full-Text Search sobre productos
-- ============================================

-- Busca productos con plainto_tsquery y ordena por relevancia
-- Descomenta las siguientes líneas:

-- SELECT
--     p.name,
--     ts_rank(p.search_vector, query) AS rank
-- FROM products p,
--      plainto_tsquery('spanish', 'inalámbrico bluetooth') AS query
-- WHERE p.search_vector @@ query
-- ORDER BY rank DESC;


-- ============================================
-- PASO 4: EXPLAIN ANALYZE — medir el JOIN
-- ============================================

-- Primero sin índice en order_items.product_id:
-- Descomenta las siguientes líneas:

-- EXPLAIN ANALYZE
-- SELECT p.name, SUM(oi.quantity)
-- FROM products p
-- JOIN order_items oi ON oi.product_id = p.id
-- GROUP BY p.name;

-- Crea el índice y vuelve a ejecutar el EXPLAIN:
-- Descomenta las siguientes líneas:

-- CREATE INDEX IF NOT EXISTS idx_order_items_product
--     ON order_items (product_id);

-- EXPLAIN ANALYZE
-- SELECT p.name, SUM(oi.quantity)
-- FROM products p
-- JOIN order_items oi ON oi.product_id = p.id
-- GROUP BY p.name;
