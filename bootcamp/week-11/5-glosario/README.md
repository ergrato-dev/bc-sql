# Glosario — Semana 11: Subqueries

Términos SQL introducidos esta semana, ordenados alfabéticamente.

---

## C

**Consulta correlacionada (correlated subquery)**
Subquery que referencia columnas de la consulta exterior. Se ejecuta una vez
por cada fila de la consulta exterior, lo cual puede afectar el rendimiento.

```sql
WHERE salary > (SELECT AVG(e2.salary)
                FROM employees e2
                WHERE e2.department_id = e.department_id)
```

---

## E

**EXISTS**
Operador que retorna `TRUE` si la subquery devuelve al menos una fila.
Se usa normalmente con subqueries correlacionadas. `SELECT 1` es el patrón idiomático.

---

## I

**IN**
Operador que verifica si un valor pertenece a la lista retornada por una subquery.
```sql
WHERE id IN (SELECT department_id FROM employees WHERE is_active = 1)
```

---

## N

**NOT EXISTS**
Complemento de `EXISTS`. Retorna `TRUE` cuando la subquery **no** devuelve filas.
Alternativa segura a `NOT IN` porque no tiene el problema del NULL.

**NOT IN**
Complemento de `IN`. Si la subquery retorna algún `NULL`, el resultado completo
es siempre vacío. Siempre agregar `AND col IS NOT NULL` en la subquery.

---

## S

**Subquery (subconsulta)**
Consulta `SELECT` anidada dentro de otra consulta. La consulta exterior usa
el resultado de la interior.

**Subquery escalar**
Subquery que retorna exactamente **una fila y una columna**. Se puede usar
en `SELECT`, `WHERE` o `HAVING` donde se espera un único valor.

---

## T

**Tabla derivada**
Subquery en la cláusula `FROM` que actúa como tabla temporal durante la
ejecución. Requiere un alias obligatorio para poder referenciar sus columnas.

```sql
FROM (SELECT ... FROM ... GROUP BY ...) AS alias_obligatorio
```

---

## V

**Vista inline**
Otro nombre para la tabla derivada. La diferencia con una vista real
(`CREATE VIEW`) es que existe solo durante la ejecución de la consulta.
