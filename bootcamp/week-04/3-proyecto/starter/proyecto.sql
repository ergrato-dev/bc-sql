-- ============================================
-- PROYECTO SEMANAL: Consultas SELECT
-- Semana 04 — SELECT, WHERE, ORDER BY, LIMIT/OFFSET
-- ============================================

-- NOTA PARA EL APRENDIZ:
-- Usa el esquema y datos que cargaste en la Semana 03.
-- Adapta los nombres de tabla y columnas a tu dominio.

-- ============================================
-- CONSULTA 1: Listado general con columnas explícitas
-- ============================================
-- TODO: Lista al menos 4 columnas de tu entidad principal
--       usando alias en español para cada columna
-- SELECT
--     col1 AS alias1,
--     col2 AS alias2,
--     ...
-- FROM tu_tabla;


-- ============================================
-- CONSULTA 2: Filtro por condición simple
-- ============================================
-- TODO: Filtra filas usando una condición de igualdad o comparación
-- SELECT ...
-- FROM   tu_tabla
-- WHERE  columna = valor;


-- ============================================
-- CONSULTA 3: Filtro combinado (AND u OR)
-- ============================================
-- TODO: Combina al menos dos condiciones con AND u OR
-- SELECT ...
-- FROM   tu_tabla
-- WHERE  condicion1
--   AND  condicion2;


-- ============================================
-- CONSULTA 4: Top-N con ORDER BY + LIMIT
-- ============================================
-- TODO: Recupera los 5 primeros registros según un criterio de negocio
-- SELECT ...
-- FROM   tu_tabla
-- ORDER BY columna DESC
-- LIMIT 5;


-- ============================================
-- CONSULTA 5: Paginación (página 1 y página 2)
-- ============================================
-- TODO: Implementa 2 páginas de 3 registros cada una
--       ordenados por un criterio relevante para tu dominio
-- Página 1:
-- SELECT ...
-- FROM   tu_tabla
-- ORDER BY columna ASC
-- LIMIT  3 OFFSET 0;

-- Página 2:
-- SELECT ...
-- FROM   tu_tabla
-- ORDER BY columna ASC
-- LIMIT  3 OFFSET 3;
