-- ============================================
-- PROYECTO SEMANAL: SELF JOIN en tu dominio
-- Semana 10 — CROSS JOIN y SELF JOIN
-- ============================================

-- NOTA PARA EL APRENDIZ:
-- Adapta este esquema a tu dominio asignado.
-- La tabla debe tener una columna que apunte a sí misma
-- para representar una jerarquía (padre → hijo).
-- Ejemplos:
--   Biblioteca  → categories (parent_category_id)
--   Farmacia    → medicines  (base_medicine_id)
--   Gimnasio    → exercises  (parent_exercise_id)
-- NO uses uno de esos ejemplos si es tu dominio asignado.

PRAGMA foreign_keys = ON;

-- ============================================
-- TODO: Renombrar la tabla según tu dominio
-- ============================================
DROP TABLE IF EXISTS items;

CREATE TABLE items (
    id        INTEGER PRIMARY KEY,
    name      TEXT    NOT NULL UNIQUE,
    -- TODO: Agregar columnas específicas de tu dominio
    parent_id INTEGER REFERENCES items (id)  -- auto-referencial
);

-- ============================================
-- TODO: Insertar datos con al menos:
--   - 1 registro raíz (parent_id = NULL)
--   - 3 registros hijos del nivel 1
--   - 2 registros del nivel 2 (nietos)
-- ============================================

-- INSERT INTO items (name, parent_id) VALUES (...);


-- ============================================
-- CONSULTA 1: SELF JOIN básico (INNER JOIN)
-- TODO: Mostrar item hijo y su item padre
-- Excluye registros raíz
-- ============================================

-- SELECT
--     child.name  AS item,
--     parent.name AS parent_item
-- FROM items child
-- INNER JOIN items parent ON child.parent_id = parent.id;


-- ============================================
-- CONSULTA 2: Incluir la raíz con LEFT JOIN
-- TODO: Usa COALESCE para etiquetar la raíz
-- ============================================

-- SELECT
--     child.name                        AS item,
--     COALESCE(parent.name, 'Raíz')     AS parent_item
-- FROM items child
-- LEFT JOIN items parent ON child.parent_id = parent.id
-- ORDER BY parent_item, item;


-- ============================================
-- CONSULTA 3: Contar hijos por padre
-- TODO: Cuántos hijos directos tiene cada item
-- ============================================

-- SELECT
--     parent.name   AS parent_item,
--     COUNT(child.id) AS total_children
-- FROM items parent
-- LEFT JOIN items child ON child.parent_id = parent.id
-- GROUP BY parent.id, parent.name
-- HAVING COUNT(child.id) > 0
-- ORDER BY total_children DESC;


-- ============================================
-- CONSULTA 4: Dos niveles jerárquicos
-- TODO: item → padre → abuelo
-- Usa tres aliases: child, parent, grandparent
-- ============================================

-- SELECT
--     child.name       AS item,
--     parent.name      AS parent_item,
--     grandparent.name AS grandparent_item
-- FROM items child
-- LEFT JOIN items parent      ON child.parent_id  = parent.id
-- LEFT JOIN items grandparent ON parent.parent_id = grandparent.id
-- ORDER BY grandparent_item, parent_item, item;
