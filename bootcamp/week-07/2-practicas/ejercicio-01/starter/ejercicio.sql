-- ============================================
-- Semana 07: NULL — Ejercicio 01
-- IS NULL, IS NOT NULL, COALESCE, COUNT
-- ============================================
-- Ejecuta primero: setup.sql

-- ============================================
-- PASO 1: IS NULL — empleados sin email
-- ============================================

-- SELECT id, first_name, email
-- FROM   employees
-- WHERE  email IS NULL;


-- ============================================
-- PASO 2: IS NOT NULL — empleados con email
-- ============================================

-- SELECT id, first_name, email
-- FROM   employees
-- WHERE  email IS NOT NULL;


-- ============================================
-- PASO 3: COALESCE — reemplazar NULL en bonus
-- ============================================

-- SELECT
--     first_name,
--     bonus,
--     COALESCE(bonus, 0) AS bonus_efectivo
-- FROM employees;


-- ============================================
-- PASO 4: COUNT(*) vs COUNT(columna)
-- ============================================

-- Observa la diferencia entre total de filas
-- y filas con valores conocidos en cada columna:

-- SELECT
--     COUNT(*)      AS total_empleados,
--     COUNT(email)  AS con_email,
--     COUNT(bonus)  AS con_bonus
-- FROM employees;
