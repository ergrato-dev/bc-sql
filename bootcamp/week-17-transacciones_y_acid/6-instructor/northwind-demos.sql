-- ============================================================
-- DEMOS INSTRUCTOR — Semana 17: Transacciones y ACID
-- Base de datos: northwind (PostgreSQL 16 · Docker)
-- ⚠️  SOLO USO INTERNO — No compartir con aprendices
-- ============================================================
-- Conectar al contenedor:
--   docker compose -f scripts/docker-compose.yml exec postgres \
--     psql -U bootcamp -d northwind
-- ============================================================
-- ESTRATEGIA: usar ROLLBACK al final para no alterar Northwind.
--   Demostrar que sin COMMIT los cambios no persisten.
-- ============================================================


-- ── 1. Transacción básica — COMMIT ────────────────────────────
-- Simular la inserción de un pedido completo (atomicidad).
BEGIN;

    -- Paso 1: insertar cabecera del pedido
    INSERT INTO orders (order_id, customer_id, employee_id, order_date, ship_via, freight)
    VALUES (99999, 'ALFKI', 1, CURRENT_DATE, 1, 12.50);

    -- Paso 2: insertar líneas del pedido
    INSERT INTO order_details (order_id, product_id, unit_price, quantity, discount)
    VALUES
        (99999, 11, 21.00, 10, 0),
        (99999, 42, 14.00,  5, 0.05);

    -- Verificar antes de confirmar
    SELECT o.order_id, o.customer_id, od.product_id, od.quantity
    FROM orders o JOIN order_details od ON o.order_id = od.order_id
    WHERE o.order_id = 99999;

-- ROLLBACK en lugar de COMMIT para no alterar Northwind en la demo:
ROLLBACK;

-- Confirmar que el pedido ya no existe:
SELECT order_id FROM orders WHERE order_id = 99999;


-- ── 2. ROLLBACK por error ─────────────────────────────────────
-- Demostrar que si un paso falla, todo se deshace.
BEGIN;

    UPDATE orders SET freight = freight * 1.10
    WHERE EXTRACT(YEAR FROM order_date) = 1997;

    -- Simular que el siguiente paso fallará:
    -- INSERT INTO order_details VALUES (NULL, NULL, NULL, NULL, NULL);

    -- Por seguridad de la demo:
ROLLBACK;


-- ── 3. SAVEPOINT — punto de rescate parcial ───────────────────
BEGIN;

    -- Paso 1: actualizar precios de una categoría
    UPDATE products
    SET unit_price = unit_price * 1.05
    WHERE category_id = 1;  -- Bebidas

    SAVEPOINT sp_bebidas;

    -- Paso 2: intentar actualizar otra categoría
    UPDATE products
    SET unit_price = unit_price * 1.10
    WHERE category_id = 2;  -- Condimentos

    -- "Nos arrepentimos" del paso 2
    ROLLBACK TO SAVEPOINT sp_bebidas;

    -- Solo el paso 1 quedaría activo si hiciéramos COMMIT
    -- (aquí hacemos ROLLBACK total para no alterar Northwind)

ROLLBACK;


-- ── 4. Aislamiento — leer datos no confirmados ───────────────
-- Para demostrar esto se necesitan DOS conexiones simultáneas.
-- Instrucciones para el instructor:
--
-- SESIÓN A:                              SESIÓN B:
--   BEGIN;                               BEGIN;
--   UPDATE products                      SELECT product_name, unit_price
--     SET unit_price = 999               FROM products
--     WHERE product_id = 1;              WHERE product_id = 1;
--                                        -- ← En READ COMMITTED no ve el 999
--   COMMIT;                              -- ← Ahora sí lo ve
--
-- Verificar nivel de aislamiento actual:
SHOW transaction_isolation;


-- ── 5. Detectar bloqueos activos ─────────────────────────────
-- Útil para mostrar qué pasa cuando dos transacciones compiten:
SELECT
    pid,
    state,
    wait_event_type,
    wait_event,
    query
FROM pg_stat_activity
WHERE state != 'idle'
  AND datname = 'northwind';
