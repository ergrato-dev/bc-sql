-- ============================================================
-- DEMOS INSTRUCTOR — Semana 23: Optimización y EXPLAIN ANALYZE
-- Base de datos: northwind (PostgreSQL 16 · Docker)
-- ⚠️  SOLO USO INTERNO — No compartir con aprendices
-- ============================================================
-- Conectar al contenedor:
--   docker compose -f scripts/docker-compose.yml exec postgres \
--     psql -U bootcamp -d northwind
-- ============================================================
-- TIP: Antes de la demo, limpiar la caché para resultados reales:
--   DISCARD ALL;
-- ============================================================


-- ── 0. Estado inicial — ver índices existentes en orders ─────
SELECT indexname, indexdef
FROM pg_indexes
WHERE tablename = 'orders';


-- ── 1. Seq Scan — query sin índice ────────────────────────────
-- Leer el plan: nodos, cost, rows, actual time

EXPLAIN ANALYZE
SELECT order_id, customer_id, order_date
FROM orders
WHERE customer_id = 'ALFKI';
-- → Observar: Seq Scan, rows estimadas vs reales


-- ── 2. Crear índice y comparar ────────────────────────────────
CREATE INDEX IF NOT EXISTS idx_demo_orders_customer ON orders(customer_id);

EXPLAIN ANALYZE
SELECT order_id, customer_id, order_date
FROM orders
WHERE customer_id = 'ALFKI';
-- → Observar: Index Scan, tiempo reducido


-- ── 3. Rango de fechas — sin y con índice ─────────────────────
EXPLAIN ANALYZE
SELECT order_id, customer_id, order_date
FROM orders
WHERE order_date BETWEEN '1997-01-01' AND '1997-06-30';

CREATE INDEX IF NOT EXISTS idx_demo_orders_date ON orders(order_date);

EXPLAIN ANALYZE
SELECT order_id, customer_id, order_date
FROM orders
WHERE order_date BETWEEN '1997-01-01' AND '1997-06-30';


-- ── 4. Función en WHERE rompe el índice ───────────────────────
-- ⚠️  Anti-patrón: aplicar función a columna indexada
EXPLAIN ANALYZE
SELECT order_id, order_date
FROM orders
WHERE EXTRACT(YEAR FROM order_date) = 1997;
-- → Seq Scan aunque haya índice en order_date

-- ✅ Solución: usar rango de fechas directamente
EXPLAIN ANALYZE
SELECT order_id, order_date
FROM orders
WHERE order_date >= '1997-01-01' AND order_date < '1998-01-01';
-- → Index Scan


-- ── 5. JOIN — índice en FK ────────────────────────────────────
EXPLAIN ANALYZE
SELECT o.order_id, c.company_name, o.order_date
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
WHERE c.country = 'Germany';


-- ── 6. Lectura del plan — nodos comunes ──────────────────────
-- (Referencia para explicar al aula)
--
-- Seq Scan      → lee toda la tabla fila por fila
-- Index Scan    → usa B-tree, lee nodos del árbol + filas de heap
-- Index Only Scan → todo en el índice, no toca el heap
-- Bitmap Heap Scan → mezcla de índice + heap para rangos amplios
-- Hash Join     → construye hash table del lado menor y sondea
-- Nested Loop   → para cada fila exterior, busca en interior (ideal con índice)
-- Merge Join    → ambas tablas ordenadas, eficiente en grandes joins
--
-- cost=X..Y     → X = costo hasta primera fila, Y = costo total (estimado)
-- rows=N        → filas estimadas (comparar con "actual rows")
-- actual time   → tiempo real en milisegundos (solo con ANALYZE)
-- loops=N       → veces que se ejecutó el nodo


-- ── 7. Limpiar índices de demo ────────────────────────────────
DROP INDEX IF EXISTS idx_demo_orders_customer;
DROP INDEX IF EXISTS idx_demo_orders_date;
