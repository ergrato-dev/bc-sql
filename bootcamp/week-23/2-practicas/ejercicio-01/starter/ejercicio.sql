-- ============================================
-- Semana 23: Optimización y EXPLAIN ANALYZE
-- Ejercicio 01 — EXPLAIN ANALYZE e índice B-tree
-- Motor: PostgreSQL 16
-- ============================================

-- ============================================
-- PASO 1: EXPLAIN sin índice
-- ============================================

-- Observar que usa Seq Scan sobre orders
-- Descomenta las siguientes líneas:

-- EXPLAIN SELECT *
-- FROM orders
-- WHERE customer_id = 15;


-- ============================================
-- PASO 2: Crear índice y comparar
-- ============================================

-- Descomenta las siguientes líneas:

-- CREATE INDEX idx_orders_customer ON orders (customer_id);

-- EXPLAIN ANALYZE SELECT *
-- FROM orders
-- WHERE customer_id = 15;


-- ============================================
-- PASO 3: Índice compuesto para JOIN
-- ============================================

-- Descomenta las siguientes líneas:

-- CREATE INDEX idx_orders_status_cust ON orders (status, customer_id);

-- EXPLAIN ANALYZE
-- SELECT o.id, o.total_amount, c.name
-- FROM orders o
-- JOIN customers c ON o.customer_id = c.id
-- WHERE o.status = 'pending';


-- ============================================
-- PASO 4: Index Only Scan con índice cubriente
-- ============================================

-- Descomenta las siguientes líneas:

-- CREATE INDEX idx_orders_cover
--     ON orders (status, created_at, total_amount);

-- EXPLAIN ANALYZE
-- SELECT status, created_at, total_amount
-- FROM orders
-- WHERE status = 'pending';
