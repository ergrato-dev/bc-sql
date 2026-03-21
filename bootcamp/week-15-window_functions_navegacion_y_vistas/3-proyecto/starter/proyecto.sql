-- ============================================
-- PROYECTO SEMANAL: Análisis temporal con Window Functions y Vistas
-- Semana 15 — LEAD, LAG, FIRST_VALUE, LAST_VALUE, CREATE VIEW
-- PostgreSQL 16
-- ============================================

-- NOTA PARA EL APRENDIZ:
-- Adapta este esquema a tu dominio asignado.
-- Ejemplos:
--   Biblioteca  → monthly_loans, members, books
--   Farmacia    → monthly_sales, medicines, inventory
--   Gimnasio    → monthly_attendance, members, routines
--   Restaurante → daily_orders, dishes, tables

-- TODO: Renombrar las tablas según tu dominio
-- TODO: Agregar columnas específicas de tu dominio

DROP VIEW  IF EXISTS v_period_analysis CASCADE;
DROP TABLE IF EXISTS period_metrics CASCADE;
DROP TABLE IF EXISTS categories CASCADE;

CREATE TABLE categories (
    id   SERIAL PRIMARY KEY,
    name TEXT   NOT NULL
);

CREATE TABLE period_metrics (
    id          SERIAL         PRIMARY KEY,
    period_date DATE           NOT NULL,       -- TODO: renombrar (sale_month, log_date, etc.)
    category_id INT            REFERENCES categories (id),
    value       NUMERIC(12, 2) NOT NULL        -- TODO: renombrar (revenue, count, rate, etc.)
    -- TODO: Agregar columnas específicas del dominio
);

-- TODO: Insertar datos de al menos 3 períodos y 2 categorías
-- Los datos deben reflejar tu dominio asignado
INSERT INTO categories (name) VALUES
    ('Categoría A'),  -- TODO: reemplazar
    ('Categoría B');

INSERT INTO period_metrics (period_date, category_id, value) VALUES
    ('2024-01-01', 1, 1000),  -- TODO: reemplazar con datos reales
    ('2024-02-01', 1, 1200),
    ('2024-03-01', 1,  900),
    ('2024-04-01', 1, 1500),
    ('2024-01-01', 2,  800),
    ('2024-02-01', 2,  850),
    ('2024-03-01', 2,  780),
    ('2024-04-01', 2,  920);


-- ============================================
-- TODO 1: LAG para calcular la variación entre períodos
-- ============================================
-- Muestra el valor actual, el del período anterior (LAG),
-- y la diferencia (delta = value - prev_value).
-- Aplica PARTITION BY category_id para comparar
-- cada categoría con su propio período anterior.

-- TODO: Implementar la consulta con LAG y cálculo de delta
-- Debe mostrar: period_date, category_id, value, prev_value, delta


-- ============================================
-- TODO 2: FIRST_VALUE y LAST_VALUE por categoría
-- ============================================
-- Para cada fila muestra:
--   - El mejor valor histórico de la categoría (FIRST_VALUE ORDER BY value DESC)
--   - El peor valor histórico (LAST_VALUE con frame extendido)
-- Usa WINDOW alias para no repetir la definición.

-- TODO: Implementar la consulta combinando ambas funciones
-- Recuerda: LAST_VALUE necesita ROWS BETWEEN UNBOUNDED PRECEDING
--           AND UNBOUNDED FOLLOWING


-- ============================================
-- TODO 3: CREATE VIEW — encapsular el análisis
-- ============================================
-- Crea la vista v_period_analysis que incluya:
--   period_date, category_id, value,
--   LAG(value) como prev_value,
--   FIRST_VALUE(value) como period_best,
--   LAST_VALUE(value) con frame como period_worst
-- Luego consulta la vista filtrando por category_id = 1.

-- TODO: Crear la vista con CREATE OR REPLACE VIEW v_period_analysis AS ...
-- TODO: Consultar la vista con SELECT * FROM v_period_analysis WHERE category_id = 1
