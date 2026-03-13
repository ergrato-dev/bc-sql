-- ============================================
-- PROYECTO SEMANAL: Funciones de Agregación
-- Semana 06 — COUNT, SUM, AVG, GROUP BY, HAVING
-- ============================================

-- NOTA: Usa el esquema de tu Semana 03. Adapta nombres al dominio.

-- ============================================
-- REPORTE 1: Totales globales
-- ============================================
-- TODO: Cuenta todos los registros y calcula suma/promedio
--       de la columna numérica más relevante de tu dominio
-- SELECT
--     COUNT(*)     AS total_registros,
--     SUM(col_num) AS suma_total,
--     AVG(col_num) AS promedio
-- FROM tu_tabla;


-- ============================================
-- REPORTE 2: Extremos
-- ============================================
-- TODO: Obtén el valor mínimo y máximo de la columna numérica
-- SELECT
--     MIN(col_num) AS minimo,
--     MAX(col_num) AS maximo
-- FROM tu_tabla;


-- ============================================
-- REPORTE 3: Subtotales por categoría (GROUP BY)
-- ============================================
-- TODO: Agrupa por la columna de categoría/tipo principal de tu dominio
--       y calcula COUNT + AVG o SUM para cada grupo
-- SELECT
--     columna_categoria,
--     COUNT(*)     AS total,
--     AVG(col_num) AS promedio
-- FROM   tu_tabla
-- GROUP BY columna_categoria
-- ORDER BY total DESC;


-- ============================================
-- REPORTE 4: Filtro de grupos (HAVING)
-- ============================================
-- TODO: Muestra solo los grupos que superen un umbral de negocio
-- SELECT
--     columna_categoria,
--     COUNT(*) AS total
-- FROM   tu_tabla
-- GROUP BY columna_categoria
-- HAVING COUNT(*) > umbral;
