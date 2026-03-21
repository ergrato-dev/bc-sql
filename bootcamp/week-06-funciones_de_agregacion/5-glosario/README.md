# Glosario — Semana 06: Agregación

Términos clave de la semana ordenados alfabéticamente.

---

## A

**Agregación**: Operación que combina múltiples filas en un único valor
resumen. Ejemplo: `SUM(salary)` suma todos los salarios en un número.

**AVG()**: Función de agregación que calcula el valor promedio de una
columna numérica, ignorando `NULL`.

## C

**COUNT(*)**: Cuenta todas las filas del resultado, incluyendo las que
tienen `NULL` en cualquier columna.

**COUNT(columna)**: Cuenta las filas donde esa columna no es `NULL`.

## G

**GROUP BY**: Cláusula que agrupa filas con el mismo valor en la(s)
columna(s) indicada(s), permitiendo calcular funciones de agregación por grupo.

## H

**HAVING**: Cláusula que filtra grupos después de la agregación.
Equivale a un `WHERE` aplicado al resultado del `GROUP BY`.

## M

**MAX()**: Devuelve el mayor valor de una columna.

**MIN()**: Devuelve el menor valor de una columna.

## R

**ROUND(x, n)**: Función que redondea `x` a `n` decimales. Útil para
presentar promedios monetarios.

## S

**SUM()**: Función de agregación que suma todos los valores no `NULL`
de una columna numérica.

## W

**WHERE vs HAVING**: `WHERE` filtra filas individuales antes de agrupar;
`HAVING` filtra grupos después de agregar. No son intercambiables.
