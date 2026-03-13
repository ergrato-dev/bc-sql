-- Semana 16: Índices y Funciones — Ejercicio 02
-- Ejecuta primero: setup.sql
-- PostgreSQL 16
-- ============================================

-- ============================================
-- PASO 1: Funciones de cadena
-- ============================================

-- Combina first_name y last_name en mayúsculas
-- Extrae el dominio del email después del @
-- POSITION('@' IN email) devuelve la posición del arroba
-- Descomenta las siguientes líneas:

-- SELECT
--     UPPER(first_name) || ' ' || UPPER(last_name) AS full_name_upper,
--     SUBSTRING(email FROM POSITION('@' IN email) + 1) AS email_domain,
--     LENGTH(first_name) AS name_length
-- FROM employees
-- ORDER BY full_name_upper;


-- ============================================
-- PASO 2: Funciones de fecha
-- ============================================

-- AGE calcula el intervalo entre dos fechas
-- EXTRACT obtiene un campo específico del intervalo (YEAR, MONTH, DAY)
-- TO_CHAR formatea la fecha como string legible
-- Descomenta las siguientes líneas:

-- SELECT
--     first_name,
--     hire_date,
--     TO_CHAR(hire_date, 'DD/MM/YYYY') AS hire_fmt,
--     EXTRACT(YEAR FROM AGE(CURRENT_DATE, hire_date))::INT AS years_in_company
-- FROM employees
-- ORDER BY hire_date;


-- ============================================
-- PASO 3: Funciones numéricas
-- ============================================

-- ROUND(n, 2) redondea a 2 decimales
-- División / 12 para salario mensual
-- Multiplicación * 1.10 para aplicar 10% de bono
-- Descomenta las siguientes líneas:

-- SELECT
--     first_name,
--     salary,
--     ROUND(salary / 12, 2)            AS monthly_salary,
--     ROUND(salary * 1.10, 2)          AS salary_with_bonus,
--     ROUND(salary * 1.10 - salary, 2) AS bonus_amount
-- FROM employees
-- ORDER BY salary DESC;


-- ============================================
-- PASO 4: Reporte combinado
-- ============================================

-- Combina funciones de cadena, fecha y numérica en un solo reporte
-- Solo empleados activos, ordenados por antigüedad y luego salario
-- Descomenta las siguientes líneas:

-- SELECT
--     UPPER(first_name) || ' ' || UPPER(last_name)         AS employee,
--     TO_CHAR(hire_date, 'Mon YYYY')                       AS hired,
--     EXTRACT(YEAR FROM AGE(CURRENT_DATE, hire_date))::INT AS years,
--     ROUND(salary / 12, 2)                                AS monthly
-- FROM employees
-- WHERE is_active = TRUE
-- ORDER BY years DESC, salary DESC;
