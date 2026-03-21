-- Semana 16: Índices y Funciones — Ejercicio 01
-- Ejecuta primero: setup.sql
-- PostgreSQL 16
-- ============================================

-- ============================================
-- PASO 1: EXPLAIN sin índice
-- ============================================

-- Observa el plan antes de crear el índice
-- Busca "Seq Scan" en la salida — recorre toda la tabla
-- Descomenta las siguientes líneas:

-- EXPLAIN
-- SELECT * FROM employees WHERE department_id = 2;


-- ============================================
-- PASO 2: Crear índice y repetir EXPLAIN
-- ============================================

-- Crea el índice en department_id
-- Luego observa si el plan cambia a "Index Scan"
-- Descomenta las siguientes líneas:

-- CREATE INDEX idx_employees_department_id
--     ON employees (department_id);

-- EXPLAIN
-- SELECT * FROM employees WHERE department_id = 2;


-- ============================================
-- PASO 3: Índice UNIQUE en email
-- ============================================

-- Un índice único garantiza unicidad + acelera búsquedas por email exacto
-- EXPLAIN ANALYZE también ejecuta la query y muestra tiempos reales
-- Descomenta las siguientes líneas:

-- CREATE UNIQUE INDEX idx_employees_email
--     ON employees (email);

-- EXPLAIN ANALYZE
-- SELECT * FROM employees WHERE email = 'ana.garcia@empresa.com';


-- ============================================
-- PASO 4: Ver los índices creados
-- ============================================

-- Consulta el catálogo del sistema para listar todos los índices
-- pg_indexes es una vista del sistema de PostgreSQL
-- Descomenta las siguientes líneas:

-- SELECT
--     indexname,
--     indexdef
-- FROM pg_indexes
-- WHERE tablename = 'employees';
