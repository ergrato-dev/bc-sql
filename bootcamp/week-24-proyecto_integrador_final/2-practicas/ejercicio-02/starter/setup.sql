-- Semana 24: Proyecto Integrador Final
-- setup.sql — Ejercicio 02 (requiere ejercicio-01/setup.sql previo)
-- Motor: PostgreSQL 16
-- ============================================

-- Tabla de auditoría (se crea aquí para el ejercicio)
DROP TABLE IF EXISTS audit_log CASCADE;

CREATE TABLE audit_log (
    id          BIGSERIAL   PRIMARY KEY,
    table_name  TEXT        NOT NULL,
    action      TEXT        NOT NULL,
    record_id   INTEGER,
    changed_at  TIMESTAMP   NOT NULL DEFAULT NOW()
);
