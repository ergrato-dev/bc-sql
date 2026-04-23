-- ============================================================
-- DEMOS INSTRUCTOR — Semana 16: Índices y Funciones Integradas
-- Base de datos: northwind (PostgreSQL 16 · Docker)
-- ⚠️  SOLO USO INTERNO — No compartir con aprendices
-- ============================================================
-- Conectar al contenedor:
--   docker compose -f scripts/docker-compose.yml exec postgres \
--     psql -U bootcamp -d northwind
-- ============================================================


-- ── 1. Funciones de cadena ────────────────────────────────────
SELECT
    product_name,
    UPPER(product_name)                     AS en_mayuscula,
    LOWER(product_name)                     AS en_minuscula,
    LENGTH(product_name)                    AS longitud,
    LEFT(product_name, 5)                   AS primeros_5,
    TRIM('  Chai  ')                        AS sin_espacios,
    REPLACE(product_name, 'Sauce', 'Salsa') AS con_reemplazo
FROM products
LIMIT 10;


-- ── 2. Funciones de fecha ─────────────────────────────────────
SELECT
    order_id,
    order_date,
    EXTRACT(YEAR  FROM order_date)              AS anio,
    EXTRACT(MONTH FROM order_date)              AS mes,
    EXTRACT(DOW   FROM order_date)              AS dia_semana,   -- 0=Dom
    TO_CHAR(order_date, 'Month YYYY')           AS mes_literal,
    DATE_TRUNC('month', order_date)::DATE       AS inicio_mes,
    shipped_date - order_date                   AS dias_en_proceso
FROM orders
WHERE shipped_date IS NOT NULL
ORDER BY order_date DESC
LIMIT 10;


-- ── 3. Funciones numéricas ────────────────────────────────────
SELECT
    product_name,
    unit_price,
    ROUND(unit_price, 0)        AS redondeado,
    CEIL(unit_price)            AS techo,
    FLOOR(unit_price)           AS piso,
    ABS(unit_price - 25)        AS diferencia_vs_25
FROM products
ORDER BY unit_price
LIMIT 10;


-- ── 4. EXPLAIN sin índice — mostrar Seq Scan ─────────────────
-- Una query sin índice en columna de filtro:
EXPLAIN
SELECT order_id, order_date, customer_id
FROM orders
WHERE customer_id = 'ALFKI';


-- ── 5. Crear índice y ver la diferencia ───────────────────────
-- Crear índice en customer_id (que usamos como filtro frecuente):
CREATE INDEX IF NOT EXISTS idx_orders_customer_id ON orders(customer_id);

-- Volver a ver el plan — ahora debería usar Index Scan:
EXPLAIN ANALYZE
SELECT order_id, order_date, customer_id
FROM orders
WHERE customer_id = 'ALFKI';


-- ── 6. Índice en columna de fecha ────────────────────────────
-- Consultas por rango de fechas son comunes → benefician de índice B-tree:
CREATE INDEX IF NOT EXISTS idx_orders_order_date ON orders(order_date);

EXPLAIN ANALYZE
SELECT order_id, customer_id, order_date
FROM orders
WHERE order_date BETWEEN '1997-01-01' AND '1997-06-30';


-- ── 7. Ver índices existentes en la BD ────────────────────────
SELECT
    indexname,
    tablename,
    indexdef
FROM pg_indexes
WHERE schemaname = 'public'
ORDER BY tablename, indexname;


-- ── 8. Limpiar índices de demo ────────────────────────────────
DROP INDEX IF EXISTS idx_orders_customer_id;
DROP INDEX IF EXISTS idx_orders_order_date;
