-- ============================================
-- Semana 21: Full-Text Search
-- Ejercicio 01 — Configuración del esquema
-- Motor: PostgreSQL 16
-- ============================================

DROP TABLE IF EXISTS articles;

CREATE TABLE articles (
    id          SERIAL  PRIMARY KEY,
    title       TEXT    NOT NULL,
    body        TEXT    NOT NULL,
    created_at  DATE    NOT NULL DEFAULT CURRENT_DATE
);

INSERT INTO articles (title, body) VALUES
('Introducción a las bases de datos relacionales',
 'Una base de datos relacional organiza los datos en tablas con filas y columnas. Las relaciones entre tablas se definen mediante claves foráneas. SQL es el lenguaje estándar para consultar bases de datos relacionales.'),

('Transacciones y propiedades ACID',
 'Una transacción agrupa múltiples operaciones SQL en una unidad atómica. Las propiedades ACID garantizan consistencia, aislamiento y durabilidad. BEGIN inicia la transacción y COMMIT la confirma. ROLLBACK deshace los cambios.'),

('Índices en PostgreSQL: B-tree y GIN',
 'Los índices aceleran las consultas evitando escaneos completos de tabla. El índice B-tree es ideal para comparaciones de igualdad y rangos. El índice GIN es especialmente eficiente para búsqueda de texto completo y columnas de tipo array.'),

('Funciones y procedimientos en PL/pgSQL',
 'PL/pgSQL permite crear funciones y procedimientos almacenados directamente en el motor de base de datos. Las funciones retornan valores y los procedimientos ejecutan lógica sin retorno. Se puede usar DECLARE, IF, LOOP y EXCEPTION para control de flujo.'),

('Triggers: automatización de lógica en la base de datos',
 'Un trigger ejecuta una función automáticamente al ocurrir un evento DML como INSERT, UPDATE o DELETE. Los triggers BEFORE pueden modificar los datos antes de persistirlos. Los triggers AFTER son ideales para auditoría y registros derivados.'),

('Optimización de consultas con EXPLAIN ANALYZE',
 'EXPLAIN ANALYZE muestra el plan de ejecución real de una consulta SQL. El costo indica el esfuerzo relativo de cada operación. Los seq scan indican falta de índice. Los index scan son más eficientes para consultas selectivas.'),

('JSON y JSONB en PostgreSQL',
 'PostgreSQL soporta almacenamiento de datos semiestructurados con los tipos JSON y JSONB. JSONB almacena datos en formato binario optimizado. Los operadores -> y ->> permiten acceder a campos del documento. Se puede crear índice GIN sobre columnas JSONB.'),

('Joins avanzados: LATERAL y funciones tabulares',
 'El JOIN LATERAL permite que una subquery en FROM haga referencia a columnas de tablas anteriores. CROSS JOIN LATERAL es equivalente a JOIN LATERAL con ON TRUE. Se puede llamar funciones RETURNS TABLE directamente en la cláusula FROM con LATERAL.'),

('Normalización de bases de datos: 1NF a BCNF',
 'La normalización elimina redundancias y dependencias anómalas. La primera forma normal requiere que cada columna sea atómica. La tercera forma normal elimina dependencias transitivas. BCNF es una versión más estricta de 3NF.'),

('Full-Text Search en PostgreSQL con tsvector y tsquery',
 'PostgreSQL ofrece búsqueda de texto completo nativa mediante los tipos tsvector y tsquery. to_tsvector normaliza el texto eliminando stopwords y aplicando stemming. El operador @@ evalúa si un documento contiene la consulta. ts_rank calcula la relevancia.');
