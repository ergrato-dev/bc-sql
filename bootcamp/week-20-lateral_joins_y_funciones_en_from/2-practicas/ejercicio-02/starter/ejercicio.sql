-- ============================================
-- Semana 20: LATERAL Joins
-- Ejercicio 02 — Top-N por grupo y funciones tabulares
-- Motor: PostgreSQL 16
-- ============================================

-- ============================================
-- PASO 1: Top-3 productos más vendidos por categoría
-- ============================================

-- JOIN LATERAL para obtener los 3 más vendidos por categoría
-- Descomenta las siguientes líneas:

-- SELECT
--     c.name                  AS category,
--     top3.product_name,
--     top3.total_sold
-- FROM categories c
-- JOIN LATERAL (
--     SELECT p.name                       AS product_name,
--            COALESCE(SUM(oi.quantity), 0) AS total_sold
--     FROM products p
--     LEFT JOIN order_items oi ON oi.product_id = p.id
--     WHERE p.category_id = c.id
--     GROUP BY p.id, p.name
--     ORDER BY total_sold DESC
--     LIMIT 3
-- ) AS top3 ON TRUE
-- ORDER BY c.name, top3.total_sold DESC;


-- ============================================
-- PASO 2: Función tabular + CROSS JOIN LATERAL
-- ============================================

-- Crea fn_top_products y úsala con CROSS JOIN LATERAL
-- Descomenta las siguientes líneas:

-- CREATE OR REPLACE FUNCTION fn_top_products(
--     p_cat_id INT,
--     p_limit  INT DEFAULT 3
-- )
-- RETURNS TABLE (product_name TEXT, total_sold BIGINT)
-- LANGUAGE sql AS $$
--     SELECT p.name,
--            COALESCE(SUM(oi.quantity), 0)::BIGINT
--     FROM products p
--     LEFT JOIN order_items oi ON oi.product_id = p.id
--     WHERE p.category_id = p_cat_id
--     GROUP BY p.id, p.name
--     ORDER BY 2 DESC
--     LIMIT p_limit;
-- $$;

-- SELECT c.name AS category, tp.product_name, tp.total_sold
-- FROM categories c
-- CROSS JOIN LATERAL fn_top_products(c.id, 3) AS tp
-- ORDER BY c.name, tp.total_sold DESC;


-- ============================================
-- PASO 3: Paginación por grupo (LIMIT + OFFSET)
-- ============================================

-- Obtener posiciones 4-6 de cada categoría (segunda página)
-- Descomenta las siguientes líneas:

-- SELECT
--     c.name          AS category,
--     page.product_name,
--     page.total_sold
-- FROM categories c
-- CROSS JOIN LATERAL (
--     SELECT p.name                        AS product_name,
--            COALESCE(SUM(oi.quantity), 0) AS total_sold
--     FROM products p
--     LEFT JOIN order_items oi ON oi.product_id = p.id
--     WHERE p.category_id = c.id
--     GROUP BY p.id, p.name
--     ORDER BY total_sold DESC
--     LIMIT 3 OFFSET 3
-- ) AS page
-- ORDER BY c.name, page.total_sold DESC;


-- ============================================
-- PASO 4: unnest() con WITH ORDINALITY
-- ============================================

-- Expandir el array de tags de cada producto a filas
-- Descomenta las siguientes líneas:

-- SELECT p.name, tag.value, tag.position
-- FROM products p
-- CROSS JOIN LATERAL
--     unnest(p.tags) WITH ORDINALITY AS tag(value, position)
-- ORDER BY p.name, tag.position;
