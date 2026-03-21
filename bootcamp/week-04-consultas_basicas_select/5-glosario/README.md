# Glosario — Semana 04: SELECT

Términos clave de la semana ordenados alfabéticamente.

---

## A

**Alias**: Nombre alternativo asignado a una columna o tabla con la palabra
clave `AS`. Mejora la legibilidad del resultado sin cambiar el esquema.

**ASC**: Dirección de orden ascendente en `ORDER BY` (menor a mayor). Es el
valor por defecto si se omite la dirección.

## C

**Cláusula**: Parte de una sentencia SQL con función específica. Ejemplo:
`SELECT`, `FROM`, `WHERE`, `ORDER BY`, `LIMIT` son cláusulas.

## D

**DESC**: Dirección de orden descendente en `ORDER BY` (mayor a menor).

## E

**Expresión calculada**: Valor derivado de una operación en `SELECT`, como
`salary * 12`. No modifica los datos almacenados.

## L

**LIMIT**: Cláusula que restringe el número máximo de filas devueltas por una
consulta.

## O

**OFFSET**: Cláusula que indica cuántas filas saltar antes de empezar a
devolver resultados. Se usa junto con `LIMIT` para paginación.

**ORDER BY**: Cláusula que determina el orden de las filas en el resultado.
Sin ella, el orden no está garantizado.

## P

**Paginación**: Técnica para dividir un conjunto grande de resultados en páginas
más pequeñas usando `LIMIT` y `OFFSET`.

**Predicado**: Expresión booleana usada en `WHERE` para filtrar filas.
Ejemplo: `salary > 70000`.

## S

**SELECT**: Sentencia DQL (Data Query Language) para recuperar datos de una
o más tablas.

## W

**WHERE**: Cláusula que filtra qué filas se incluyen en el resultado de un
`SELECT`.
