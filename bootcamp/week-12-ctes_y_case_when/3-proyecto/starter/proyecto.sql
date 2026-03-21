-- ============================================
-- PROYECTO SEMANAL: CTEs y CASE WHEN en tu dominio
-- Semana 12 — Common Table Expressions + Condicionales
-- ============================================

-- NOTA PARA EL APRENDIZ:
-- Adapta este esquema a tu dominio asignado.
-- Necesitas al menos dos tablas relacionadas.

PRAGMA foreign_keys = ON;

-- ============================================
-- TODO: Renombrar las tablas según tu dominio
-- ============================================

DROP TABLE IF EXISTS transactions;
DROP TABLE IF EXISTS items;

CREATE TABLE items (
    id       INTEGER PRIMARY KEY,
    name     TEXT    NOT NULL,
    price    REAL    NOT NULL CHECK (price > 0),
    category TEXT    NOT NULL
    -- TODO: Agregar columnas específicas de tu dominio
);

CREATE TABLE transactions (
    id       INTEGER PRIMARY KEY,
    item_id  INTEGER NOT NULL REFERENCES items (id),
    quantity INTEGER NOT NULL DEFAULT 1,
    tx_date  TEXT    NOT NULL  -- formato YYYY-MM-DD
    -- TODO: Agregar columnas específicas
);

-- ============================================
-- TODO: Insertar datos de prueba
-- Al menos 6 items en 3 categorías distintas
-- Al menos 10 transactions distribuidas en varias semanas
-- ============================================

-- INSERT INTO items (name, price, category) VALUES (...);
-- INSERT INTO transactions (item_id, quantity, tx_date) VALUES (...);


-- ============================================
-- CONSULTA 1: CTE simple + CASE WHEN de clasificación
-- TODO: Clasifica cada item según su precio en 3 bandas
-- ============================================

-- WITH items_con_actividad AS (
--     SELECT
--         i.id,
--         i.name,
--         i.price,
--         i.category,
--         COUNT(t.id) AS total_transactions
--     FROM items i
--     LEFT JOIN transactions t ON t.item_id = i.id
--     GROUP BY i.id, i.name, i.price, i.category
-- )
-- SELECT
--     name,
--     price,
--     total_transactions,
--     CASE
--         WHEN price >= ___ THEN 'Premium'
--         WHEN price >= ___ THEN 'Estándar'
--         ELSE                   'Económico'
--     END AS price_band
-- FROM items_con_actividad
-- ORDER BY price DESC;


-- ============================================
-- CONSULTA 2: Dos CTEs encadenados
-- Primer CTE: total de ventas por categoría
-- Segundo CTE: categorías por encima del promedio
-- TODO: Mostrar nombre y total de las categorías top
-- ============================================

-- WITH ventas_por_categoria AS (
--     SELECT
--         i.category,
--         SUM(t.quantity) AS total_vendido
--     FROM items i
--     INNER JOIN transactions t ON t.item_id = i.id
--     GROUP BY i.category
-- ),
-- categorias_top AS (
--     SELECT category
--     FROM ventas_por_categoria
--     WHERE total_vendido > (SELECT AVG(total_vendido) FROM ventas_por_categoria)
-- )
-- SELECT
--     vc.category,
--     vc.total_vendido
-- FROM ventas_por_categoria vc
-- WHERE vc.category IN (SELECT category FROM categorias_top)
-- ORDER BY vc.total_vendido DESC;


-- ============================================
-- CONSULTA 3: CTE + COUNT condicional por banda
-- TODO: Por categoría, contar cuántos items hay en cada banda de precio
-- ============================================

-- WITH clasificados AS (
--     SELECT
--         name,
--         category,
--         price,
--         CASE
--             WHEN price >= ___ THEN 'Premium'
--             WHEN price >= ___ THEN 'Estándar'
--             ELSE                   'Económico'
--         END AS price_band
--     FROM items
-- )
-- SELECT
--     category,
--     COUNT(CASE WHEN price_band = 'Premium'   THEN 1 END) AS premium_count,
--     COUNT(CASE WHEN price_band = 'Estándar'  THEN 1 END) AS estandar_count,
--     COUNT(CASE WHEN price_band = 'Económico' THEN 1 END) AS economico_count
-- FROM clasificados
-- GROUP BY category
-- ORDER BY category;
