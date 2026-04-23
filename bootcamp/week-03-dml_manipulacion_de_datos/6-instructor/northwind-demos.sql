-- ============================================================
-- DEMOS INSTRUCTOR — Semana 03: DML — Manipulación de datos
-- Base de datos: northwind (PostgreSQL 16 · Docker)
-- ⚠️  SOLO USO INTERNO — No compartir con aprendices
-- ============================================================
-- Conectar al contenedor:
--   docker compose -f scripts/docker-compose.yml exec postgres \
--     psql -U bootcamp -d northwind
-- ============================================================
-- ESTRATEGIA SEGURA: Copiar datos de Northwind a tablas TEMP
--   y hacer DML sobre las copias. Northwind siempre queda intacto.
-- ============================================================


-- ── 0. PREPARAR SANDBOX ──────────────────────────────────────
-- Copiar una porción de 'products' para trabajar sobre ella.

CREATE TEMP TABLE sandbox_products AS
SELECT product_id, product_name, unit_price, units_in_stock, discontinued
FROM products;


-- ── 1. INSERT — insertar filas nuevas ────────────────────────
-- INSERT de una sola fila:

INSERT INTO sandbox_products (product_id, product_name, unit_price, units_in_stock, discontinued)
VALUES (9999, 'Mate Argentino', 12.50, 100, FALSE);

-- INSERT de múltiples filas en una sola sentencia:

INSERT INTO sandbox_products (product_id, product_name, unit_price, units_in_stock, discontinued)
VALUES
    (9998, 'Yerba Compuesta',  9.90, 50,  FALSE),
    (9997, 'Tereré Cítrico',  11.00, 30,  FALSE);

-- Verificar
SELECT * FROM sandbox_products WHERE product_id >= 9997;


-- ── 2. UPDATE — modificar filas existentes ───────────────────
-- REGLA DE ORO: siempre usar WHERE; nunca UPDATE sin condición.

-- Actualizar por PK (afecta exactamente 1 fila):
UPDATE sandbox_products
SET unit_price = 13.50
WHERE product_id = 9999;

-- Actualizar por condición (puede afectar N filas):
UPDATE sandbox_products
SET units_in_stock = units_in_stock + 20
WHERE discontinued = FALSE AND units_in_stock < 20;

-- Buena práctica: verificar con SELECT ANTES de hacer el UPDATE
SELECT product_id, product_name, units_in_stock
FROM sandbox_products
WHERE discontinued = FALSE AND units_in_stock < 20;


-- ── 3. DELETE — eliminar filas ────────────────────────────────
-- REGLA DE ORO: nunca DELETE sin WHERE en producción.

-- Verificar qué se va a borrar:
SELECT * FROM sandbox_products WHERE product_id >= 9997;

-- Borrar:
DELETE FROM sandbox_products WHERE product_id >= 9997;

-- Confirmar:
SELECT COUNT(*) FROM sandbox_products;


-- ── 4. ANTI-PATRÓN: UPDATE / DELETE sin WHERE ─────────────────
-- Descomentar para mostrar el peligro (sobre sandbox, no Northwind):
-- UPDATE sandbox_products SET unit_price = 0;      -- ← afecta TODAS las filas
-- DELETE FROM sandbox_products;                    -- ← borra TODA la tabla


-- ── 5. TRUNCATE vs DELETE ────────────────────────────────────
-- TRUNCATE es más rápido para vaciar una tabla, pero no se puede
-- condicionar con WHERE ni disparar triggers fácilmente.

-- Mostrar la diferencia conceptual:
-- DELETE FROM sandbox_products;    -- log entry por cada fila
-- TRUNCATE sandbox_products;       -- operación de bloque

DROP TABLE IF EXISTS sandbox_products;
