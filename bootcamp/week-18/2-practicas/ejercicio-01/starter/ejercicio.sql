-- ============================================
-- Semana 18: Funciones y Procedimientos PL/pgSQL
-- Ejercicio 01 — Funciones escalares y RETURNS TABLE
-- Motor: PostgreSQL 16
-- ============================================

-- ============================================
-- PASO 1: Función escalar con IF
-- ============================================

-- Crea fn_price_category que clasifica el precio
-- en 'expensive', 'standard' o 'cheap'
-- Descomenta las siguientes líneas:

-- CREATE OR REPLACE FUNCTION fn_price_category(p_price NUMERIC)
-- RETURNS TEXT
-- LANGUAGE plpgsql
-- AS $$
-- BEGIN
--     IF p_price >= 500 THEN
--         RETURN 'expensive';
--     ELSIF p_price >= 100 THEN
--         RETURN 'standard';
--     ELSE
--         RETURN 'cheap';
--     END IF;
-- END;
-- $$;

-- SELECT
--     name,
--     price,
--     fn_price_category(price) AS category
-- FROM products
-- ORDER BY price DESC;


-- ============================================
-- PASO 2: Función escalar con SELECT INTO
-- ============================================

-- Crea fn_total_stock_by_category que suma el
-- stock de todos los productos de una categoría dada
-- Descomenta las siguientes líneas:

-- CREATE OR REPLACE FUNCTION fn_total_stock_by_category(p_cat TEXT)
-- RETURNS INT
-- LANGUAGE plpgsql
-- AS $$
-- DECLARE
--     v_total INT;
-- BEGIN
--     SELECT COALESCE(SUM(stock), 0)
--     INTO v_total
--     FROM products
--     WHERE category = p_cat;
--
--     RETURN v_total;
-- END;
-- $$;

-- SELECT fn_total_stock_by_category('electronics') AS total_electronics;
-- SELECT fn_total_stock_by_category('furniture')   AS total_furniture;


-- ============================================
-- PASO 3: RETURNS TABLE con RETURN QUERY
-- ============================================

-- Crea fn_low_stock que retorna los productos cuyo
-- stock sea menor al umbral indicado
-- Descomenta las siguientes líneas:

-- CREATE OR REPLACE FUNCTION fn_low_stock(p_min INT)
-- RETURNS TABLE(id INT, name TEXT, stock INT, category TEXT)
-- LANGUAGE plpgsql
-- AS $$
-- BEGIN
--     RETURN QUERY
--         SELECT p.id, p.name, p.stock, p.category
--         FROM products p
--         WHERE p.stock < p_min
--         ORDER BY p.stock;
-- END;
-- $$;

-- SELECT * FROM fn_low_stock(10);


-- ============================================
-- PASO 4: Función con bucle FOR
-- ============================================

-- Crea fn_apply_discount que itera sobre los productos
-- de una categoría y retorna precio original y con 10% de descuento
-- Descomenta las siguientes líneas:

-- CREATE OR REPLACE FUNCTION fn_apply_discount(p_cat TEXT)
-- RETURNS TABLE(id INT, name TEXT, original NUMERIC, discounted NUMERIC)
-- LANGUAGE plpgsql
-- AS $$
-- DECLARE
--     rec RECORD;
-- BEGIN
--     FOR rec IN
--         SELECT p.id, p.name, p.price FROM products p WHERE p.category = p_cat
--     LOOP
--         RETURN QUERY
--             SELECT rec.id, rec.name, rec.price,
--                    ROUND(rec.price * 0.90, 2);
--     END LOOP;
-- END;
-- $$;

-- SELECT * FROM fn_apply_discount('electronics');
