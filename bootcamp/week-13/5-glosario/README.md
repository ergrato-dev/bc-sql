# Glosario — Semana 13: CTEs Recursivas

Términos SQL introducidos esta semana, ordenados alfabéticamente.

---

## A

**Adjacency list**
Modelo para representar jerarquías en SQL usando una columna `parent_id`
que apunta a otra fila de la misma tabla. Es el modelo más común y el que
se recorre con `WITH RECURSIVE`.

**Árbol (tree)**
Estructura de datos jerárquica donde cada nodo tiene exactamente un padre
(excepto la raíz) y puede tener cero o más hijos.

---

## C

**Caso base (base case)**
Primera parte del CTE recursivo. No referencia al propio CTE y devuelve
la semilla inicial de la recursión (usualmente la raíz del árbol).

**Caso recursivo (recursive case)**
Segunda parte del CTE recursivo. Referencia al propio CTE y extiende
el resultado añadiendo los hijos de cada fila ya procesada.

**CTE recursiva**
CTE definida con `WITH RECURSIVE` que contiene una auto-referencia.
Su resultado crece iterativamente hasta que la condición de parada se cumple.

**Ciclo (cycle)**
Error que ocurre cuando la recursión regresa a un nodo ya visitado.
En PostgreSQL 16 se puede detectar con la cláusula `CYCLE`.

---

## G

**generate_series()**
Función de PostgreSQL que genera una serie de valores numéricos,
fechas o timestamps. Alternativa más eficiente a un CTE recursivo de secuencia.

---

## H

**Hoja (leaf node)**
Nodo en un árbol sin hijos. En una tabla `nodes`, es una fila cuyo `id`
no aparece en ninguna columna `parent_id` de otra fila.

---

## N

**Nodo raíz (root node)**
Primer elemento de la jerarquía, sin padre. En una tabla auto-referencial
tiene `parent_id = NULL`.

---

## P

**path**
Columna calculada que concatena los nombres desde la raíz hasta el nodo
actual, separados por ` > `. Útil para ordenar y mostrar jerarquías.

**Profundidad (depth)**
Nivel de un nodo en el árbol. La raíz tiene `depth = 1`. Se incrementa
en cada iteración del caso recursivo con `depth + 1`.

---

## U

**UNION ALL**
Operador que une las filas del caso base y el caso recursivo sin eliminar
duplicados. En CTEs recursivas siempre se usa `UNION ALL`, nunca `UNION`.
