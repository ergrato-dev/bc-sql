-- ============================================================
-- DEMOS INSTRUCTOR — Semana 07: NULL y Constraints
-- Base de datos: northwind (PostgreSQL 16 · Docker)
-- ⚠️  SOLO USO INTERNO — No compartir con aprendices
-- ============================================================
-- Conectar al contenedor:
--   docker compose -f scripts/docker-compose.yml exec postgres \
--     psql -U bootcamp -d northwind
-- ============================================================
-- TIP: Northwind tiene NULLs reales en customers.region,
--   customers.fax, employees.region y orders.shipped_date.
--   Ideal para demostrar comportamientos de NULL con datos reales.
-- ============================================================


-- ── 1. NULL no es cero ni cadena vacía ───────────────────────
-- Mostrar que region tiene NULLs:
SELECT company_name, city, region, country
FROM customers
ORDER BY region NULLS LAST
LIMIT 15;

-- NULL vs vacío vs 0 — son tres cosas distintas:
SELECT
    COUNT(*)       AS total_clientes,
    COUNT(region)  AS con_region,    -- NULL no cuenta
    COUNT(*) - COUNT(region) AS sin_region
FROM customers;


-- ── 2. IS NULL / IS NOT NULL ─────────────────────────────────
-- Clientes sin región asignada:
SELECT company_name, country, region
FROM customers
WHERE region IS NULL
ORDER BY country;

-- Pedidos aún no enviados:
SELECT order_id, customer_id, order_date, shipped_date
FROM orders
WHERE shipped_date IS NULL
ORDER BY order_date;

-- ⚠️  NULL = NULL siempre es FALSE — mostrar el anti-patrón:
-- SELECT * FROM customers WHERE region = NULL;  -- ← no devuelve nada


-- ── 3. COALESCE — valor por defecto cuando hay NULL ──────────
-- Mostrar región o 'Sin región' cuando es NULL:
SELECT
    company_name,
    COALESCE(region, 'Sin región') AS region,
    country
FROM customers
ORDER BY country;

-- COALESCE con múltiples alternativas (toma el primero no-NULL):
SELECT
    company_name,
    COALESCE(fax, phone, 'Sin contacto telefónico') AS contacto
FROM customers
LIMIT 10;


-- ── 4. NULLIF — convertir un valor en NULL ───────────────────
-- Si discount = 0, tratar como NULL para no distorsionar AVG:
SELECT
    product_id,
    AVG(discount)          AS avg_con_cero,
    AVG(NULLIF(discount, 0)) AS avg_sin_cero  -- ignora descuentos = 0
FROM order_details
GROUP BY product_id
ORDER BY avg_sin_cero DESC NULLS LAST
LIMIT 10;


-- ── 5. NULL en operaciones aritméticas ───────────────────────
-- NULL "contamina" el cálculo — cualquier operación con NULL = NULL:
SELECT
    order_id,
    order_date,
    shipped_date,
    shipped_date - order_date           AS dias_envio,          -- NULL si shipped_date es NULL
    COALESCE(shipped_date, NOW()::date)
        - order_date                    AS dias_envio_estimado  -- con fallback
FROM orders
ORDER BY dias_envio DESC NULLS FIRST
LIMIT 10;


-- ── 6. Constraints en acción ─────────────────────────────────
-- Ver los constraints de la tabla products:
SELECT
    conname   AS nombre_constraint,
    contype   AS tipo,          -- p=PK, f=FK, c=CHECK, u=UNIQUE, n=NOT NULL
    pg_get_constraintdef(oid) AS definicion
FROM pg_constraint
WHERE conrelid = 'products'::regclass;
