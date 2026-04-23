-- ============================================================
-- DEMOS INSTRUCTOR — Semana 06: Funciones de agregación
-- Base de datos: northwind (PostgreSQL 16 · Docker)
-- ⚠️  SOLO USO INTERNO — No compartir con aprendices
-- ============================================================
-- Conectar al contenedor:
--   docker compose -f scripts/docker-compose.yml exec postgres \
--     psql -U bootcamp -d northwind
-- ============================================================


-- ── 1. COUNT ─────────────────────────────────────────────────
-- ¿Cuántos pedidos hay en total?
SELECT COUNT(*) AS total_pedidos FROM orders;

-- COUNT(*) vs COUNT(columna): la diferencia con NULLs
-- region puede ser NULL; COUNT(region) < COUNT(*)
SELECT
    COUNT(*)       AS total_clientes,
    COUNT(region)  AS con_region
FROM customers;


-- ── 2. SUM y AVG ─────────────────────────────────────────────
-- Valor total facturado en todos los pedidos:
SELECT ROUND(SUM(unit_price * quantity * (1 - discount)), 2) AS facturacion_total
FROM order_details;

-- Precio promedio, mínimo y máximo de productos activos:
SELECT
    ROUND(AVG(unit_price), 2) AS precio_promedio,
    MIN(unit_price)           AS precio_minimo,
    MAX(unit_price)           AS precio_maximo
FROM products
WHERE discontinued = FALSE;


-- ── 3. GROUP BY — agregar por categoría ──────────────────────
-- Ventas totales por categoría de producto:
SELECT
    c.category_name,
    COUNT(od.order_id)                                    AS lineas_pedido,
    SUM(od.quantity)                                      AS unidades_vendidas,
    ROUND(SUM(od.unit_price * od.quantity * (1 - od.discount)), 2) AS total_vendido
FROM categories c
JOIN products   p  ON c.category_id  = p.category_id
JOIN order_details od ON p.product_id = od.product_id
GROUP BY c.category_name
ORDER BY total_vendido DESC;


-- ── 4. GROUP BY múltiples columnas ───────────────────────────
-- Pedidos por empleado y año:
SELECT
    e.first_name || ' ' || e.last_name  AS empleado,
    EXTRACT(YEAR FROM o.order_date)     AS anio,
    COUNT(o.order_id)                   AS pedidos
FROM employees e
JOIN orders o ON e.employee_id = o.employee_id
GROUP BY empleado, anio
ORDER BY empleado, anio;


-- ── 5. HAVING — filtrar grupos ────────────────────────────────
-- HAVING filtra GRUPOS; WHERE filtra FILAS antes de agrupar.

-- Clientes con más de 10 pedidos:
SELECT
    customer_id,
    COUNT(*) AS total_pedidos
FROM orders
GROUP BY customer_id
HAVING COUNT(*) > 10
ORDER BY total_pedidos DESC;

-- Categorías con precio promedio mayor a $30:
SELECT
    c.category_name,
    ROUND(AVG(p.unit_price), 2) AS precio_promedio
FROM categories c
JOIN products p ON c.category_id = p.category_id
GROUP BY c.category_name
HAVING AVG(p.unit_price) > 30
ORDER BY precio_promedio DESC;


-- ── 6. WHERE + GROUP BY + HAVING juntos ──────────────────────
-- Categorías con más de 5 productos activos y precio promedio > 20:
SELECT
    c.category_name,
    COUNT(p.product_id)         AS productos_activos,
    ROUND(AVG(p.unit_price), 2) AS precio_promedio
FROM categories c
JOIN products p ON c.category_id = p.category_id
WHERE p.discontinued = FALSE           -- filtra filas ANTES de agrupar
GROUP BY c.category_name
HAVING COUNT(p.product_id) > 5         -- filtra GRUPOS
ORDER BY precio_promedio DESC;
