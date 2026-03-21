-- ============================================
-- PROYECTO SEMANAL: Automatización con Triggers
-- Semana 19 — Triggers
-- Motor: PostgreSQL 16
-- ============================================

-- NOTA PARA EL APRENDIZ:
-- Adapta este esquema a tu dominio asignado.
-- Ejemplos:
--   Biblioteca  → books, members, loans
--   Farmacia    → medicines, sales, inventory
--   Gimnasio    → members, routines, attendance
--   Restaurante → dishes, tables, orders

-- ============================================
-- SECCIÓN 1: Esquema base
-- ============================================

-- TODO: Renombrar las tablas según tu dominio
-- TODO: Agregar columnas específicas de tu dominio

DROP TABLE IF EXISTS change_log;
DROP TABLE IF EXISTS items;

-- Tabla principal de tu dominio
CREATE TABLE items (
    id          SERIAL          PRIMARY KEY,
    name        TEXT            NOT NULL,
    -- TODO: Agregar columnas específicas (precio, estado, etc.)
    quantity    INT             NOT NULL DEFAULT 0
                                    CHECK (quantity >= 0),
    is_active   BOOLEAN         NOT NULL DEFAULT TRUE,
    created_at  TIMESTAMP       NOT NULL DEFAULT NOW()
);

-- Tabla de auditoría automática
CREATE TABLE change_log (
    id          SERIAL    PRIMARY KEY,
    table_name  TEXT      NOT NULL,
    operation   TEXT      NOT NULL,  -- INSERT, UPDATE, DELETE
    record_id   INT,
    detail      TEXT,
    changed_at  TIMESTAMP NOT NULL DEFAULT NOW()
);

-- TODO: Datos de prueba representativos de tu dominio
INSERT INTO items (name, quantity)
VALUES
    -- TODO: Insertar al menos 5 filas de tu dominio
    ('Item de prueba', 10);


-- ============================================
-- SECCIÓN 2: Trigger AFTER — auditoría
-- ============================================

-- TODO: Crear fn_log_changes() que registre en change_log
--       el table_name, TG_OP, id del registro y un detalle
--       relevante para tu dominio

-- CREATE OR REPLACE FUNCTION fn_log_changes()
-- RETURNS TRIGGER LANGUAGE plpgsql AS $$
-- BEGIN
--     -- TODO: implementar
--     RETURN NULL;
-- END;
-- $$;

-- TODO: Crear trigger trg_audit_items
--       AFTER INSERT OR UPDATE OR DELETE ON items
--       FOR EACH ROW EXECUTE FUNCTION fn_log_changes();


-- ============================================
-- SECCIÓN 3: Trigger BEFORE — validación
-- ============================================

-- TODO: Crear fn_validate_item() que rechace operaciones
--       que incumplan una regla de tu dominio
--       (ejemplo: cantidad negativa, nombre vacío, etc.)

-- CREATE OR REPLACE FUNCTION fn_validate_item()
-- RETURNS TRIGGER LANGUAGE plpgsql AS $$
-- BEGIN
--     -- TODO: implementar validación con RAISE EXCEPTION
--     RETURN NEW;
-- END;
-- $$;

-- TODO: Crear trigger trg_validate_item
--       BEFORE INSERT OR UPDATE ON items
--       FOR EACH ROW EXECUTE FUNCTION fn_validate_item();


-- ============================================
-- SECCIÓN 4: Trigger BEFORE — transformación
-- ============================================

-- TODO: Crear fn_normalize_item() que transforme
--       automáticamente algún campo antes de persistir
--       (ejemplo: TRIM(UPPER(name)), calcular campo derivado)

-- CREATE OR REPLACE FUNCTION fn_normalize_item()
-- RETURNS TRIGGER LANGUAGE plpgsql AS $$
-- BEGIN
--     -- TODO: implementar transformación sobre NEW
--     RETURN NEW;
-- END;
-- $$;

-- TODO: Crear trigger trg_normalize_item
--       BEFORE INSERT OR UPDATE ON items
--       FOR EACH ROW EXECUTE FUNCTION fn_normalize_item();


-- ============================================
-- SECCIÓN 5: Verificación y pruebas
-- ============================================

-- TODO: Insertar filas de prueba válidas y verificar change_log
-- TODO: Intentar una operación inválida y verificar la excepción
-- TODO: Verificar que la transformación aplicó correctamente

-- Verificar entradas de auditoría
-- SELECT * FROM change_log ORDER BY changed_at DESC LIMIT 10;


-- ============================================
-- SECCIÓN 6: DISABLE / ENABLE TRIGGER
-- ============================================

-- TODO: Deshabilitar trg_audit_items
-- DISABLE TRIGGER trg_audit_items ON items;

-- TODO: Insertar una fila y confirmar que NO aparece en change_log
-- INSERT INTO items (name, quantity) VALUES ('Sin auditoría', 1);
-- SELECT * FROM change_log ORDER BY changed_at DESC LIMIT 3;

-- TODO: Rehabilitar el trigger
-- ENABLE TRIGGER trg_audit_items ON items;

-- TODO: Insertar otra fila y confirmar que SÍ aparece en change_log
-- INSERT INTO items (name, quantity) VALUES ('Con auditoría', 2);
-- SELECT * FROM change_log ORDER BY changed_at DESC LIMIT 3;
