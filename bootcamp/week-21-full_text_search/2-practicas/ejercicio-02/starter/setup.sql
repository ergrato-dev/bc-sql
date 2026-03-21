-- ============================================
-- Semana 21: Full-Text Search
-- Ejercicio 02 — Configuración del esquema
-- Motor: PostgreSQL 16
-- ============================================

DROP TABLE IF EXISTS articles;

CREATE TABLE articles (
    id          SERIAL      PRIMARY KEY,
    title       TEXT        NOT NULL,
    body        TEXT        NOT NULL,
    created_at  DATE        NOT NULL DEFAULT CURRENT_DATE,
    search_vector TSVECTOR
);

INSERT INTO articles (title, body) VALUES
('Introducción a las bases de datos relacionales',
 'Una base de datos relacional organiza los datos en tablas con filas y columnas. Las relaciones entre tablas se definen mediante claves foráneas. SQL es el lenguaje estándar para consultar bases de datos relacionales.'),

('Transacciones y propiedades ACID',
 'Una transacción agrupa múltiples operaciones SQL en una unidad atómica. Las propiedades ACID garantizan consistencia, aislamiento y durabilidad. BEGIN inicia la transacción y COMMIT la confirma. ROLLBACK deshace los cambios.'),

('Índices en PostgreSQL: B-tree y GIN',
 'Los índices aceleran las consultas evitando escaneos completos de tabla. El índice B-tree es ideal para comparaciones de igualdad y rangos. El índice GIN es especialmente eficiente para búsqueda de texto completo y columnas de tipo array.'),

('Funciones y procedimientos en PL/pgSQL',
 'PL/pgSQL permite crear funciones y procedimientos almacenados en el motor. Las funciones retornan valores y los procedimientos ejecutan lógica sin retorno. Se usa DECLARE, IF, LOOP y EXCEPTION para control de flujo y manejo de errores.'),

('Triggers: automatización de lógica en la base de datos',
 'Un trigger ejecuta una función automáticamente al ocurrir un evento DML como INSERT, UPDATE o DELETE. Los triggers BEFORE pueden validar y transformar datos. Los triggers AFTER son ideales para auditoría y derivación de datos.'),

('Optimización de consultas con EXPLAIN ANALYZE',
 'EXPLAIN ANALYZE muestra el plan de ejecución real de una consulta SQL. El costo indica el esfuerzo de cada operación. Los seq scan son lentos en tablas grandes. Los index scan e index only scan son más eficientes.'),

('JSON y JSONB en PostgreSQL',
 'PostgreSQL soporta almacenamiento semiestructurado con JSON y JSONB. JSONB almacena datos binarios optimizados. Los operadores -> y ->> acceden a campos del documento. Se puede crear índice GIN sobre columnas JSONB para búsquedas eficientes.'),

('Joins avanzados: LATERAL y funciones tabulares',
 'El JOIN LATERAL permite que una subquery en FROM haga referencia a columnas de tablas anteriores en la misma cláusula. CROSS JOIN LATERAL es JOIN LATERAL ON TRUE. Se puede llamar funciones RETURNS TABLE desde FROM con LATERAL.'),

('Normalización de bases de datos: 1NF a BCNF',
 'La normalización elimina redundancias y dependencias anómalas. La primera forma normal requiere columnas atómicas. La tercera forma normal elimina dependencias transitivas. BCNF es una versión más estricta de 3FN.'),

('Full-Text Search en PostgreSQL con tsvector y tsquery',
 'PostgreSQL ofrece búsqueda de texto completo nativa con tsvector y tsquery. to_tsvector normaliza el texto eliminando stopwords y aplicando stemming. El operador @@ evalúa coincidencias. ts_rank calcula relevancia y ts_headline resalta fragmentos.');

-- Rellenar search_vector con pesos: título A, cuerpo B
UPDATE articles
SET search_vector =
    setweight(to_tsvector('spanish', COALESCE(title, '')), 'A') ||
    setweight(to_tsvector('spanish', COALESCE(body,  '')), 'B');

CREATE INDEX idx_articles_sv ON articles USING GIN (search_vector);
