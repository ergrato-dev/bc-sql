-- ============================================
-- PROYECTO SEMANAL: Transacciones y ACID
-- Semana 17 — Control de integridad de datos
-- Motor: PostgreSQL 16
-- ============================================

-- NOTA PARA EL APRENDIZ:
-- Adapta este esquema genérico a tu dominio asignado.
-- Ejemplos de adaptación:
--   Biblioteca   → books, members, loans
--   Farmacia     → medicines, inventory, sales
--   Gimnasio     → plans, members, registrations
--   Restaurante  → dishes, tables, orders

-- TODO: Renombrar las tablas según tu dominio

DROP TABLE IF EXISTS transactions_log;
DROP TABLE IF EXISTS items;
DROP TABLE IF EXISTS entities;

-- Entidad principal de tu dominio
-- TODO: Renombrar y añadir columnas específicas
CREATE TABLE entities (
    id          SERIAL          PRIMARY KEY,
    name        TEXT            NOT NULL,
    -- TODO: Añadir columna de cantidad, saldo, stock o similar
    quantity    NUMERIC(12, 2)  NOT NULL DEFAULT 0
                                CHECK (quantity >= 0),
    is_active   BOOLEAN         NOT NULL DEFAULT TRUE
);

-- Entidad secundaria (transacciones, movimientos, registros)
-- TODO: Renombrar y añadir columnas específicas
CREATE TABLE items (
    id          SERIAL       PRIMARY KEY,
    entity_id   INT          NOT NULL REFERENCES entities (id),
    description TEXT         NOT NULL,
    amount      NUMERIC(12, 2) NOT NULL,
    created_at  TIMESTAMP    NOT NULL DEFAULT NOW()
);

-- Log de auditoría opcional
CREATE TABLE transactions_log (
    id          SERIAL    PRIMARY KEY,
    action      TEXT      NOT NULL,
    detail      TEXT,
    executed_at TIMESTAMP NOT NULL DEFAULT NOW()
);

-- TODO: Insertar datos de prueba representativos
-- Mínimo 3 filas en entities y 2 filas en items

-- ============================================================
-- REQUISITO 1: Transacción exitosa (modifica ambas tablas)
-- ============================================================

-- TODO: Implementar BEGIN ... COMMIT que:
--   1. Actualice la columna quantity/saldo de entities
--   2. Inserte un registro en items
--   3. Confirme con COMMIT

-- BEGIN;
--     -- TODO: UPDATE en entities
--     -- TODO: INSERT en items
-- COMMIT;

-- TODO: SELECT para verificar consistencia


-- ============================================================
-- REQUISITO 2: Rollback explícito por regla de negocio
-- ============================================================

-- TODO: Implementar BEGIN ... ROLLBACK que:
--   1. Intente una operación que violaría la lógica del dominio
--   2. Incluya un comentario explicando POR QUÉ se revierte
--   3. Termine con ROLLBACK

-- BEGIN;
--     -- TODO: operación que viola la regla de negocio
--     -- Comentario: se revierte porque ...
-- ROLLBACK;

-- TODO: SELECT para confirmar que no hubo cambios


-- ============================================================
-- REQUISITO 3: SAVEPOINT con rollback parcial
-- ============================================================

-- TODO: Implementar una transacción que:
--   1. Haga una operación válida en entities
--   2. Cree un SAVEPOINT
--   3. Intente una operación adicional (puede ser inválida)
--   4. Haga ROLLBACK TO SAVEPOINT
--   5. Termine con COMMIT, conservando solo la primera operación

-- BEGIN;
--     -- TODO: primera operación (se conservará)
--     SAVEPOINT sp1;
--     -- TODO: segunda operación (se revertirá)
--     ROLLBACK TO SAVEPOINT sp1;
-- COMMIT;


-- ============================================================
-- REQUISITO 4: Verificación final del estado completo
-- ============================================================

-- TODO: Consulta final que muestre el estado de entities e items
-- y demuestre que los datos son coherentes con las transacciones aplicadas

-- SELECT ... FROM entities ORDER BY id;
-- SELECT ... FROM items ORDER BY id;
