-- ============================================
-- PROYECTO SEMANAL: Optimización de Consultas
-- Semana 23 — EXPLAIN ANALYZE e índices
-- Motor: PostgreSQL 16
-- ============================================

-- NOTA PARA EL APRENDIZ:
-- Adapta este esquema a tu dominio asignado.
-- El objetivo es demostrar una mejora medible antes y después
-- de agregar un índice.

-- ============================================
-- PASO 1: Crear la tabla y generar datos
-- ============================================

DROP TABLE IF EXISTS items;

-- TODO: Renombrar 'items' y adaptar columnas al dominio
CREATE TABLE items (
    id          SERIAL          PRIMARY KEY,
    category    TEXT            NOT NULL,
    status      TEXT            NOT NULL,
    amount      NUMERIC(10, 2)  NOT NULL,
    created_at  DATE            NOT NULL DEFAULT CURRENT_DATE
    -- TODO: Agregar columnas específicas del dominio
);

-- TODO: Generar al menos 500 filas con generate_series
INSERT INTO items (category, status, amount, created_at)
SELECT
    CASE (g % 3)
        WHEN 0 THEN 'categoria_a'
        WHEN 1 THEN 'categoria_b'
        ELSE 'categoria_c'
    END,
    CASE (g % 4)
        WHEN 0 THEN 'activo'
        WHEN 1 THEN 'inactivo'
        WHEN 2 THEN 'pendiente'
        ELSE 'cancelado'
    END,
    ROUND((random() * 1000)::NUMERIC, 2),
    CURRENT_DATE - (random() * 365)::INTEGER
FROM generate_series(1, 500) AS g;

ANALYZE items;

-- ============================================
-- PASO 2: EXPLAIN antes del índice
-- ============================================

-- TODO: Identificar la consulta lenta (debería mostrar Seq Scan)
EXPLAIN SELECT *
FROM items
WHERE status = 'pendiente';

-- ============================================
-- PASO 3: Crear el índice
-- ============================================

-- TODO: Crear el índice más apropiado para la consulta del paso 2
-- Opciones: B-tree, parcial, compuesto, funcional
CREATE INDEX idx_items_status ON items (status);

-- ============================================
-- PASO 4: EXPLAIN ANALYZE después del índice
-- ============================================

-- TODO: Verificar que ahora usa Index Scan
EXPLAIN ANALYZE SELECT *
FROM items
WHERE status = 'pendiente';

-- ============================================
-- PASO 5: Estadísticas con pg_stat_user_tables
-- ============================================

-- TODO: Reemplazar 'items' con el nombre real de tu tabla
SELECT
    tablename,
    n_live_tup     AS filas_vivas,
    n_dead_tup     AS filas_muertas,
    last_analyze
FROM pg_stat_user_tables
WHERE tablename = 'items';

-- ============================================
-- PASO 6: Listar índices con pg_indexes
-- ============================================

SELECT
    indexname,
    tablename,
    indexdef
FROM pg_indexes
WHERE schemaname = 'public'
  AND tablename = 'items'
ORDER BY indexname;
