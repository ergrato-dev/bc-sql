-- ============================================================
-- DEMOS INSTRUCTOR — Semana 01: Introducción a BDR
-- Base de datos: northwind (PostgreSQL 16 · Docker)
-- ⚠️  SOLO USO INTERNO — No compartir con aprendices
-- ============================================================
-- Conectar al contenedor:
--   docker compose -f scripts/docker-compose.yml exec postgres \
--     psql -U bootcamp -d northwind
-- ============================================================
-- NOTA: Los aprendices usan SQLite en semanas 1–8.
--   Estos demos son para ilustración del instructor en vivo.
--   Los conceptos son idénticos; solo cambia el motor.
-- ============================================================


-- ── 1. ¿QUÉ TABLAS TIENE NORTHWIND? ─────────────────────────
-- Punto de partida: mostrar que una BD es un conjunto de tablas.

SELECT table_name
FROM information_schema.tables
WHERE table_schema = 'public'
ORDER BY table_name;


-- ── 2. TABLA = FILAS + COLUMNAS ──────────────────────────────
-- Una tabla es como una hoja de cálculo con reglas estrictas.

SELECT * FROM categories;

SELECT * FROM products LIMIT 10;


-- ── 3. COLUMNAS Y TIPOS DE DATOS ────────────────────────────
-- Cada columna tiene un tipo: texto, número, fecha, booleano.
-- Preguntar: ¿qué tipo esperan para 'unit_price'? ¿para 'discontinued'?

SELECT
    column_name,
    data_type,
    is_nullable
FROM information_schema.columns
WHERE table_name = 'products'
ORDER BY ordinal_position;


-- ── 4. CLAVE PRIMARIA — identidad única de cada fila ─────────
-- No hay dos productos con el mismo product_id.

SELECT product_id, product_name
FROM products
ORDER BY product_id;


-- ── 5. CLAVE FORÁNEA — relación entre tablas ─────────────────
-- category_id en products apunta a categories.category_id.
-- Preguntar: ¿qué pasaría si borramos una categoría que tiene productos?

SELECT
    p.product_id,
    p.product_name,
    p.category_id,
    c.category_name
FROM products p
JOIN categories c ON p.category_id = c.category_id
LIMIT 10;


-- ── 6. CARDINALIDAD 1:N ──────────────────────────────────────
-- Una categoría tiene MUCHOS productos.
-- Mostrarlo con conteo.

SELECT
    c.category_name,
    COUNT(p.product_id) AS total_productos
FROM categories c
JOIN products p ON c.category_id = p.category_id
GROUP BY c.category_name
ORDER BY total_productos DESC;


-- ── 7. ¿CUÁNTOS REGISTROS TIENE CADA TABLA? ──────────────────
-- Dar dimensión a los estudiantes de qué es "datos reales".

SELECT 'categories'   AS tabla, COUNT(*) AS filas FROM categories   UNION ALL
SELECT 'customers',            COUNT(*)           FROM customers      UNION ALL
SELECT 'employees',            COUNT(*)           FROM employees      UNION ALL
SELECT 'orders',               COUNT(*)           FROM orders         UNION ALL
SELECT 'order_details',        COUNT(*)           FROM order_details  UNION ALL
SELECT 'products',             COUNT(*)           FROM products       UNION ALL
SELECT 'suppliers',            COUNT(*)           FROM suppliers;
