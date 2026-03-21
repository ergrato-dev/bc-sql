-- Semana 09: INNER JOIN
-- Ejercicio 01 — Descomenta cada bloque en orden

-- ============================================
-- PASO 1: INNER JOIN básico
-- ============================================

-- Empleados con el nombre de su departamento
-- Descomenta las siguientes líneas:

-- SELECT
--     e.first_name,
--     e.last_name,
--     d.name AS department
-- FROM employees e
-- INNER JOIN departments d ON e.department_id = d.id;


-- ============================================
-- PASO 2: Columnas de ambas tablas + ORDER BY
-- ============================================

-- Empleados con sueldo y presupuesto del departamento
-- Descomenta las siguientes líneas:

-- SELECT
--     e.first_name,
--     e.salary,
--     d.name   AS department,
--     d.budget
-- FROM employees e
-- INNER JOIN departments d ON e.department_id = d.id
-- ORDER BY e.salary DESC;


-- ============================================
-- PASO 3: INNER JOIN + filtro WHERE
-- ============================================

-- Solo empleados activos del departamento Engineering
-- Descomenta las siguientes líneas:

-- SELECT
--     e.first_name,
--     e.last_name,
--     e.level
-- FROM employees e
-- INNER JOIN departments d ON e.department_id = d.id
-- WHERE d.name      = 'Engineering'
--   AND e.is_active = 1;


-- ============================================
-- PASO 4: JOIN de tres tablas
-- ============================================

-- Empleados con su departamento y ubicación
-- Descomenta las siguientes líneas:

-- SELECT
--     e.first_name,
--     d.name  AS department,
--     l.name  AS location,
--     l.country
-- FROM employees e
-- INNER JOIN departments d ON e.department_id = d.id
-- INNER JOIN locations   l ON d.location_id   = l.id
-- ORDER BY l.country, d.name;
