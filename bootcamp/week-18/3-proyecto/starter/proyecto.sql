-- ============================================
-- PROYECTO SEMANAL: Funciones y Procedimientos
-- Semana 18 — PL/pgSQL
-- Motor: PostgreSQL 16
-- ============================================

-- NOTA PARA EL APRENDIZ:
-- Adapta este esquema genérico a tu dominio asignado.
-- Ejemplos de adaptación:
--   Biblioteca   → books, members, loans
--   Farmacia     → medicines, inventory, sales
--   Gimnasio     → classes, members, registrations
--   Restaurante  → dishes, tables, orders

-- TODO: Renombrar las tablas según tu dominio

DROP TABLE IF EXISTS audit_log;
DROP TABLE IF EXISTS transactions;
DROP TABLE IF EXISTS resources;
DROP TABLE IF EXISTS entities;

-- Tabla principal de tu dominio
CREATE TABLE entities (
    id          SERIAL          PRIMARY KEY,
    name        TEXT            NOT NULL,
    capacity    INT             NOT NULL DEFAULT 0 CHECK (capacity >= 0),
    is_active   BOOLEAN         NOT NULL DEFAULT TRUE
);

-- Tabla secundaria (operaciones/registros)
CREATE TABLE resources (
    id          SERIAL          PRIMARY KEY,
    entity_id   INT             NOT NULL REFERENCES entities (id),
    quantity    NUMERIC(12, 2)  NOT NULL CHECK (quantity >= 0),
    status      TEXT            NOT NULL DEFAULT 'available'
);

-- Tabla de auditoría
CREATE TABLE audit_log (
    id          SERIAL    PRIMARY KEY,
    action      TEXT      NOT NULL,
    detail      TEXT,
    executed_at TIMESTAMP NOT NULL DEFAULT NOW()
);

-- TODO: Insertar datos representativos de tu dominio
-- Mínimo 4 filas en entities y 3 en resources

-- ============================================================
-- REQUISITO 1: Función escalar
-- ============================================================

-- TODO: Función que clasifique o calcule un valor de tu dominio
-- Debe usar IF/ELSIF/ELSE o CASE

-- CREATE OR REPLACE FUNCTION fn_classify(p_value NUMERIC)
-- RETURNS TEXT
-- LANGUAGE plpgsql
-- AS $$
-- BEGIN
--     -- TODO: lógica de clasificación
--     RETURN 'nivel';
-- END;
-- $$;

-- TODO: SELECT que use la función para todos los registros


-- ============================================================
-- REQUISITO 2: Función RETURNS TABLE
-- ============================================================

-- TODO: Función que retorne una lista filtrada de registros
-- Debe aceptar al menos un parámetro y usar RETURN QUERY

-- CREATE OR REPLACE FUNCTION fn_list_available(p_min_qty NUMERIC)
-- RETURNS TABLE(...)
-- LANGUAGE plpgsql
-- AS $$
-- BEGIN
--     RETURN QUERY
--         -- TODO: SELECT filtrado
-- END;
-- $$;

-- TODO: SELECT * FROM fn_list_available(valor);


-- ============================================================
-- REQUISITO 3 y 4: Procedimiento con COMMIT y EXCEPTION
-- ============================================================

-- TODO: Procedimiento que encapsule una operación de negocio
-- Debe: verificar condición → lanzar excepción si falla →
--       registrar en audit_log → COMMIT si OK

-- CREATE OR REPLACE PROCEDURE sp_operation(...)
-- LANGUAGE plpgsql
-- AS $$
-- DECLARE
--     v_var TYPE;
-- BEGIN
--     -- TODO: SELECT INTO para leer estado actual
--     -- TODO: IF validación THEN RAISE EXCEPTION
--     -- TODO: UPDATE/INSERT operación
--     -- TODO: INSERT INTO audit_log (action, detail) VALUES (...)
--     COMMIT;
-- EXCEPTION
--     WHEN OTHERS THEN
--         RAISE EXCEPTION 'Error: %', SQLERRM;
-- END;
-- $$;


-- ============================================================
-- REQUISITO 5: Bloque DO con múltiples pruebas
-- ============================================================

-- TODO: Bloque DO que llame al procedimiento en al menos
-- 3 escenarios: 2 exitosos y 1 que genere excepción

-- DO $$
-- BEGIN
--     -- TODO: CALL sp_operation(args_ok_1);
--     -- TODO: CALL sp_operation(args_ok_2);
--     -- TODO: CALL sp_operation(args_error);
-- EXCEPTION
--     WHEN OTHERS THEN
--         RAISE NOTICE 'Capturado: %', SQLERRM;
-- END;
-- $$;


-- ============================================================
-- Verificación final
-- ============================================================

-- TODO: SELECT de estado final de entities, resources y audit_log
