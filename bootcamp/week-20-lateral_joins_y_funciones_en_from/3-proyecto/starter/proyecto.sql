-- ============================================
-- PROYECTO SEMANAL: LATERAL Joins y funciones tabulares
-- Semana 20 — LATERAL
-- Motor: PostgreSQL 16
-- ============================================

-- NOTA PARA EL APRENDIZ:
-- Adapta este esquema a tu dominio asignado.
-- Ejemplos:
--   Biblioteca  → genres, books, checkouts
--   Farmacia    → drug_types, medicines, sales
--   Gimnasio    → disciplines, routines, sessions
--   Restaurante → menu_categories, dishes, orders

-- ============================================
-- SECCIÓN 1: Esquema base
-- ============================================

-- TODO: Renombrar según tu dominio
DROP TABLE IF EXISTS transactions;
DROP TABLE IF EXISTS items;
DROP TABLE IF EXISTS groups;

CREATE TABLE groups (
    id      SERIAL  PRIMARY KEY,
    name    TEXT    NOT NULL
);

CREATE TABLE items (
    id          SERIAL          PRIMARY KEY,
    name        TEXT            NOT NULL,
    group_id    INT             NOT NULL REFERENCES groups (id),
    unit_value  NUMERIC(10, 2)  NOT NULL CHECK (unit_value > 0)
);

CREATE TABLE transactions (
    id          SERIAL  PRIMARY KEY,
    item_id     INT     NOT NULL REFERENCES items (id),
    quantity    INT     NOT NULL CHECK (quantity > 0),
    txn_date    DATE    NOT NULL DEFAULT CURRENT_DATE
);

-- TODO: Insertar al menos 3 grupos y 10 ítems con transacciones
-- INSERT INTO groups (name) VALUES (...);
-- INSERT INTO items (name, group_id, unit_value) VALUES (...);
-- INSERT INTO transactions (item_id, quantity, txn_date) VALUES (...);


-- ============================================
-- SECCIÓN 2: Top-N por grupo con JOIN LATERAL
-- ============================================

-- TODO: Obtener los 3 ítems más transaccionados por grupo
--       usando JOIN LATERAL

-- SELECT
--     g.name                  AS group_name,
--     top3.item_name,
--     top3.total_qty
-- FROM groups g
-- JOIN LATERAL (
--     -- TODO: implementar subquery correlacionada
-- ) AS top3 ON TRUE
-- ORDER BY g.name, top3.total_qty DESC;


-- ============================================
-- SECCIÓN 3: Estadísticas por ítem con CROSS JOIN LATERAL
-- ============================================

-- TODO: Para cada ítem, obtener en una sola subquery LATERAL:
--       total_qty, num_transactions, last_txn_date

-- SELECT
--     i.name,
--     stats.total_qty,
--     stats.num_transactions,
--     stats.last_txn_date
-- FROM items i
-- CROSS JOIN LATERAL (
--     -- TODO: implementar agregados
-- ) AS stats
-- ORDER BY stats.total_qty DESC;


-- ============================================
-- SECCIÓN 4: Función tabular + LATERAL
-- ============================================

-- TODO: Crear fn_top_items(p_group_id INT, p_limit INT)
--       que retorne (item_name TEXT, total_qty BIGINT)

-- CREATE OR REPLACE FUNCTION fn_top_items(
--     p_group_id INT,
--     p_limit    INT DEFAULT 3
-- )
-- RETURNS TABLE (item_name TEXT, total_qty BIGINT)
-- LANGUAGE sql AS $$
--     -- TODO: implementar
-- $$;

-- TODO: Llamar la función con CROSS JOIN LATERAL
-- SELECT g.name AS group_name, ti.item_name, ti.total_qty
-- FROM groups g
-- CROSS JOIN LATERAL fn_top_items(g.id, 3) AS ti
-- ORDER BY g.name, ti.total_qty DESC;


-- ============================================
-- SECCIÓN 5: LEFT JOIN LATERAL (entidades sin transacciones)
-- ============================================

-- TODO: Usar LEFT JOIN LATERAL para incluir ítems sin transacciones
--       Mostrar NULL en las columnas de la subquery para esos ítems

-- SELECT
--     i.name,
--     last_t.quantity,
--     last_t.txn_date
-- FROM items i
-- LEFT JOIN LATERAL (
--     -- TODO: implementar
-- ) AS last_t ON TRUE
-- ORDER BY i.name;
