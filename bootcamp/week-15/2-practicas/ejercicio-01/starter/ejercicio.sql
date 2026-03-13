-- Semana 15: Window Functions Navegación — Ejercicio 01
-- Ejecuta primero: setup.sql
-- PostgreSQL 16
-- ============================================

-- ============================================
-- PASO 1: LAG — acceder al mes anterior
-- ============================================

-- Muestra el monto del mes anterior usando LAG()
-- El default 0 evita NULL en el primer registro
-- Descomenta las siguientes líneas:

-- SELECT
--     sale_month,
--     amount,
--     LAG(amount, 1, 0) OVER (ORDER BY sale_month) AS prev_amount
-- FROM monthly_sales
-- ORDER BY sale_month;


-- ============================================
-- PASO 2: Calcular la diferencia (delta)
-- ============================================

-- Resta el monto actual menos el del mes anterior
-- Un delta positivo = crecimiento; negativo = caída
-- Descomenta las siguientes líneas:

-- SELECT
--     sale_month,
--     amount,
--     LAG(amount, 1, 0) OVER (ORDER BY sale_month)          AS prev_amount,
--     amount - LAG(amount, 1, 0) OVER (ORDER BY sale_month) AS delta
-- FROM monthly_sales
-- ORDER BY sale_month;


-- ============================================
-- PASO 3: LAG por departamento (PARTITION BY)
-- ============================================

-- La comparación reinicia para cada departamento
-- Compara cada mes con el mes anterior del MISMO departamento
-- Descomenta las siguientes líneas:

-- SELECT
--     sale_month,
--     department_id,
--     amount,
--     LAG(amount, 1, 0) OVER (
--         PARTITION BY department_id
--         ORDER BY sale_month
--     ) AS prev_dept_amount
-- FROM monthly_sales
-- ORDER BY department_id, sale_month;


-- ============================================
-- PASO 4: LEAD — ver el siguiente mes
-- ============================================

-- LEAD accede a la fila siguiente; NULL en el último registro
-- Útil para analizar si el mes actual tendrá crecimiento
-- Descomenta las siguientes líneas:

-- SELECT
--     sale_month,
--     amount,
--     LEAD(amount, 1, NULL) OVER (ORDER BY sale_month) AS next_amount
-- FROM monthly_sales
-- ORDER BY sale_month;
