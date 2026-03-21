-- ============================================
-- PROYECTO SEMANAL: Jerarquías con CTEs Recursivas
-- Semana 13 — WITH RECURSIVE
-- PostgreSQL 16
-- ============================================

-- NOTA PARA EL APRENDIZ:
-- Adapta este esquema a tu dominio asignado.
-- Necesitas una tabla con columna parent_id auto-referencial
-- que genere al menos 3 niveles de profundidad.

-- ============================================
-- TODO: Renombrar la tabla según tu dominio
-- Ejemplo: categories / sections / departments / routines
-- ============================================

DROP TABLE IF EXISTS nodes CASCADE;

CREATE TABLE nodes (
    id        SERIAL  PRIMARY KEY,
    name      TEXT    NOT NULL,
    parent_id INT     REFERENCES nodes (id)
    -- TODO: Agregar columnas específicas de tu dominio
);

-- ============================================
-- TODO: Insertar datos con al menos 3 niveles
-- Nivel 1: registros con parent_id = NULL (raíz)
-- Nivel 2: registros con parent_id del nivel 1
-- Nivel 3: registros con parent_id del nivel 2
-- ============================================

-- INSERT INTO nodes (name, parent_id) VALUES
--     ('Nodo raíz',    NULL),   -- nivel 1
--     ('Hijo A',       1),      -- nivel 2
--     ('Hijo B',       1),      -- nivel 2
--     ('Nieto A1',     2),      -- nivel 3
--     ('Nieto A2',     2);      -- nivel 3


-- ============================================
-- CONSULTA 1: Árbol completo con depth y path
-- TODO: Recorrer todos los nodos desde la raíz
-- Calcular: depth (1, 2, 3...) y path (nombre > nombre > ...)
-- ============================================

-- WITH RECURSIVE arbol AS (
--     -- TODO: Caso base — nodos raíz
--     SELECT
--         id,
--         name,
--         parent_id,
--         1        AS depth,
--         name     AS path
--     FROM nodes
--     WHERE parent_id IS NULL
--
--     UNION ALL
--
--     -- TODO: Caso recursivo — nodos hijo
--     SELECT
--         n.id,
--         n.name,
--         n.parent_id,
--         a.depth + 1,
--         a.path || ' > ' || n.name
--     FROM nodes n
--     INNER JOIN arbol a ON n.parent_id = a.id
-- )
-- SELECT
--     depth,
--     REPEAT('  ', depth - 1) || name AS indented_name,
--     path
-- FROM arbol
-- ORDER BY path;


-- ============================================
-- CONSULTA 2: Nodos de un nivel específico
-- TODO: Filtra solo los nodos de depth = N (elige el nivel)
-- ============================================

-- WITH RECURSIVE arbol AS (
--     SELECT id, name, parent_id, 1 AS depth, name AS path
--     FROM nodes
--     WHERE parent_id IS NULL
--     UNION ALL
--     SELECT n.id, n.name, n.parent_id, a.depth + 1, a.path || ' > ' || n.name
--     FROM nodes n
--     INNER JOIN arbol a ON n.parent_id = a.id
-- )
-- SELECT name, depth, path
-- FROM arbol
-- WHERE depth = ___   -- TODO: reemplaza ___ con el nivel deseado
-- ORDER BY path;


-- ============================================
-- CONSULTA 3: Hojas del árbol (nodos sin hijos)
-- TODO: Detectar nodos que NO tienen parent_id apuntando a ellos
-- ============================================

-- SELECT
--     n.id,
--     n.name
-- FROM nodes n
-- WHERE NOT EXISTS (
--     SELECT 1
--     FROM nodes child
--     WHERE child.parent_id = n.id
-- )
-- ORDER BY n.name;
