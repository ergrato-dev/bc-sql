# Glosario — Semana 10: CROSS JOIN y SELF JOIN

Términos SQL introducidos esta semana, ordenados alfabéticamente.

---

## A

**Alias semántico**
Alias que comunica el rol de la tabla en el query.
En un SELF JOIN: `e` para employee y `m` para manager es más claro que `a` y `b`.

**Auto-referencial (columna)**
Columna de clave foránea que apunta a la clave primaria de la misma tabla.
Permite representar jerarquías padre-hijo dentro de una sola tabla.

```sql
manager_id INTEGER REFERENCES employees (id)
```

---

## C

**CROSS JOIN**
Tipo de JOIN que genera el producto cartesiano de dos tablas: cada fila de A
combinada con cada fila de B. No requiere cláusula `ON`.
Produce `filas_A × filas_B` resultados.

---

## H

**Hijo (nodo hijo)**
En una jerarquía, registro que tiene una referencia a un registro padre.
El campo `parent_id` (o `manager_id`) contiene el `id` del padre.

---

## J

**Jerarquía (datos jerárquicos)**
Estructura de datos donde los registros tienen una relación padre-hijo.
Se modela en SQL con una columna auto-referencial.

---

## N

**Nivel jerárquico**
Profundidad de un nodo en el árbol. El nodo raíz está en nivel 0;
sus hijos en nivel 1; los nietos en nivel 2, etc.

---

## P

**Padre (nodo padre)**
En una jerarquía, registro que es referenciado por uno o más registros hijos.
El nodo raíz es el padre sin padre (`parent_id = NULL`).

**Producto cartesiano**
Operación matemática que combina cada elemento de un conjunto con cada
elemento de otro. En SQL es el resultado de un CROSS JOIN.

---

## R

**Raíz (nodo raíz)**
El registro de más alto nivel en una jerarquía. Tiene `parent_id = NULL`
porque no tiene padre. Ejemplo: el CEO en un organigrama.

---

## S

**SELF JOIN**
JOIN en el que una tabla se une consigo misma. Requiere dos aliases distintos
para que SQL pueda distinguir los dos "roles" de la tabla.
