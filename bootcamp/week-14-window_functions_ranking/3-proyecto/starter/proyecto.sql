-- ============================================
-- PROYECTO SEMANAL: Ranking con Window Functions
-- Semana 14 — Window Functions (ROW_NUMBER, RANK, DENSE_RANK)
-- PostgreSQL 16
-- ============================================

-- NOTA PARA EL APRENDIZ:
-- Adapta este esquema a tu dominio asignado.
-- Ejemplos:
--   Biblioteca  → books, members, loans
--   Farmacia    → medicines, sales, inventory
--   Gimnasio    → members, routines, attendance
--   Restaurante → dishes, tables, orders

-- TODO: Renombrar las tablas según tu dominio
-- TODO: Agregar columnas específicas de tu dominio

DROP TABLE IF EXISTS items CASCADE;
DROP TABLE IF EXISTS categories CASCADE;

CREATE TABLE categories (
    id   SERIAL PRIMARY KEY,
    name TEXT   NOT NULL
);

CREATE TABLE items (
    id          SERIAL         PRIMARY KEY,
    name        TEXT           NOT NULL,
    value       NUMERIC(10, 2) NOT NULL,  -- TODO: renombrar según dominio (precio, ventas, etc.)
    category_id INT            REFERENCES categories (id),
    is_active   BOOLEAN        NOT NULL DEFAULT TRUE
    -- TODO: Agregar columnas específicas
);

-- TODO: Insertar datos representativos de tu dominio (mínimo 10 filas)
-- Incluir al menos 2 items con el mismo valor para demostrar empates
INSERT INTO categories (name) VALUES
    ('Categoría A'),  -- TODO: reemplazar con nombres reales
    ('Categoría B'),
    ('Categoría C');

INSERT INTO items (name, value, category_id) VALUES
    ('Item 1', 1000, 1), -- TODO: reemplazar con datos reales
    ('Item 2', 1000, 1), -- empate intencional para demostrar RANK vs DENSE_RANK
    ('Item 3',  800, 1),
    ('Item 4',  950, 2),
    ('Item 5',  700, 2),
    ('Item 6', 1200, 3),
    ('Item 7',  850, 3);


-- ============================================
-- TODO 1: Eliminar duplicados con ROW_NUMBER()
-- ============================================
-- Escenario: tienes registros duplicados de items por nombre.
-- Usa ROW_NUMBER() para quedarte con uno por nombre.
-- Pista: CTE con ROW_NUMBER() PARTITION BY name ORDER BY id,
--        luego WHERE rn = 1 en el SELECT exterior.

-- TODO: Implementar la consulta de deduplicación por nombre
-- Debe mostrar: id, name, value, category_id


-- ============================================
-- TODO 2: RANK y DENSE_RANK por categoría
-- ============================================
-- Clasifica los items por valor dentro de cada categoría.
-- Elige entre RANK o DENSE_RANK según necesites ilustrar
-- el comportamiento con empates de tu dominio.
-- Pista: OVER (PARTITION BY category_id ORDER BY value DESC)

-- TODO: Implementar el ranking por categoría
-- Debe mostrar: name, value, category_id, rnk (o dense_rnk)
-- Los empates deben ser visibles en el resultado


-- ============================================
-- TODO 3: Top-N por grupo con CTE
-- ============================================
-- Obtén los 2 items de mayor valor por categoría.
-- Pista: CTE que calcula DENSE_RANK por categoría,
--        luego filtra WHERE dense_rnk <= 2 en el exterior.

-- TODO: Implementar la consulta top-2 por categoría
-- Debe incluir: name, value, category_id, dense_rnk
-- Ordena por category_id, dense_rnk
