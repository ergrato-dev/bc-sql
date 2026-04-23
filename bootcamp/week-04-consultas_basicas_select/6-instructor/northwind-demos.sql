-- ============================================================
-- DEMOS INSTRUCTOR — Semana 04: Consultas básicas SELECT
-- Base de datos: northwind (PostgreSQL 16 · Docker)
-- ⚠️  SOLO USO INTERNO — No compartir con aprendices
-- ============================================================
-- Conectar al contenedor:
--   docker compose -f scripts/docker-compose.yml exec postgres \
--     psql -U bootcamp -d northwind
-- ============================================================


-- ── 1. SELECT * vs columnas explícitas ───────────────────────
-- Mostrar por qué SELECT * es problemático en producción.

SELECT * FROM products LIMIT 5;

-- ✅ Preferir columnas explícitas:
SELECT product_id, product_name, unit_price FROM products LIMIT 5;


-- ── 2. ALIAS con AS ──────────────────────────────────────────
-- Los alias mejoran la legibilidad del resultado.

SELECT
    product_name    AS nombre,
    unit_price      AS precio,
    units_in_stock  AS stock
FROM products
LIMIT 10;


-- ── 3. DISTINCT — eliminar duplicados ────────────────────────
-- ¿Cuántos países distintos tienen nuestros clientes?

SELECT country FROM customers ORDER BY country;          -- con duplicados
SELECT DISTINCT country FROM customers ORDER BY country; -- sin duplicados


-- ── 4. ORDER BY — ordenar resultados ─────────────────────────
-- Los 10 productos más caros:
SELECT product_name, unit_price
FROM products
ORDER BY unit_price DESC
LIMIT 10;

-- Los 10 productos más baratos que tienen stock:
SELECT product_name, unit_price, units_in_stock
FROM products
WHERE units_in_stock > 0
ORDER BY unit_price ASC
LIMIT 10;


-- ── 5. LIMIT y OFFSET — paginación ───────────────────────────
-- Página 1 (primeros 5):
SELECT product_id, product_name FROM products ORDER BY product_id LIMIT 5 OFFSET 0;

-- Página 2 (siguientes 5):
SELECT product_id, product_name FROM products ORDER BY product_id LIMIT 5 OFFSET 5;


-- ── 6. Expresiones calculadas en SELECT ──────────────────────
-- Calcular el valor total del inventario por producto.

SELECT
    product_name,
    unit_price,
    units_in_stock,
    ROUND(unit_price * units_in_stock, 2) AS valor_inventario
FROM products
ORDER BY valor_inventario DESC
LIMIT 10;


-- ── 7. Concatenación de texto ────────────────────────────────
-- Nombre completo de empleados.

SELECT
    first_name || ' ' || last_name  AS nombre_completo,
    title                           AS cargo,
    hire_date
FROM employees
ORDER BY hire_date;
