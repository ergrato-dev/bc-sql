# Glosario — Semana 08: Repaso Etapa 0

Consolidación de términos clave de las semanas 01–07.

---

## A

**Alias (AS)**: Nombre temporal para una columna o tabla en una query.
Ejemplo: `COUNT(*) AS total`.

**ALTER TABLE**: Comando DDL que modifica la estructura de una tabla
existente (ADD COLUMN, RENAME, etc.).

## C

**CHECK**: Constraint que valida una condición de negocio al insertar/actualizar.

**COALESCE**: Función que devuelve el primer argumento no NULL de la lista.

**Constraint**: Regla de integridad definida en el CREATE TABLE.

## D

**DDL** (Data Definition Language): Lenguaje para definir la estructura de
la BD: CREATE, ALTER, DROP.

**DML** (Data Manipulation Language): Lenguaje para manipular datos:
INSERT, UPDATE, DELETE.

**DEFAULT**: Valor asignado automáticamente cuando no se provee uno.

## F

**FOREIGN KEY**: Columna que referencia la PK de otra tabla para garantizar
integridad referencial.

## G

**GROUP BY**: Agrupa filas con el mismo valor para calcular funciones de
agregación por grupo.

## H

**HAVING**: Filtra grupos después de agregar. Análogo a WHERE pero para
resultados de GROUP BY.

## I

**IS NULL / IS NOT NULL**: Operadores para verificar si un valor es NULL o
no. Nunca uses `= NULL`.

## L

**LIKE**: Operador para buscar patrones en cadenas. `%` es cualquier
secuencia, `_` es un carácter.

## N

**NULL**: Ausencia de valor conocido. No es cero ni cadena vacía.

**NULLIF**: Devuelve NULL si dos argumentos son iguales; utl para prevenir
divisiones por cero.

## O

**ORDER BY**: Cláusula que ordena el resultado. `ASC` (defecto), `DESC`.

## P

**PRIMARY KEY**: Identificador único de cada fila. Implica NOT NULL + UNIQUE.

**PRAGMA foreign_keys = ON**: Activa el cumplimiento de FK en SQLite.

## U

**UNIQUE**: Prevents duplicados en una columna. Permite múltiples NULLs.

## W

**WHERE**: Filtra filas individuales antes de cualquier agrupación.
