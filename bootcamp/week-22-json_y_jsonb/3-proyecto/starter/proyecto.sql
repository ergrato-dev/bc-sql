-- ============================================
-- PROYECTO SEMANAL: JSON y JSONB
-- Semana 22 — Almacenamiento semiestructurado
-- Motor: PostgreSQL 16
-- ============================================

-- NOTA PARA EL APRENDIZ:
-- Adapta este esquema a tu dominio asignado.
-- Ejemplos:
--   Biblioteca  → books + metadata JSONB (genre, pages, language)
--   Farmacia    → medicines + properties JSONB (dosage, form)
--   Gimnasio    → equipment + specs JSONB (weight, brand)
--   Restaurante → dishes + details JSONB (allergens, calories)

-- ============================================
-- PASO 1: Crear la tabla con columna JSONB
-- ============================================

DROP TABLE IF EXISTS items;

-- TODO: Renombrar 'items' según tu dominio
-- TODO: Agregar columnas relacionales + columna JSONB
CREATE TABLE items (
    id          SERIAL   PRIMARY KEY,
    name        TEXT     NOT NULL,
    category    TEXT     NOT NULL,
    price       NUMERIC(10, 2),
    attributes  JSONB    NOT NULL DEFAULT '{}'
    -- TODO: Agregar columnas adicionales
);

-- ============================================
-- PASO 2: Insertar al menos 10 filas con JSONB variado
-- ============================================

-- TODO: Insertar datos representativos de tu dominio
-- Los documentos JSONB deben tener estructuras variadas
INSERT INTO items (name, category, price, attributes) VALUES
('Ejemplo 1', 'categoria_a', 100.00,
 '{"clave1": "valor1", "clave2": true}'),
('Ejemplo 2', 'categoria_b', 200.00,
 '{"clave1": "valor2", "nested": {"sub": 1}}');
-- TODO: Agregar hasta al menos 10 filas

-- ============================================
-- PASO 3: Crear índice GIN
-- ============================================

-- TODO: Reemplazar 'items' con el nombre de tu tabla
CREATE INDEX idx_items_attrs ON items USING GIN (attributes);

-- ============================================
-- PASO 4: Consulta con @>
-- ============================================

-- TODO: Ajustar el documento de búsqueda al dominio
SELECT id, name, category
FROM items
WHERE attributes @> '{"clave1": "valor1"}';

-- ============================================
-- PASO 5: Modificar con jsonb_set
-- ============================================

-- TODO: Agregar o actualizar una clave en los documentos
UPDATE items
SET attributes = jsonb_set(attributes, '{nueva_clave}', '"nuevo_valor"', TRUE)
WHERE attributes ? 'clave1';

-- Verificar cambio
SELECT name, attributes ->> 'nueva_clave' AS nuevo_campo
FROM items
WHERE attributes ? 'nueva_clave';

-- ============================================
-- PASO 6: Reporte con jsonb_agg
-- ============================================

-- TODO: Agrupar por categoría y construir el reporte
SELECT
    category,
    COUNT(*)          AS total,
    jsonb_agg(
        jsonb_build_object(
            'id',   id,
            'name', name
            -- TODO: Agregar campos JSONB relevantes del dominio
        )
    )                 AS items_json
FROM items
GROUP BY category
ORDER BY category;
