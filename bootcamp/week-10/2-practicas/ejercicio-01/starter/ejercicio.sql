-- Semana 10: CROSS JOIN
-- Ejercicio 01 — Descomenta cada bloque en orden

-- ============================================
-- PASO 1: CROSS JOIN básico
-- ============================================

-- Todas las combinaciones de departamento × nivel
-- Sin cláusula ON — no hay condición de unión
-- Descomenta las siguientes líneas:

-- SELECT
--     d.name  AS department,
--     l.name  AS level
-- FROM departments d
-- CROSS JOIN job_levels l
-- ORDER BY d.name, l.rank;


-- ============================================
-- PASO 2: Verificar el total de combinaciones
-- ============================================

-- Contar el producto cartesiano: debe ser 4 × 3 = 12
-- Descomenta las siguientes líneas:

-- SELECT COUNT(*) AS total_combinations
-- FROM departments d
-- CROSS JOIN job_levels l;


-- ============================================
-- PASO 3: Filtrar con WHERE
-- ============================================

-- Solo combinaciones de Engineering (3 filas)
-- Descomenta las siguientes líneas:

-- SELECT
--     d.name  AS department,
--     l.name  AS level
-- FROM departments  d
-- CROSS JOIN job_levels l
-- WHERE d.name = 'Engineering'
-- ORDER BY l.rank;


-- ============================================
-- PASO 4: Grilla con salario base
-- ============================================

-- Combinar dept × nivel mostrando el sueldo estimado
-- Descomenta las siguientes líneas:

-- SELECT
--     d.name         AS department,
--     l.name         AS level,
--     l.base_salary  AS base_salary
-- FROM departments  d
-- CROSS JOIN job_levels l
-- ORDER BY d.name, l.rank;
