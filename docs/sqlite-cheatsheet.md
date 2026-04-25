# 🗃️ SQLite — Cheat Sheet Completo

> **Versión de referencia:** SQLite 3.x  
> **Última actualización:** Abril 2026  
> **Ideal para:** desarrollo local, apps móviles, herramientas CLI, prototipado rápido

---

## 📋 Tabla de Contenidos

1. [Introducción y características clave](#1-introducción-y-características-clave)
2. [CLI — Interfaz de línea de comandos](#2-cli--interfaz-de-línea-de-comandos)
3. [Tipos de datos](#3-tipos-de-datos)
4. [DDL — Definición de estructuras](#4-ddl--definición-de-estructuras)
5. [DML — Manipulación de datos](#5-dml--manipulación-de-datos)
6. [DQL — Consultas SELECT](#6-dql--consultas-select)
7. [Joins](#7-joins)
8. [Subconsultas](#8-subconsultas)
9. [Funciones integradas](#9-funciones-integradas)
10. [Agregaciones y GROUP BY](#10-agregaciones-y-group-by)
11. [Índices](#11-índices)
12. [Vistas (Views)](#12-vistas-views)
13. [Triggers](#13-triggers)
14. [CTEs y Consultas recursivas](#14-ctes-y-consultas-recursivas)
15. [Transacciones](#15-transacciones)
16. [Manejo de JSON](#16-manejo-de-json)
17. [Full-Text Search (FTS5)](#17-full-text-search-fts5)
18. [PRAGMA — Configuración interna](#18-pragma--configuración-interna)
19. [Importar / Exportar datos](#19-importar--exportar-datos)
20. [Mejores prácticas](#20-mejores-prácticas)

---

## 1. Introducción y características clave

SQLite es un motor de base de datos relacional **embebido**, sin servidor, contenido en un único archivo `.db`. No requiere instalación de servidor.

| Característica         | Descripción                                        |
|------------------------|----------------------------------------------------|
| Sin servidor           | No hay proceso de servidor separado                |
| Un solo archivo        | Toda la base de datos en un `.db` o `.sqlite`      |
| Multiplataforma        | Windows, macOS, Linux, Android, iOS                |
| ACID compliant         | Transacciones seguras                              |
| Tipado dinámico        | Flexible pero con Type Affinity                    |
| Tamaño máximo DB       | 281 TB (teórico)                                   |
| Concurrencia           | Múltiples lectores, un escritor a la vez (WAL mode)|

---

## 2. CLI — Interfaz de línea de comandos

### Abrir / crear una base de datos

```bash
sqlite3 mi_base.db          # Abre o crea el archivo
sqlite3                     # Modo interactivo en memoria (:memory:)
sqlite3 mi_base.db < dump.sql  # Ejecutar script SQL desde archivo
```

### Comandos internos del CLI (dot-commands)

```sql
.help                  -- Lista todos los comandos disponibles
.databases             -- Muestra bases de datos adjuntas
.tables                -- Lista todas las tablas
.schema                -- Muestra el DDL completo
.schema nombre_tabla   -- DDL de una tabla específica
.mode column           -- Salida en columnas alineadas
.mode table            -- Salida en formato tabla (v3.33+)
.mode csv              -- Salida en CSV
.mode json             -- Salida en JSON
.headers on            -- Mostrar nombres de columnas
.width 20 10 15        -- Ancho de columnas en modo column
.output archivo.txt    -- Redirigir salida a archivo
.output stdout         -- Volver a mostrar en pantalla
.read archivo.sql      -- Ejecutar un archivo SQL
.import data.csv tabla -- Importar CSV a tabla existente
.dump                  -- Volcar toda la DB como SQL
.dump tabla            -- Volcar una tabla específica
.quit / .exit          -- Salir del CLI
.timer on              -- Mostrar tiempo de ejecución
.explain on            -- Mostrar plan de ejecución
```

### Ejemplo de sesión típica

```bash
$ sqlite3 app.db
SQLite version 3.45.0
sqlite> .headers on
sqlite> .mode table
sqlite> SELECT * FROM usuarios LIMIT 5;
```

---

## 3. Tipos de datos

SQLite usa un sistema de **Type Affinity** (afinidad de tipos), no tipado estricto.

### Afinidades disponibles

| Afinidad   | Tipos SQL equivalentes                                      |
|------------|-------------------------------------------------------------|
| `INTEGER`  | INT, INTEGER, TINYINT, SMALLINT, MEDIUMINT, BIGINT          |
| `REAL`     | REAL, FLOAT, DOUBLE                                         |
| `TEXT`     | TEXT, VARCHAR, CHAR, CLOB, CHARACTER                        |
| `BLOB`     | BLOB, ningún tipo declarado                                 |
| `NUMERIC`  | DECIMAL, BOOLEAN, DATE, DATETIME (almacenados como INTEGER) |

### Valores especiales

```sql
NULL        -- Valor nulo
TRUE / FALSE  -- Internamente son 1 y 0
CURRENT_DATE      -- '2026-04-25'
CURRENT_TIME      -- '14:30:00'
CURRENT_TIMESTAMP -- '2026-04-25 14:30:00'
```

> 💡 **Buena práctica:** Aunque SQLite acepta cualquier texto como tipo, usar los tipos estándar mejora la legibilidad y la compatibilidad con ORMs.

---

## 4. DDL — Definición de estructuras

### CREATE TABLE

```sql
-- Tabla básica
CREATE TABLE usuarios (
    id        INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre    TEXT    NOT NULL,
    email     TEXT    NOT NULL UNIQUE,
    edad      INTEGER CHECK(edad >= 0 AND edad <= 150),
    activo    INTEGER DEFAULT 1,          -- 1=TRUE, 0=FALSE
    creado_en TEXT    DEFAULT (datetime('now'))
);

-- Si no existe (idempotente)
CREATE TABLE IF NOT EXISTS productos (
    id     INTEGER PRIMARY KEY,
    nombre TEXT    NOT NULL,
    precio REAL    NOT NULL CHECK(precio > 0)
);

-- Con clave primaria compuesta
CREATE TABLE pedido_items (
    pedido_id  INTEGER NOT NULL,
    producto_id INTEGER NOT NULL,
    cantidad   INTEGER NOT NULL DEFAULT 1,
    PRIMARY KEY (pedido_id, producto_id),
    FOREIGN KEY (pedido_id)   REFERENCES pedidos(id)   ON DELETE CASCADE,
    FOREIGN KEY (producto_id) REFERENCES productos(id) ON DELETE RESTRICT
);
```

### Claves foráneas (IMPORTANTE)

```sql
-- Las FK están DESACTIVADAS por defecto en SQLite
-- Activar por conexión:
PRAGMA foreign_keys = ON;
```

### ALTER TABLE

```sql
-- SQLite tiene soporte limitado de ALTER TABLE
ALTER TABLE usuarios ADD COLUMN telefono TEXT;         -- ✅ Agregar columna
ALTER TABLE usuarios RENAME TO clientes;              -- ✅ Renombrar tabla
ALTER TABLE usuarios RENAME COLUMN nombre TO nombre_completo; -- ✅ (v3.25+)

-- ❌ NO soportado directamente:
-- ALTER TABLE ... DROP COLUMN (solo desde v3.35+)
-- ALTER TABLE ... MODIFY COLUMN
-- ALTER TABLE ... ADD CONSTRAINT
```

> 💡 **Buena práctica para ALTER complejo:** Crear nueva tabla → copiar datos → eliminar original → renombrar nueva.

### DROP TABLE

```sql
DROP TABLE usuarios;
DROP TABLE IF EXISTS usuarios;   -- Sin error si no existe
```

---

## 5. DML — Manipulación de datos

### INSERT

```sql
-- Inserción simple
INSERT INTO usuarios (nombre, email, edad)
VALUES ('Ana Gómez', 'ana@mail.com', 28);

-- Múltiples filas (eficiente)
INSERT INTO usuarios (nombre, email, edad) VALUES
    ('Carlos Ruiz', 'carlos@mail.com', 35),
    ('María López', 'maria@mail.com', 22),
    ('Juan Pérez', 'juan@mail.com', 41);

-- Ignorar si ya existe (por UNIQUE constraint)
INSERT OR IGNORE INTO usuarios (nombre, email) VALUES ('Ana', 'ana@mail.com');

-- Reemplazar si existe (DELETE + INSERT)
INSERT OR REPLACE INTO usuarios (id, nombre, email)
VALUES (1, 'Ana Gómez Actualizada', 'ana@mail.com');

-- Upsert moderno (v3.24+)
INSERT INTO usuarios (email, nombre, edad)
VALUES ('ana@mail.com', 'Ana', 29)
ON CONFLICT(email) DO UPDATE SET
    nombre = excluded.nombre,
    edad   = excluded.edad;

-- Insertar desde SELECT
INSERT INTO clientes_vip (nombre, email)
SELECT nombre, email FROM usuarios WHERE compras_total > 1000;
```

### UPDATE

```sql
-- Básico
UPDATE usuarios SET activo = 0 WHERE id = 5;

-- Múltiples columnas
UPDATE productos
SET precio = precio * 1.10,
    actualizado_en = datetime('now')
WHERE categoria = 'electronica';

-- Con subconsulta
UPDATE pedidos
SET estado = 'enviado'
WHERE id IN (SELECT pedido_id FROM envios WHERE fecha_envio IS NOT NULL);
```

### DELETE

```sql
-- Con condición
DELETE FROM usuarios WHERE activo = 0;

-- Todos los registros (mantiene la tabla)
DELETE FROM logs;

-- Con subconsulta
DELETE FROM productos
WHERE id NOT IN (SELECT DISTINCT producto_id FROM pedido_items);

-- Truncar equivalente (más rápido para vaciar)
DELETE FROM tabla;
DELETE FROM sqlite_sequence WHERE name = 'tabla'; -- Resetear AUTOINCREMENT
```

---

## 6. DQL — Consultas SELECT

### Estructura completa

```sql
SELECT   [DISTINCT] columnas | expresiones | *
FROM     tabla [alias]
JOIN     ...
WHERE    condición_fila
GROUP BY columnas
HAVING   condición_grupo
ORDER BY columna [ASC | DESC] [NULLS FIRST | NULLS LAST]
LIMIT    n
OFFSET   m;
```

### Ejemplos progresivos

```sql
-- Todo de una tabla
SELECT * FROM usuarios;

-- Columnas específicas con alias
SELECT nombre AS "Nombre Completo", email AS "Correo"
FROM usuarios;

-- Filtros básicos
SELECT * FROM productos WHERE precio BETWEEN 10.00 AND 50.00;
SELECT * FROM usuarios  WHERE nombre LIKE 'Ana%';    -- Empieza con 'Ana'
SELECT * FROM usuarios  WHERE email LIKE '%@gmail%'; -- Contiene '@gmail'
SELECT * FROM pedidos   WHERE estado IN ('pendiente', 'procesando');
SELECT * FROM usuarios  WHERE telefono IS NULL;
SELECT * FROM usuarios  WHERE telefono IS NOT NULL;

-- Orden y límite
SELECT * FROM productos
ORDER BY precio DESC, nombre ASC
LIMIT 10 OFFSET 20;    -- Página 3 (si cada página tiene 10 resultados)

-- Expresiones calculadas
SELECT
    nombre,
    precio,
    precio * 0.19   AS iva,
    precio * 1.19   AS precio_con_iva,
    ROUND(precio * 1.19, 2) AS precio_final
FROM productos;

-- CASE WHEN (condicional)
SELECT
    nombre,
    edad,
    CASE
        WHEN edad < 18 THEN 'Menor'
        WHEN edad < 65 THEN 'Adulto'
        ELSE 'Adulto mayor'
    END AS rango_edad
FROM usuarios;

-- DISTINCT
SELECT DISTINCT categoria FROM productos ORDER BY categoria;

-- EXISTS
SELECT * FROM clientes c
WHERE EXISTS (
    SELECT 1 FROM pedidos p WHERE p.cliente_id = c.id
);
```

---

## 7. Joins

```sql
-- INNER JOIN (solo registros con coincidencia en ambas tablas)
SELECT u.nombre, p.total, p.fecha
FROM usuarios u
INNER JOIN pedidos p ON p.usuario_id = u.id;

-- LEFT JOIN (todos los de la izquierda, NULL si no hay coincidencia)
SELECT u.nombre, COUNT(p.id) AS total_pedidos
FROM usuarios u
LEFT JOIN pedidos p ON p.usuario_id = u.id
GROUP BY u.id, u.nombre;

-- CROSS JOIN (producto cartesiano)
SELECT a.color, b.talla
FROM colores a CROSS JOIN tallas b;

-- Self JOIN (tabla con sí misma)
SELECT e.nombre AS empleado, j.nombre AS jefe
FROM empleados e
LEFT JOIN empleados j ON e.jefe_id = j.id;

-- Múltiples JOIN
SELECT
    u.nombre,
    p.id         AS pedido,
    pr.nombre    AS producto,
    pi.cantidad
FROM usuarios u
JOIN pedidos p       ON p.usuario_id  = u.id
JOIN pedido_items pi ON pi.pedido_id  = p.id
JOIN productos pr    ON pr.id         = pi.producto_id
WHERE u.activo = 1
ORDER BY p.fecha DESC;
```

> ⚠️ **Nota:** SQLite **no soporta** `RIGHT JOIN` ni `FULL OUTER JOIN`. Se deben simular con `LEFT JOIN` + `UNION`.

```sql
-- Simular FULL OUTER JOIN
SELECT u.nombre, p.total FROM usuarios u LEFT JOIN pedidos p ON p.usuario_id = u.id
UNION
SELECT u.nombre, p.total FROM pedidos p LEFT JOIN usuarios u ON u.id = p.usuario_id;
```

---

## 8. Subconsultas

```sql
-- En WHERE
SELECT * FROM productos
WHERE precio > (SELECT AVG(precio) FROM productos);

-- Subconsulta correlacionada
SELECT u.nombre,
    (SELECT COUNT(*) FROM pedidos p WHERE p.usuario_id = u.id) AS num_pedidos
FROM usuarios u;

-- En FROM (tabla derivada)
SELECT categoria, promedio
FROM (
    SELECT categoria, AVG(precio) AS promedio
    FROM productos
    GROUP BY categoria
) AS stats
WHERE promedio > 100;

-- Subquery con IN
SELECT * FROM usuarios
WHERE id IN (
    SELECT DISTINCT usuario_id FROM pedidos WHERE estado = 'completado'
);
```

---

## 9. Funciones integradas

### Texto

```sql
LENGTH(texto)                  -- Longitud en caracteres
UPPER(texto)                   -- Mayúsculas
LOWER(texto)                   -- Minúsculas
TRIM(texto)                    -- Eliminar espacios al inicio y fin
LTRIM(texto) / RTRIM(texto)    -- Solo izquierda / derecha
SUBSTR(texto, inicio, largo)   -- Substring (índice desde 1)
INSTR(texto, subcadena)        -- Posición de subcadena (0 si no existe)
REPLACE(texto, viejo, nuevo)   -- Reemplazar ocurrencias
PRINTF('%s tiene %d años', nombre, edad)  -- Formato estilo C
LIKE / GLOB                    -- Patrones (% wildcard vs * wildcard)
```

### Numéricas

```sql
ABS(n)              -- Valor absoluto
ROUND(n, decimales) -- Redondear
CEIL(n)             -- Techo (redondear hacia arriba)
FLOOR(n)            -- Piso (redondear hacia abajo)
MAX(a, b)           -- Máximo entre dos valores
MIN(a, b)           -- Mínimo entre dos valores
RANDOM()            -- Número aleatorio (-9223372036854775808 a 9223372036854775807)
HEX(n)              -- Convertir a hexadecimal
```

### Fecha y tiempo

```sql
-- Obtener fecha/hora actual
DATE('now')                          -- '2026-04-25'
TIME('now')                          -- '14:30:00'
DATETIME('now')                      -- '2026-04-25 14:30:00'
DATETIME('now', 'localtime')         -- Hora local del sistema

-- Manipulación de fechas
DATE('now', '+7 days')               -- Hoy + 7 días
DATE('now', '-1 month')              -- Hace un mes
DATE('now', 'start of month')        -- Primer día del mes
DATE('now', 'start of year')         -- Primer día del año
DATETIME('now', '+2 hours', '+30 minutes')

-- Extraer partes
STRFTIME('%Y', fecha)                -- Año: '2026'
STRFTIME('%m', fecha)                -- Mes: '04'
STRFTIME('%d', fecha)                -- Día: '25'
STRFTIME('%H:%M', fecha)             -- Hora:minuto
STRFTIME('%s', 'now')                -- Unix timestamp (segundos)
STRFTIME('%Y-%m-%dT%H:%M:%SZ', 'now') -- ISO 8601

-- Diferencia entre fechas (en días)
CAST(julianday('now') - julianday(fecha_nacimiento) AS INTEGER)
```

### Conversión y utilidades

```sql
CAST(valor AS tipo)      -- Conversión de tipo
TYPEOF(valor)            -- Tipo real del valor: 'integer','real','text','blob','null'
COALESCE(a, b, c)        -- Primer valor no-NULL
NULLIF(a, b)             -- NULL si a == b, sino retorna a
IIF(condicion, si, no)   -- IF ternario (v3.32+)
IFNULL(valor, alternativo) -- NULL check simplificado
LAST_INSERT_ROWID()      -- ID del último INSERT
CHANGES()                -- Filas afectadas por el último DML
TOTAL_CHANGES()          -- Total de cambios desde apertura
```

---

## 10. Agregaciones y GROUP BY

### Funciones de agregación

```sql
COUNT(*)              -- Total de filas (incluye NULLs)
COUNT(columna)        -- Total de filas donde columna no es NULL
COUNT(DISTINCT col)   -- Valores únicos no-NULL
SUM(columna)          -- Suma
AVG(columna)          -- Promedio
MAX(columna)          -- Máximo
MIN(columna)          -- Mínimo
GROUP_CONCAT(col)     -- Concatenar valores: 'a,b,c'
GROUP_CONCAT(col, ' | ')  -- Con separador personalizado
TOTAL(columna)        -- Como SUM pero devuelve 0.0 (nunca NULL)
```

### Ejemplos de GROUP BY y HAVING

```sql
-- Ventas por categoría
SELECT
    categoria,
    COUNT(*) AS total_productos,
    AVG(precio) AS precio_promedio,
    SUM(precio) AS suma_total,
    MIN(precio) AS mas_barato,
    MAX(precio) AS mas_caro
FROM productos
GROUP BY categoria
ORDER BY suma_total DESC;

-- HAVING filtra grupos (no filas individuales)
SELECT usuario_id, COUNT(*) AS num_pedidos, SUM(total) AS total_gastado
FROM pedidos
WHERE estado = 'completado'
GROUP BY usuario_id
HAVING num_pedidos >= 3 AND total_gastado > 500
ORDER BY total_gastado DESC;

-- GROUP_CONCAT
SELECT categoria, GROUP_CONCAT(nombre, ', ') AS productos
FROM productos
GROUP BY categoria;
```

---

## 11. Índices

```sql
-- Índice simple
CREATE INDEX idx_usuarios_email ON usuarios(email);

-- Índice único
CREATE UNIQUE INDEX idx_usuarios_email_unico ON usuarios(email);

-- Índice compuesto (orden importa)
CREATE INDEX idx_pedidos_usuario_fecha ON pedidos(usuario_id, fecha DESC);

-- Índice parcial (condicional)
CREATE INDEX idx_pedidos_pendientes ON pedidos(fecha)
WHERE estado = 'pendiente';

-- Ver índices de una tabla
PRAGMA index_list('usuarios');
PRAGMA index_info('idx_usuarios_email');

-- Eliminar índice
DROP INDEX IF EXISTS idx_usuarios_email;

-- Ver plan de ejecución (verificar si se usa el índice)
EXPLAIN QUERY PLAN
SELECT * FROM pedidos WHERE usuario_id = 42 AND estado = 'completado';
```

> 💡 **Buenas prácticas con índices:**
> - Indexar columnas usadas en `WHERE`, `JOIN ON`, `ORDER BY`
> - El orden en índices compuestos importa (columna más selectiva primero)
> - Demasiados índices ralentizan INSERT/UPDATE/DELETE
> - La PRIMARY KEY ya crea un índice automáticamente

---

## 12. Vistas (Views)

```sql
-- Crear vista
CREATE VIEW IF NOT EXISTS vista_pedidos_detalle AS
SELECT
    p.id,
    u.nombre AS cliente,
    p.total,
    p.estado,
    p.fecha,
    COUNT(pi.producto_id) AS num_productos
FROM pedidos p
JOIN usuarios u    ON u.id = p.usuario_id
JOIN pedido_items pi ON pi.pedido_id = p.id
GROUP BY p.id;

-- Usar vista como tabla normal
SELECT * FROM vista_pedidos_detalle WHERE estado = 'pendiente';

-- Ver definición de la vista
SELECT sql FROM sqlite_master WHERE type = 'view' AND name = 'vista_pedidos_detalle';

-- Eliminar vista
DROP VIEW IF EXISTS vista_pedidos_detalle;
```

> ⚠️ SQLite no soporta vistas actualizables (INSERT/UPDATE/DELETE sobre una vista), a diferencia de otros motores. Usar triggers para simularlo.

---

## 13. Triggers

```sql
-- AFTER INSERT: registrar auditoría
CREATE TRIGGER IF NOT EXISTS trg_usuarios_insert
AFTER INSERT ON usuarios
BEGIN
    INSERT INTO auditoria (tabla, accion, registro_id, fecha)
    VALUES ('usuarios', 'INSERT', NEW.id, datetime('now'));
END;

-- BEFORE UPDATE: validar y actualizar timestamp
CREATE TRIGGER IF NOT EXISTS trg_productos_update
BEFORE UPDATE ON productos
BEGIN
    SELECT RAISE(ABORT, 'El precio no puede ser negativo')
    WHERE NEW.precio < 0;
END;

CREATE TRIGGER IF NOT EXISTS trg_productos_update_ts
AFTER UPDATE ON productos
BEGIN
    UPDATE productos SET actualizado_en = datetime('now') WHERE id = NEW.id;
END;

-- AFTER DELETE: soft delete o limpieza en cascada manual
CREATE TRIGGER IF NOT EXISTS trg_usuarios_delete
AFTER DELETE ON usuarios
BEGIN
    UPDATE pedidos SET estado = 'cancelado'
    WHERE usuario_id = OLD.id AND estado = 'pendiente';
END;

-- Ver triggers existentes
SELECT name, sql FROM sqlite_master WHERE type = 'trigger';

-- Eliminar trigger
DROP TRIGGER IF EXISTS trg_usuarios_insert;
```

### Palabras clave en triggers

| Keyword | Significado                       |
|---------|-----------------------------------|
| `NEW`   | Fila nueva (INSERT/UPDATE)        |
| `OLD`   | Fila anterior (UPDATE/DELETE)     |
| `RAISE(ABORT, 'msg')` | Lanzar error y revertir |
| `RAISE(IGNORE, '')`   | Ignorar la operación    |
| `RAISE(FAIL, 'msg')`  | Error sin revertir      |

---

## 14. CTEs y Consultas recursivas

### CTE básica (Common Table Expression)

```sql
-- Mejor legibilidad para consultas complejas
WITH pedidos_recientes AS (
    SELECT * FROM pedidos
    WHERE fecha >= DATE('now', '-30 days')
),
top_clientes AS (
    SELECT usuario_id, SUM(total) AS total_gastado
    FROM pedidos_recientes
    GROUP BY usuario_id
    HAVING total_gastado > 200
)
SELECT u.nombre, tc.total_gastado
FROM top_clientes tc
JOIN usuarios u ON u.id = tc.usuario_id
ORDER BY tc.total_gastado DESC;
```

### CTE Recursiva

```sql
-- Secuencia de números del 1 al 10
WITH RECURSIVE seq(n) AS (
    SELECT 1
    UNION ALL
    SELECT n + 1 FROM seq WHERE n < 10
)
SELECT * FROM seq;

-- Árbol jerárquico (categorías anidadas)
WITH RECURSIVE arbol(id, nombre, padre_id, nivel, ruta) AS (
    -- Caso base: categorías raíz
    SELECT id, nombre, padre_id, 0, nombre
    FROM categorias WHERE padre_id IS NULL

    UNION ALL

    -- Caso recursivo: hijos
    SELECT c.id, c.nombre, c.padre_id, a.nivel + 1,
           a.ruta || ' > ' || c.nombre
    FROM categorias c
    JOIN arbol a ON a.id = c.padre_id
)
SELECT nivel, ruta FROM arbol ORDER BY ruta;
```

---

## 15. Transacciones

```sql
-- Transacción explícita (recomendado para múltiples operaciones)
BEGIN TRANSACTION;
    INSERT INTO pedidos (usuario_id, total) VALUES (1, 150.00);
    INSERT INTO pedido_items (pedido_id, producto_id, cantidad) VALUES (last_insert_rowid(), 3, 2);
    UPDATE productos SET stock = stock - 2 WHERE id = 3;
COMMIT;

-- Si algo falla
BEGIN;
    UPDATE cuentas SET saldo = saldo - 100 WHERE id = 1;
    UPDATE cuentas SET saldo = saldo + 100 WHERE id = 2;
COMMIT;

-- Revertir cambios
ROLLBACK;

-- SAVEPOINT (punto intermedio de guardado)
BEGIN;
    INSERT INTO tabla1 VALUES (1);
    SAVEPOINT sp1;
    INSERT INTO tabla2 VALUES (2);
    ROLLBACK TO sp1;   -- Revierte solo hasta el savepoint
    RELEASE sp1;       -- Libera el savepoint
COMMIT;

-- Modos de transacción
BEGIN DEFERRED;    -- Bloqueo diferido (default)
BEGIN IMMEDIATE;   -- Bloqueo de escritura inmediato
BEGIN EXCLUSIVE;   -- Bloqueo exclusivo total
```

> 💡 **Buena práctica:** Envolver múltiples INSERTs en una transacción puede mejorar el rendimiento **100x** comparado con inserciones individuales.

---

## 16. Manejo de JSON

SQLite incluye funciones JSON desde la versión 3.38+.

```sql
-- Crear tabla con columna JSON
CREATE TABLE configuracion (
    id   INTEGER PRIMARY KEY,
    data TEXT    -- Almacenar JSON como TEXT
);

INSERT INTO configuracion (data) VALUES
('{"nombre": "App", "version": "1.0", "tags": ["web", "api"], "activo": true}');

-- Leer valores del JSON
SELECT json_extract(data, '$.nombre')    AS nombre    FROM configuracion;
SELECT json_extract(data, '$.version')   AS version   FROM configuracion;
SELECT json_extract(data, '$.tags[0]')   AS primer_tag FROM configuracion;

-- Verificar si es JSON válido
SELECT json_valid('{"a":1}');  -- 1
SELECT json_valid('no-json');  -- 0

-- Modificar JSON
SELECT json_set('{"a":1}', '$.b', 2);       -- {"a":1,"b":2}
SELECT json_insert('{"a":1}', '$.b', 2);    -- Insertar si no existe
SELECT json_replace('{"a":1}', '$.a', 99);  -- Reemplazar si existe
SELECT json_remove('{"a":1,"b":2}', '$.b'); -- Eliminar clave

-- json_each: expandir array JSON como filas
SELECT value FROM json_each('["rojo","verde","azul"]');

-- json_tree: recorrer objeto completo
SELECT key, value, type FROM json_tree('{"a":1,"b":{"c":2}}');

-- Filtrar por valor dentro de JSON
SELECT * FROM configuracion
WHERE json_extract(data, '$.activo') = 1;

-- Construir JSON desde consulta
SELECT json_object('id', id, 'nombre', nombre) FROM usuarios LIMIT 3;
SELECT json_group_array(nombre) FROM usuarios;
SELECT json_group_object(id, nombre) FROM usuarios;
```

---

## 17. Full-Text Search (FTS5)

```sql
-- Crear tabla FTS5
CREATE VIRTUAL TABLE articulos_fts USING fts5(
    titulo,
    contenido,
    content='articulos',   -- Tabla de origen (opcional)
    content_rowid='id'
);

-- Poblar la tabla FTS
INSERT INTO articulos_fts(rowid, titulo, contenido)
SELECT id, titulo, contenido FROM articulos;

-- Búsqueda básica
SELECT * FROM articulos_fts WHERE articulos_fts MATCH 'sqlite';

-- Búsqueda en columna específica
SELECT * FROM articulos_fts WHERE articulos_fts MATCH 'titulo:base datos';

-- Operadores booleanos
SELECT * FROM articulos_fts WHERE articulos_fts MATCH 'sqlite AND rendimiento';
SELECT * FROM articulos_fts WHERE articulos_fts MATCH 'sqlite OR postgresql';
SELECT * FROM articulos_fts WHERE articulos_fts MATCH 'sqlite NOT mysql';

-- Prefijo (autocompletar)
SELECT * FROM articulos_fts WHERE articulos_fts MATCH 'sql*';

-- Frase exacta
SELECT * FROM articulos_fts WHERE articulos_fts MATCH '"base de datos"';

-- Ranking por relevancia
SELECT *, rank FROM articulos_fts
WHERE articulos_fts MATCH 'sqlite'
ORDER BY rank;

-- Snippets con resaltado
SELECT snippet(articulos_fts, 1, '<b>', '</b>', '...', 20) AS extracto
FROM articulos_fts
WHERE articulos_fts MATCH 'sqlite';
```

---

## 18. PRAGMA — Configuración interna

### Rendimiento

```sql
PRAGMA journal_mode = WAL;          -- Write-Ahead Log (mejor concurrencia) ✅
PRAGMA journal_mode = DELETE;       -- Default (journal normal)
PRAGMA synchronous = NORMAL;        -- Balance velocidad/seguridad ✅
PRAGMA synchronous = FULL;          -- Más seguro, más lento
PRAGMA synchronous = OFF;           -- Muy rápido, peligroso
PRAGMA cache_size = -64000;         -- Cache de 64 MB (negativo = KB)
PRAGMA page_size = 4096;            -- Tamaño de página (antes de crear DB)
PRAGMA mmap_size = 268435456;       -- Memory-mapped I/O: 256 MB
PRAGMA temp_store = MEMORY;         -- Tablas temporales en RAM
PRAGMA busy_timeout = 5000;         -- Esperar 5s antes de error de bloqueo
```

### Integridad y mantenimiento

```sql
PRAGMA foreign_keys = ON;           -- Activar claves foráneas ⚠️ (OFF por defecto)
PRAGMA integrity_check;             -- Verificar integridad completa
PRAGMA quick_check;                 -- Verificación rápida
PRAGMA optimize;                    -- Optimizar estadísticas del query planner
VACUUM;                             -- Compactar DB y recuperar espacio
VACUUM INTO 'backup.db';            -- Compactar a nuevo archivo (v3.27+)
ANALYZE;                            -- Actualizar estadísticas de índices
```

### Información

```sql
PRAGMA database_list;               -- Bases de datos adjuntas
PRAGMA table_info('usuarios');      -- Columnas de una tabla
PRAGMA table_xinfo('usuarios');     -- Columnas + columnas ocultas
PRAGMA index_list('usuarios');      -- Índices de una tabla
PRAGMA foreign_key_list('pedidos'); -- FK de una tabla
PRAGMA compile_options;             -- Opciones de compilación de SQLite
PRAGMA sqlite_version();            -- Versión de SQLite
```

---

## 19. Importar / Exportar datos

### Exportar

```bash
# Dump completo como SQL
sqlite3 app.db .dump > backup.sql

# Dump de una tabla específica
sqlite3 app.db ".dump usuarios" > usuarios_backup.sql

# Exportar a CSV
sqlite3 -header -csv app.db "SELECT * FROM usuarios;" > usuarios.csv

# Exportar con formato tabla
sqlite3 -header -column app.db "SELECT * FROM usuarios;"
```

### Importar

```bash
# Restaurar desde dump SQL
sqlite3 nueva_app.db < backup.sql

# Importar CSV (la tabla debe existir)
sqlite3 app.db <<EOF
.mode csv
.import usuarios.csv usuarios
EOF
```

### Adjuntar bases de datos

```sql
-- Trabajar con múltiples archivos .db simultáneamente
ATTACH DATABASE 'historico.db' AS hist;

SELECT * FROM hist.pedidos WHERE year = 2025;

INSERT INTO pedidos SELECT * FROM hist.pedidos WHERE total > 1000;

DETACH DATABASE hist;
```

---

## 20. Mejores prácticas

### Diseño de esquema

```sql
-- ✅ Siempre activar FK al inicio de la conexión
PRAGMA foreign_keys = ON;

-- ✅ Usar INTEGER PRIMARY KEY AUTOINCREMENT para IDs
-- (ROWID alias, más eficiente que UUID)
id INTEGER PRIMARY KEY AUTOINCREMENT

-- ✅ Usar WITHOUT ROWID para tablas con clave compuesta y acceso por rango
CREATE TABLE sesiones (
    token TEXT,
    usuario_id INTEGER,
    PRIMARY KEY (token)
) WITHOUT ROWID;

-- ✅ Timestamps en formato ISO 8601 (TEXT o INTEGER)
creado_en TEXT DEFAULT (datetime('now')),
actualizado_en TEXT

-- ✅ Soft delete en vez de DELETE
activo INTEGER DEFAULT 1  -- 0 = eliminado lógicamente
```

### Rendimiento

```sql
-- ✅ WAL mode para aplicaciones con concurrencia
PRAGMA journal_mode = WAL;

-- ✅ Envolver múltiples INSERTs en transacción
BEGIN;
-- ...miles de inserts...
COMMIT;

-- ✅ Usar parámetros vinculados (desde el lenguaje de programación)
-- En Go: db.Exec("INSERT INTO t VALUES (?)", valor)
-- En Python: cursor.execute("INSERT INTO t VALUES (?)", (valor,))
-- NUNCA: "INSERT INTO t VALUES ('" + valor + "')"  -- ⚠️ SQL Injection

-- ✅ Revisar EXPLAIN QUERY PLAN para consultas lentas
EXPLAIN QUERY PLAN SELECT * FROM pedidos WHERE usuario_id = 1;

-- ✅ Ejecutar ANALYZE periódicamente
ANALYZE;

-- ✅ VACUUM periódico para recuperar espacio
VACUUM;
```

### Seguridad

```sql
-- ⚠️ NUNCA construir SQL con concatenación de strings
-- ✅ SIEMPRE usar parámetros preparados (prepared statements)

-- ✅ Cifrado de base de datos: usar SQLCipher (extensión)
-- ✅ Restringir permisos del archivo .db en el sistema operativo
-- ✅ Backups regulares con: VACUUM INTO 'backup_fecha.db'
```

### Operaciones comunes reutilizables

```sql
-- Paginación eficiente
SELECT * FROM productos
ORDER BY id
LIMIT 20 OFFSET (numero_pagina - 1) * 20;

-- Upsert limpio
INSERT INTO config (clave, valor) VALUES ('tema', 'oscuro')
ON CONFLICT(clave) DO UPDATE SET valor = excluded.valor;

-- Contar con y sin filtro en una sola consulta
SELECT
    COUNT(*) AS total,
    SUM(CASE WHEN activo = 1 THEN 1 ELSE 0 END) AS activos,
    SUM(CASE WHEN activo = 0 THEN 1 ELSE 0 END) AS inactivos
FROM usuarios;

-- Obtener el N-ésimo mayor valor
SELECT precio FROM productos ORDER BY precio DESC LIMIT 1 OFFSET (N-1);

-- Detectar duplicados
SELECT email, COUNT(*) AS repeticiones
FROM usuarios
GROUP BY email
HAVING repeticiones > 1;
```

---

## 📚 Referencias rápidas

| Recurso                          | URL                                      |
|----------------------------------|------------------------------------------|
| Documentación oficial            | https://sqlite.org/docs.html             |
| Funciones de fecha               | https://sqlite.org/lang_datefunc.html    |
| JSON functions                   | https://sqlite.org/json1.html            |
| FTS5                             | https://sqlite.org/fts5.html             |
| PRAGMA reference                 | https://sqlite.org/pragma.html           |
| Query planner (EXPLAIN)          | https://sqlite.org/eqp.html              |
| SQLite Browser (GUI)             | https://sqlitebrowser.org                |

---

*Cheat sheet generado para uso educativo — BC Channel EPTI / SENA ADSO*
