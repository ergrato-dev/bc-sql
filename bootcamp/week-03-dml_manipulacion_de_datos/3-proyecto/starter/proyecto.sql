-- ============================================
-- PROYECTO SEMANAL: DML — Manipulación de Datos
-- Semana 03 — INSERT INTO, UPDATE, DELETE
-- ============================================

-- NOTA PARA EL APRENDIZ:
-- Adapta este esquema a tu dominio asignado.
-- Ejemplos:
--   Biblioteca  → books, members, loans
--   Farmacia    → medicines, suppliers, sales
--   Gimnasio    → members, plans, attendance
--   Restaurante → dishes, tables, orders

-- Reutiliza el setup.sql de la Semana 02 o recrea las tablas aquí:

-- TODO: Pega o recrea tu esquema DDL de la Semana 02
--       (DROP TABLE IF EXISTS + CREATE TABLE)


-- ============================================
-- PARTE 1: INSERT INTO
-- ============================================

-- TODO: Inserta al menos 5 filas en la tabla padre de tu dominio
INSERT INTO items (id, name)   -- TODO: Renombrar y expandir columnas
VALUES
    -- (1, 'Ejemplo A'),
    -- (2, 'Ejemplo B'),
    -- (3, 'Ejemplo C'),
    -- (4, 'Ejemplo D'),
    -- (5, 'Ejemplo E');
    ;

-- TODO: Inserta al menos 5 filas en la tabla hijo respetando FKs
-- INSERT INTO ...


-- ============================================
-- PARTE 2: UPDATE
-- ============================================

-- TODO: Actualiza una columna de una fila específica (por PK)
-- UPDATE ...
-- SET    columna = nuevo_valor
-- WHERE  id = ?;

-- TODO: Actualiza múltiples columnas de una fila
-- UPDATE ...
-- SET    col1 = val1,
--        col2 = val2
-- WHERE  id = ?;

-- TODO: Actualiza múltiples filas con una condición de negocio
-- UPDATE ...
-- SET    columna = ...
-- WHERE  condicion = ?;


-- ============================================
-- PARTE 3: DELETE SEGURO
-- ============================================

-- TODO: Verifica con SELECT qué filas serán eliminadas
-- SELECT id, nombre FROM ... WHERE condicion;

-- TODO: Elimina esas filas con el mismo WHERE
-- DELETE FROM ...
-- WHERE  condicion;


-- ============================================
-- VERIFICACIÓN FINAL
-- ============================================

-- TODO: Muestra el estado final de ambas tablas
-- SELECT * FROM tabla_padre ORDER BY id;
-- SELECT * FROM tabla_hijo  ORDER BY id;
