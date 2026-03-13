-- Semana 13: CTEs Recursivas — Ejercicio 01
-- Ejecuta primero: setup.sql
-- PostgreSQL 16
-- ============================================

-- ============================================
-- PASO 1: Consulta simple — empleados y su manager
-- ============================================

-- Muestra cada empleado con el nombre de su manager
-- Usa LEFT JOIN para incluir al CEO (sin manager)
-- Descomenta las siguientes líneas:

-- SELECT
--     e.employee_id,
--     e.first_name,
--     e.job_title,
--     m.first_name AS manager_name
-- FROM employees e
-- LEFT JOIN employees m ON e.manager_id = m.employee_id
-- ORDER BY e.manager_id NULLS FIRST;


-- ============================================
-- PASO 2: CTE recursiva — profundidad y path
-- ============================================

-- Recorre toda la jerarquía desde la raíz (manager_id IS NULL)
-- Calcula depth (nivel) y path (ruta completa desde la raíz)
-- Descomenta las siguientes líneas:

-- WITH RECURSIVE org_chart AS (
--     -- Caso base: CEO sin manager
--     SELECT
--         employee_id,
--         first_name,
--         manager_id,
--         1            AS depth,
--         first_name   AS path
--     FROM employees
--     WHERE manager_id IS NULL
--
--     UNION ALL
--
--     -- Caso recursivo: empleados cuyo manager ya está en el CTE
--     SELECT
--         e.employee_id,
--         e.first_name,
--         e.manager_id,
--         oc.depth + 1,
--         oc.path || ' > ' || e.first_name
--     FROM employees e
--     INNER JOIN org_chart oc ON e.manager_id = oc.employee_id
-- )
-- SELECT
--     depth,
--     REPEAT('  ', depth - 1) || first_name AS indented_name,
--     path
-- FROM org_chart
-- ORDER BY path;


-- ============================================
-- PASO 3: Filtrar por nivel de profundidad
-- ============================================

-- Usa la misma CTE recursiva pero filtra solo depth = 3
-- Descomenta las siguientes líneas:

-- WITH RECURSIVE org_chart AS (
--     SELECT
--         employee_id,
--         first_name,
--         manager_id,
--         1          AS depth,
--         first_name AS path
--     FROM employees
--     WHERE manager_id IS NULL
--     UNION ALL
--     SELECT
--         e.employee_id,
--         e.first_name,
--         e.manager_id,
--         oc.depth + 1,
--         oc.path || ' > ' || e.first_name
--     FROM employees e
--     INNER JOIN org_chart oc ON e.manager_id = oc.employee_id
-- )
-- SELECT first_name, depth, path
-- FROM org_chart
-- WHERE depth = 3
-- ORDER BY path;


-- ============================================
-- PASO 4: Subordinados de un empleado específico
-- ============================================

-- Inicia la recursión desde Ana y devuelve todos sus subordinados
-- La profundidad 0 es la propia Ana
-- Descomenta las siguientes líneas:

-- WITH RECURSIVE subordinados AS (
--     SELECT employee_id, first_name, manager_id, 0 AS depth
--     FROM employees
--     WHERE first_name = 'Ana'
--     UNION ALL
--     SELECT e.employee_id, e.first_name, e.manager_id, s.depth + 1
--     FROM employees e
--     INNER JOIN subordinados s ON e.manager_id = s.employee_id
-- )
-- SELECT first_name, depth
-- FROM subordinados
-- ORDER BY depth, first_name;
