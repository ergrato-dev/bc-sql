-- ============================================
-- 02-roles.sql
-- Configura privilegios mínimos para el usuario del bootcamp.
-- Se ejecuta en el primer arranque, después de 01-extensions.sql.
-- ============================================

-- Conectar a la base de datos del bootcamp para aplicar permisos
\connect bootcamp_db

-- Otorgar permisos sobre el schema público
GRANT USAGE  ON SCHEMA public TO bootcamp;
GRANT CREATE ON SCHEMA public TO bootcamp;

-- Permisos por defecto para objetos creados en el futuro
ALTER DEFAULT PRIVILEGES IN SCHEMA public
    GRANT SELECT, INSERT, UPDATE, DELETE ON TABLES TO bootcamp;

ALTER DEFAULT PRIVILEGES IN SCHEMA public
    GRANT USAGE, SELECT ON SEQUENCES TO bootcamp;

ALTER DEFAULT PRIVILEGES IN SCHEMA public
    GRANT EXECUTE ON FUNCTIONS TO bootcamp;
