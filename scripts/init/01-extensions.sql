-- ============================================
-- 01-extensions.sql
-- Se ejecuta automáticamente en el primer arranque del contenedor.
-- Habilita las extensiones necesarias para el bootcamp.
-- ============================================

-- pgcrypto: genera UUIDs con gen_random_uuid() (semana 22 — JSONB y tipos avanzados)
CREATE EXTENSION IF NOT EXISTS pgcrypto;

-- pg_stat_statements: auditoría de rendimiento de queries (semana 23 — EXPLAIN ANALYZE)
CREATE EXTENSION IF NOT EXISTS pg_stat_statements;

-- pg_trgm: búsqueda por similitud de texto (semana 21 — Full Text Search)
CREATE EXTENSION IF NOT EXISTS pg_trgm;

-- unaccent: normalización de texto sin tildes para búsquedas (semana 21)
CREATE EXTENSION IF NOT EXISTS unaccent;
