# Glosario — Semana 09: JOINs

Términos SQL introducidos esta semana, ordenados alfabéticamente.

---

## A

**Alias de tabla**
Nombre abreviado que se asigna a una tabla dentro de una consulta.
Mejora la legibilidad y es obligatorio cuando una tabla aparece más de una vez.
```sql
FROM employees e   -- 'e' es el alias
```

---

## C

**Cardinalidad**
Indica cuántos registros de una tabla pueden asociarse con registros de otra.
Valores comunes: 1:1, 1:N, N:M.

**CROSS JOIN**
Genera el producto cartesiano: combina cada fila de la tabla A con cada fila
de la tabla B. Produce `filas_A × filas_B` resultados. Usar con cuidado.

---

## F

**FULL OUTER JOIN**
Devuelve todas las filas de ambas tablas. Las filas sin coincidencia muestran
`NULL` en las columnas de la otra tabla. Requiere SQLite ≥ 3.39.0.

---

## H

**Huérfano (fila huérfana)**
Registro en la tabla padre que no tiene ninguna fila relacionada en la tabla
hija. Se detecta con `LEFT JOIN ... WHERE hijo.id IS NULL`.

---

## I

**INNER JOIN**
Devuelve solo las filas que tienen coincidencia en ambas tablas según la
condición `ON`. Es el tipo de JOIN más común.

---

## J

**JOIN**
Operación SQL que combina filas de dos o más tablas basándose en una columna
relacionada (generalmente una clave foránea).

---

## L

**LEFT JOIN** (LEFT OUTER JOIN)
Devuelve todas las filas de la tabla izquierda y las filas coincidentes de la
tabla derecha. Si no hay coincidencia, las columnas derechas son `NULL`.

---

## P

**Producto cartesiano**
Resultado de combinar cada fila de una tabla con cada fila de otra sin
ninguna condición de unión. Generado por CROSS JOIN o por un JOIN sin cláusula ON.

---

## R

**RIGHT JOIN** (RIGHT OUTER JOIN)
Devuelve todas las filas de la tabla derecha y las filas coincidentes de la
tabla izquierda. Puede reescribirse siempre como un LEFT JOIN. Requiere
SQLite ≥ 3.39.0.

---

## T

**Tabla izquierda / derecha**
En un JOIN, la "tabla izquierda" es la que aparece antes de la palabra `JOIN`
y la "tabla derecha" es la que aparece después.
