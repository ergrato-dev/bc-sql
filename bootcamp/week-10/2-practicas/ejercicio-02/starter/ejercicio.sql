-- Semana 10: SELF JOIN
-- Ejercicio 02 — Descomenta cada bloque en orden

-- ============================================
-- PASO 1: SELF JOIN básico (INNER JOIN)
-- ============================================

-- Empleados con el nombre de su jefe directo
-- El CEO queda excluido (manager_id = NULL)
-- Descomenta las siguientes líneas:

-- SELECT
--     e.first_name  AS employee,
--     m.first_name  AS manager
-- FROM employees e
-- INNER JOIN employees m ON e.manager_id = m.id;


-- ============================================
-- PASO 2: Incluir al CEO con LEFT JOIN + COALESCE
-- ============================================

-- COALESCE muestra 'CEO' cuando manager es NULL
-- Descomenta las siguientes líneas:

-- SELECT
--     e.first_name                   AS employee,
--     COALESCE(m.first_name, 'CEO')  AS manager
-- FROM employees  e
-- LEFT JOIN employees m ON e.manager_id = m.id
-- ORDER BY manager, employee;


-- ============================================
-- PASO 3: Contar reportes directos por manager
-- ============================================

-- Cuántos empleados reportan a cada persona
-- Descomenta las siguientes líneas:

-- SELECT
--     m.first_name    AS manager,
--     COUNT(e.id)     AS direct_reports
-- FROM employees  m
-- LEFT JOIN employees e ON e.manager_id = m.id
-- GROUP BY m.id, m.first_name
-- HAVING COUNT(e.id) > 0
-- ORDER BY direct_reports DESC;


-- ============================================
-- PASO 4: Jerarquía de dos niveles
-- ============================================

-- Empleado → su jefe → el jefe del jefe
-- Usa tres aliases: e, m, gm (grand manager)
-- Descomenta las siguientes líneas:

-- SELECT
--     e.first_name   AS employee,
--     m.first_name   AS manager,
--     gm.first_name  AS grand_manager
-- FROM employees e
-- LEFT JOIN employees m  ON e.manager_id = m.id
-- LEFT JOIN employees gm ON m.manager_id = gm.id
-- ORDER BY gm.first_name, m.first_name, e.first_name;
