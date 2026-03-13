-- ============================================
-- PROYECTO SEMANAL: Subqueries en tu dominio
-- Semana 11 — Subqueries (escalar, IN, EXISTS, FROM)
-- ============================================

-- NOTA PARA EL APRENDIZ:
-- Adapta este esquema a tu dominio asignado.
-- Necesitas al menos dos tablas relacionadas para practicar
-- EXISTS y la tabla derivada.

PRAGMA foreign_keys = ON;

-- ============================================
-- TODO: Renombrar las tablas según tu dominio
-- ============================================
DROP TABLE IF EXISTS child_records;
DROP TABLE IF EXISTS main_items;

CREATE TABLE main_items (
    id       INTEGER PRIMARY KEY AUTOINCREMENT,
    name     TEXT    NOT NULL,
    value    REAL    NOT NULL CHECK (value > 0),
    category TEXT    NOT NULL
    -- TODO: Agregar columnas específicas de tu dominio
);

CREATE TABLE child_records (
    id       INTEGER PRIMARY KEY AUTOINCREMENT,
    item_id  INTEGER NOT NULL REFERENCES main_items (id),
    quantity INTEGER NOT NULL DEFAULT 1
    -- TODO: Agregar columnas específicas
);

-- ============================================
-- TODO: Insertar datos de prueba realistas
-- Incluir al menos 1 item SIN child_records (para NOT EXISTS)
-- ============================================

-- INSERT INTO main_items (name, value, category) VALUES (...);
-- INSERT INTO child_records (item_id, quantity) VALUES (...);


-- ============================================
-- CONSULTA 1: Subquery escalar en WHERE
-- TODO: Items cuyo valor supera el promedio de su categoría
-- ============================================

-- SELECT
--     name,
--     value,
--     category
-- FROM main_items m
-- WHERE value > (
--     SELECT AVG(m2.value)
--     FROM main_items m2
--     WHERE m2.category = m.category
-- )
-- ORDER BY category, value DESC;


-- ============================================
-- CONSULTA 2: Subquery escalar en SELECT
-- TODO: Mostrar el promedio global junto a cada item
-- ============================================

-- SELECT
--     name,
--     value,
--     ROUND((SELECT AVG(value) FROM main_items), 2) AS overall_avg
-- FROM main_items
-- ORDER BY value DESC;


-- ============================================
-- CONSULTA 3: NOT EXISTS — items sin actividad
-- TODO: Items que NO tienen ningún child_record
-- ============================================

-- SELECT
--     name AS item_sin_actividad
-- FROM main_items m
-- WHERE NOT EXISTS (
--     SELECT 1
--     FROM child_records cr
--     WHERE cr.item_id = m.id
-- );


-- ============================================
-- CONSULTA 4: Tabla derivada en FROM
-- TODO: Categorías con total de registros > umbral
-- ============================================

-- SELECT
--     cat_stats.category,
--     cat_stats.total_records
-- FROM (
--     SELECT
--         mi.category,
--         COUNT(cr.id) AS total_records
--     FROM main_items  mi
--     LEFT JOIN child_records cr ON cr.item_id = mi.id
--     GROUP BY mi.category
-- ) AS cat_stats
-- WHERE cat_stats.total_records > 2
-- ORDER BY cat_stats.total_records DESC;
