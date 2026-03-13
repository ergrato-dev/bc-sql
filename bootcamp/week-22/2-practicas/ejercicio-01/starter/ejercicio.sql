-- ============================================
-- Semana 22: JSON y JSONB
-- Ejercicio 01 — Operadores de acceso JSONB
-- Motor: PostgreSQL 16
-- ============================================

-- ============================================
-- PASO 1: Inspeccionar la columna JSONB
-- ============================================

-- Descomenta las siguientes líneas:

-- SELECT
--     id,
--     name,
--     attributes
-- FROM products;


-- ============================================
-- PASO 2: Acceso con -> y ->>
-- ============================================

-- -> retorna JSONB; ->> retorna TEXT
-- Descomenta las siguientes líneas:

-- SELECT
--     name,
--     attributes -> 'color'  AS color_jsonb,
--     attributes ->> 'color' AS color_text
-- FROM products
-- WHERE attributes ? 'color';


-- ============================================
-- PASO 3: Filtrar por valor de campo
-- ============================================

-- Descomenta las siguientes líneas:

-- SELECT id, name, category
-- FROM products
-- WHERE attributes ->> 'color' = 'silver';


-- ============================================
-- PASO 4: Acceso anidado con #>>
-- ============================================

-- Descomenta las siguientes líneas:

-- SELECT
--     name,
--     attributes #>> '{sensor, megapixels}' AS megapixels,
--     attributes #>> '{sensor, type}'       AS sensor_type
-- FROM products
-- WHERE attributes ? 'sensor';
