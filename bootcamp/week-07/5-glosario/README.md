# Glosario — Semana 07: NULL y Constraints

Términos clave de la semana ordenados alfabéticamente.

---

## C

**CHECK**: Constraint que valida una condición de negocio al insertar o
actualizar. Ejemplo: `CHECK (salary > 0)`.

**COALESCE(a, b, ...)**: Devuelve el primer argumento no NULL de la lista.
Si todos son NULL, devuelve NULL.

**Constraint**: Regla que impone la base de datos para garantizar la
integridad de los datos. Se define en el `CREATE TABLE`.

## D

**DEFAULT**: Valor que se asigna automáticamente a una columna cuando no
se provee valor al insertar. Ejemplo: `DEFAULT 1`.

## F

**FOREIGN KEY (FK)**: Constraint que enlaza una columna con la clave
primaria de otra tabla, garantizando integridad referencial.

## I

**IFNULL(a, b)**: Función de SQLite equivalente a `COALESCE(a, b)`.
Devuelve `b` si `a` es NULL.

**IS NOT NULL**: Operador para filtrar filas donde la columna tiene un
valor conocido.

**IS NULL**: Operador para filtrar filas donde la columna no tiene valor.
Nunca uses `= NULL`.

## N

**NOT NULL**: Constraint que impide insertar o actualizar una columna con
valor NULL.

**NULL**: Ausencia de valor conocido en una columna. No es cero ni cadena
vacía. Cualquier comparación con NULL devuelve UNKNOWN.

**NULLIF(a, b)**: Devuelve NULL si `a = b`; de lo contrario, devuelve `a`.
Útil para evitar divisiones por cero.

## O

**ON DELETE**: Acción que se ejecuta en las filas hijas cuando se borra
una fila padre (CASCADE, RESTRICT, SET NULL).

## P

**PRAGMA foreign_keys = ON**: Sentencia de SQLite que activa el
cumplimiento de claves foráneas. Debe ejecutarse en cada conexión.

**PRIMARY KEY (PK)**: Identificador único de cada fila. Implica NOT NULL
+ UNIQUE automáticamente.

## U

**UNIQUE**: Constraint que impide duplicados en una columna o combinación
de columnas. Permite múltiples NULLs.
