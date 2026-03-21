-- Semana 24: Proyecto Integrador Final
-- proyecto.sql — Starter
-- Motor: PostgreSQL 16
-- ============================================
-- INSTRUCCIONES PARA EL APRENDIZ:
--   Adapta TODOS los nombres de tablas y columnas al dominio asignado.
--   Elimina o renombra las entidades genéricas (items, customers, etc.)
--   según corresponda a tu caso de uso real.
--
-- Dominios de ejemplo (NO uses estos):
--   Museo      → artifacts, exhibitions, visitors, loans
--   Planetario → shows, telescopes, members, reservations
--
-- Ejemplo de dominio asignado posible:
--   Biblioteca → books, members, loans, categories, authors
--   Gimnasio   → members, routines, sessions, exercises, payments
-- ============================================

-- ============================================
-- SECCIÓN 1: Limpieza del entorno
-- ============================================
-- TODO: Agregar DROP TABLE IF EXISTS para cada tabla en orden inverso de FK

-- DROP TABLE IF EXISTS audit_log    CASCADE;
-- DROP TABLE IF EXISTS items_detail CASCADE;
-- DROP TABLE IF EXISTS transactions  CASCADE;
-- DROP TABLE IF EXISTS items         CASCADE;
-- DROP TABLE IF EXISTS categories    CASCADE;
-- DROP TABLE IF EXISTS customers     CASCADE;


-- ============================================
-- SECCIÓN 2: Esquema principal (5+ tablas)
-- ============================================
-- TODO: Crear todas las tablas de tu dominio
-- Requisitos mínimos por tabla:
--   - PRIMARY KEY SERIAL o BIGSERIAL
--   - FOREIGN KEY con REFERENCES
--   - NOT NULL en columnas obligatorias
--   - CHECK constraints donde aplique
--   - DEFAULT en columnas con valor estándar

-- Tabla ejemplo de categorías — RENOMBRAR según tu dominio:
-- CREATE TABLE categories (
--     id        SERIAL  PRIMARY KEY,
--     name      TEXT    NOT NULL UNIQUE,
--     is_active BOOLEAN NOT NULL DEFAULT TRUE
-- );

-- TODO: Crear tabla principal de tu entidad (renombrar 'items'):
-- CREATE TABLE items (
--     id            SERIAL          PRIMARY KEY,
--     category_id   INTEGER         NOT NULL REFERENCES categories(id),
--     name          TEXT            NOT NULL,
--     description   TEXT            NOT NULL DEFAULT '',
--     price         NUMERIC(10,2)   CHECK (price >= 0),
--     attributes    JSONB           NOT NULL DEFAULT '{}',
--     search_vector TSVECTOR,
--     created_at    DATE            NOT NULL DEFAULT CURRENT_DATE
--     -- TODO: Agregar columnas específicas de tu dominio
-- );

-- TODO: Crear tabla de clientes / usuarios / miembros:
-- CREATE TABLE customers (
--     id         SERIAL  PRIMARY KEY,
--     name       TEXT    NOT NULL,
--     email      TEXT    NOT NULL UNIQUE,
--     -- TODO: columnas específicas de tu dominio
--     created_at DATE    NOT NULL DEFAULT CURRENT_DATE
-- );

-- TODO: Crear tabla de transacciones / pedidos / reservas:
-- CREATE TABLE transactions (
--     id          SERIAL        PRIMARY KEY,
--     customer_id INTEGER       NOT NULL REFERENCES customers(id),
--     status      TEXT          NOT NULL DEFAULT 'pending'
--                               CHECK (status IN ('pending','active','completed','cancelled')),
--     total       NUMERIC(10,2) NOT NULL DEFAULT 0,
--     created_at  DATE          NOT NULL DEFAULT CURRENT_DATE
--     -- TODO: columnas específicas
-- );

-- TODO: Crear tabla de detalle / líneas de transacción:
-- CREATE TABLE items_detail (
--     id             SERIAL        PRIMARY KEY,
--     transaction_id INTEGER       NOT NULL REFERENCES transactions(id),
--     item_id        INTEGER       NOT NULL REFERENCES items(id),
--     quantity       INTEGER       NOT NULL CHECK (quantity > 0),
--     unit_price     NUMERIC(10,2) NOT NULL CHECK (unit_price >= 0)
-- );


