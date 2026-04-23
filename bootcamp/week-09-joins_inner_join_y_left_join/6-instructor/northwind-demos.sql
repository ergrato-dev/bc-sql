-- ============================================================
-- DEMOS INSTRUCTOR — Semana 09: JOINs — INNER JOIN y LEFT JOIN
-- Base de datos: northwind (PostgreSQL 16 · Docker)
-- ⚠️  SOLO USO INTERNO — No compartir con aprendices
-- ============================================================
-- Conectar al contenedor:
--   docker compose -f scripts/docker-compose.yml exec postgres \
--     psql -U bootcamp -d northwind
-- ============================================================


-- ── 1. INNER JOIN — solo filas que cruzan ────────────────────
-- Pedido + cliente + empleado que lo gestionó:
SELECT
    o.order_id,
    c.company_name  AS cliente,
    e.first_name || ' ' || e.last_name  AS empleado,
    o.order_date
FROM orders o
INNER JOIN customers c ON o.customer_id = c.customer_id
INNER JOIN employees e ON o.employee_id = e.employee_id
ORDER BY o.order_date DESC
LIMIT 15;


-- ── 2. INNER JOIN con 4 tablas ────────────────────────────────
-- Detalle de factura: producto, categoría, precio, cantidad:
SELECT
    o.order_id,
    p.product_name,
    cat.category_name,
    od.unit_price,
    od.quantity,
    od.discount,
    ROUND(od.unit_price * od.quantity * (1 - od.discount), 2) AS subtotal
FROM orders o
INNER JOIN order_details od  ON o.order_id   = od.order_id
INNER JOIN products      p   ON od.product_id = p.product_id
INNER JOIN categories    cat ON p.category_id = cat.category_id
WHERE o.order_id = 10248;  -- mostrar un pedido concreto


-- ── 3. LEFT JOIN — detectar registros huérfanos ──────────────
-- ¿Hay clientes que nunca hicieron un pedido?
SELECT
    c.customer_id,
    c.company_name,
    c.country,
    o.order_id      -- será NULL si el cliente no tiene pedidos
FROM customers c
LEFT JOIN orders o ON c.customer_id = o.customer_id
WHERE o.order_id IS NULL;


-- ── 4. LEFT JOIN — enriquecer con datos opcionales ───────────
-- Productos con su categoría (LEFT por si algún product.category_id es NULL):
SELECT
    p.product_name,
    p.unit_price,
    COALESCE(c.category_name, 'Sin categoría') AS categoria
FROM products p
LEFT JOIN categories c ON p.category_id = c.category_id
ORDER BY p.product_name;


-- ── 5. Diferencia visual: INNER vs LEFT ───────────────────────
-- INNER: solo clientes CON pedidos
SELECT COUNT(DISTINCT c.customer_id) AS clientes_con_pedidos
FROM customers c
INNER JOIN orders o ON c.customer_id = o.customer_id;

-- LEFT: todos los clientes, hayan pedido o no
SELECT COUNT(DISTINCT c.customer_id) AS todos_los_clientes
FROM customers c
LEFT JOIN orders o ON c.customer_id = o.customer_id;


-- ── 6. Aggregation sobre JOIN ────────────────────────────────
-- Total facturado por cliente (solo los que tienen pedidos):
SELECT
    c.company_name,
    c.country,
    COUNT(DISTINCT o.order_id)                                    AS pedidos,
    ROUND(SUM(od.unit_price * od.quantity * (1 - od.discount)), 2) AS facturado
FROM customers c
INNER JOIN orders       o  ON c.customer_id  = o.customer_id
INNER JOIN order_details od ON o.order_id    = od.order_id
GROUP BY c.company_name, c.country
ORDER BY facturado DESC
LIMIT 10;
