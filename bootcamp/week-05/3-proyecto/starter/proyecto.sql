-- ============================================
-- PROYECTO SEMANAL: Operadores y Filtros
-- Semana 05 — BETWEEN, IN, LIKE
-- ============================================

-- NOTA: Usa el esquema cargado en la Semana 03.
-- Adapta los nombres de tablas y columnas a tu dominio.

-- ============================================
-- CONSULTA 1: Filtro con BETWEEN
-- ============================================
-- TODO: Filtra registros de tu entidad principal usando un rango
--       (precio, cantidad, fecha, id, etc.)
-- SELECT ...
-- FROM   tu_tabla
-- WHERE  columna_numerica BETWEEN valor_min AND valor_max;


-- ============================================
-- CONSULTA 2: Filtro con IN
-- ============================================
-- TODO: Filtra por una lista de categorías, estados o ids relevantes
-- SELECT ...
-- FROM   tu_tabla
-- WHERE  columna_categorica IN (valor1, valor2, valor3);


-- ============================================
-- CONSULTA 3: Búsqueda de texto con LIKE
-- ============================================
-- TODO: Busca registros cuyo nombre o descripción contenga un patrón
-- SELECT ...
-- FROM   tu_tabla
-- WHERE  columna_texto LIKE '%patron%';


-- ============================================
-- CONSULTA 4: Filtro combinado (≥ 3 operadores)
-- ============================================
-- TODO: Combina BETWEEN, IN y/o LIKE con AND/OR
--       Usa paréntesis si mezclas AND y OR
-- SELECT ...
-- FROM   tu_tabla
-- WHERE  condicion1
--   AND  condicion2
--   AND  condicion3
-- ORDER BY columna_relevante;
