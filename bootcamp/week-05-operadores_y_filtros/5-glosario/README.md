# Glosario — Semana 05: Operadores y Filtros

Términos clave de la semana ordenados alfabéticamente.

---

## B

**BETWEEN**: Operador que filtra valores dentro de un rango inclusivo.
`BETWEEN a AND b` equivale a `>= a AND <= b`.

## C

**Comodín (wildcard)**: Carácter especial usado en `LIKE` para representar
uno o más caracteres. En SQL: `%` (cero o más) y `_` (exactamente uno).

## I

**IN**: Operador que comprueba si un valor pertenece a una lista de valores
posibles. Más legible que múltiples `OR`.

## L

**LIKE**: Operador para comparar texto con un patrón. Usa `%` y `_` como
comodines. En SQLite es case-insensitive para caracteres ASCII.

## N

**NOT BETWEEN**: Negación de `BETWEEN`. Devuelve filas fuera del rango.

**NOT IN**: Negación de `IN`. ⚠️ Devuelve 0 filas si la lista contiene `NULL`.

**NOT LIKE**: Negación de `LIKE`. Devuelve filas que no coinciden con el patrón.

## O

**Operador de comparación**: Símbolo que compara dos valores. SQL incluye:
`=`, `!=` (`<>`), `<`, `>`, `<=`, `>=`.

## P

**Patrón**: Cadena de texto que combina caracteres literales y comodines
para describir un conjunto de posibles valores de texto.

## R

**Rango**: Intervalo de valores delimitado por un mínimo y un máximo.
Se expresa en SQL con `BETWEEN`.
