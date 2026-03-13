-- Semana 12: CTEs y CASE WHEN — Ejercicio 02
-- Ejecuta primero: setup.sql
-- ============================================

-- ============================================
-- PASO 1: CASE WHEN — banda salarial
-- ============================================

-- Clasifica cada empleado activo en 'Alto' (>=70000),
-- 'Medio' (>=50000) o 'Bajo' (resto)
-- Descomenta las siguientes líneas:

-- SELECT
--     first_name,
--     last_name,
--     salary,
--     CASE
--         WHEN salary >= 70000 THEN 'Alto'
--         WHEN salary >= 50000 THEN 'Medio'
--         ELSE                      'Bajo'
--     END AS salary_band
-- FROM employees
-- WHERE is_active = 1
-- ORDER BY salary DESC;


-- ============================================
-- PASO 2: CASE simple — etiqueta corta del depto
-- ============================================

-- Mapea department_id a una etiqueta corta
-- Descomenta las siguientes líneas:

-- SELECT
--     first_name,
--     department_id,
--     CASE department_id
--         WHEN 1 THEN 'Tech'
--         WHEN 2 THEN 'Mkt'
--         WHEN 3 THEN 'HR'
--         ELSE        'Otro'
--     END AS dept_short
-- FROM employees
-- ORDER BY department_id;


-- ============================================
-- PASO 3: CASE WHEN con COUNT condicional
-- ============================================

-- Cuenta high_earners (>=70000), mid_earners (50000-69999)
-- y low_earners (<50000) por departamento
-- Descomenta las siguientes líneas:

-- SELECT
--     department_id,
--     COUNT(*) AS total,
--     COUNT(CASE WHEN salary >= 70000 THEN 1 END)                     AS high_earners,
--     COUNT(CASE WHEN salary BETWEEN 50000 AND 69999 THEN 1 END)      AS mid_earners,
--     COUNT(CASE WHEN salary < 50000 THEN 1 END)                      AS low_earners
-- FROM employees
-- WHERE is_active = 1
-- GROUP BY department_id
-- ORDER BY department_id;


-- ============================================
-- PASO 4: CTE con CASE WHEN — reporte por banda
-- ============================================

-- El CTE clasifica cada empleado activo con su banda salarial
-- La consulta principal agrupa por banda y calcula promedio
-- Descomenta las siguientes líneas:

-- WITH clasificados AS (
--     SELECT
--         e.first_name,
--         e.salary,
--         d.name AS department_name,
--         CASE
--             WHEN e.salary >= 70000 THEN 'Alto'
--             WHEN e.salary >= 50000 THEN 'Medio'
--             ELSE                        'Bajo'
--         END AS salary_band
--     FROM employees e
--     INNER JOIN departments d ON e.department_id = d.id
--     WHERE e.is_active = 1
-- )
-- SELECT
--     salary_band,
--     COUNT(*)              AS total,
--     ROUND(AVG(salary), 2) AS avg_salary
-- FROM clasificados
-- GROUP BY salary_band
-- ORDER BY avg_salary DESC;