-- ============================================
-- SECCIÓN 3: Tabla de auditoría
-- ============================================
-- TODO: Crear tabla audit_log
-- CREATE TABLE audit_log (
--     id          BIGSERIAL   PRIMARY KEY,
--     table_name  TEXT        NOT NULL,
--     action      TEXT        NOT NULL,
--     record_id   INTEGER,
--     changed_at  TIMESTAMP   NOT NULL DEFAULT NOW()
-- );


-- ============================================
-- SECCIÓN 4: Datos de prueba realistas
-- ============================================
-- TODO: Insertar al menos 3–5 filas por tabla
-- Los datos deben reflejar situaciones reales del dominio asignado

-- INSERT INTO categories (name) VALUES ...;
-- INSERT INTO items (...) VALUES ...;
-- INSERT INTO customers (...) VALUES ...;
-- INSERT INTO transactions (...) VALUES ...;
-- INSERT INTO items_detail (...) VALUES ...;


-- ============================================
-- SECCIÓN 5: Full-Text Search
-- ============================================
-- TODO: Poblar el campo search_vector después de insertar datos
-- UPDATE items
-- SET search_vector =
--     setweight(to_tsvector('spanish', COALESCE(name, '')), 'A') ||
--     setweight(to_tsvector('spanish', COALESCE(description, '')), 'B');

-- TODO: Crear índice GIN para FTS
-- CREATE INDEX idx_items_sv ON items USING GIN (search_vector);

-- TODO: Escribir una consulta de búsqueda con ts_rank
-- SELECT name, ts_rank(search_vector, query) AS rank
-- FROM items,
--      plainto_tsquery('spanish', '<TUS_TÉRMINOS_AQUÍ>') AS query
-- WHERE search_vector @@ query
-- ORDER BY rank DESC;


-- ============================================
-- SECCIÓN 6: Trigger de auditoría
-- ============================================
-- TODO: Crear función y trigger de auditoría para la tabla principal
-- CREATE OR REPLACE FUNCTION fn_audit_items()
-- RETURNS TRIGGER LANGUAGE plpgsql AS $$
-- BEGIN
--     INSERT INTO audit_log (table_name, action, record_id)
--     VALUES (TG_TABLE_NAME, TG_OP, COALESCE(NEW.id, OLD.id));
--     RETURN NEW;
-- END;
-- $$;

-- CREATE TRIGGER trg_audit_items
--     AFTER INSERT OR UPDATE OR DELETE ON items
--     FOR EACH ROW EXECUTE FUNCTION fn_audit_items();


-- ============================================
-- SECCIÓN 7: Consulta analítica (CTE + window)
-- ============================================
-- TODO: Escribir una consulta que responda una pregunta de negocio real
-- Debe usar: CTE o window function (ROW_NUMBER, RANK, SUM OVER...)
-- Ejemplo de estructura:
-- WITH ranked AS (
--     SELECT
--         c.name                 AS category_name,
--         i.name                 AS item_name,
--         SUM(d.quantity)        AS total,
--         ROW_NUMBER() OVER (
--             PARTITION BY c.id
--             ORDER BY SUM(d.quantity) DESC
--         )                      AS rn
--     FROM categories c
--     JOIN items i       ON i.category_id = c.id
--     JOIN items_detail d ON d.item_id = i.id
--     GROUP BY c.id, c.name, i.id, i.name
-- )
-- SELECT * FROM ranked WHERE rn <= 3;


-- ============================================
-- SECCIÓN 8: Índice con evidencia EXPLAIN ANALYZE
-- ============================================
-- TODO: Ejecutar EXPLAIN ANALYZE sin el índice primero
-- EXPLAIN ANALYZE
-- SELECT ...;

-- TODO: Crear un índice justificado para tu consulta
-- CREATE INDEX idx_<tabla>_<columna> ON <tabla> (<columna>);

-- TODO: Volver a ejecutar EXPLAIN ANALYZE y comparar el plan
-- EXPLAIN ANALYZE
-- SELECT ...;

-- TODO: Verificar estado de índices y estadísticas
-- SELECT tablename, n_live_tup, n_dead_tup
-- FROM pg_stat_user_tables
-- WHERE schemaname = 'public';
