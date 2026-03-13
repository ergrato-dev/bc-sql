# Glosario — Semana 03: DML

Términos clave de la semana ordenados alfabéticamente.

---

## A

**Autoincrement**: Mecanismo para generar valores enteros únicos automáticamente
en la clave primaria. En SQLite se activa con `INTEGER PRIMARY KEY` sin necesidad
de la palabra `AUTOINCREMENT`.

## C

**Commit (DML)**: Confirmación permanente de los cambios realizados mediante DML.
En SQLite fuera de una transacción explícita, cada sentencia se confirma de
forma automática.

## D

**DELETE**: Sentencia DML que elimina una o más filas de una tabla manteniendo
la estructura de la tabla intacta.

**DML (Data Manipulation Language)**: Subconjunto del SQL que modifica los datos
almacenados. Incluye `INSERT`, `UPDATE`, `DELETE` y `SELECT`.

## F

**FK constraint (Foreign Key)**: Restricción que impide insertar en una tabla hijo
un valor que no exista en la tabla padre referenciada.

## I

**INSERT INTO**: Sentencia DML que añade una o más filas nuevas a una tabla.

## M

**Multi-row INSERT**: Variante de `INSERT INTO` que carga varias filas en una sola
sentencia usando múltiples grupos de valores separados por comas.

## R

**Rollback**: Deshacer los cambios DML realizados desde el inicio de una
transacción activa. Requiere `BEGIN TRANSACTION` previo.

## S

**SET (cláusula)**: Parte de `UPDATE` que especifica qué columnas se actualizan y
a qué valores.

## U

**UPDATE**: Sentencia DML que modifica el valor de una o más columnas en filas
existentes. Requiere `WHERE` para no afectar todas las filas.

## W

**WHERE (clausula en DML)**: Condición que filtra qué filas se afectan en
`UPDATE` y `DELETE`. Omitirla afecta a **todas** las filas de la tabla.
