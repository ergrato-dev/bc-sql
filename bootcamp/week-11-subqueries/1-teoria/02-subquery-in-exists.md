# IN, NOT IN, EXISTS, NOT EXISTS

## Objetivo

Al terminar esta sección, podrás:

- Filtrar filas usando `IN` con una subquery de una columna
- Excluir filas con `NOT IN` y entender la trampa del NULL
- Detectar la existencia de filas relacionadas con `EXISTS`

## Diagrama

→ [Anidamiento de subqueries](../0-assets/01-subquery-anidamiento.svg)

---

## 1. IN con subquery

`IN` verifica si un valor aparece en la lista retornada por la subquery:

```sql
-- Empleados que pertenecen a un departamento activo
SELECT first_name
FROM employees
WHERE department_id IN (
    SELECT id
    FROM departments
    WHERE is_active = 1
);
```

---

## 2. NOT IN — Trampa con NULL

Si la subquery retorna algún `NULL`, `NOT IN` nunca devuelve filas.
Siempre agregar `WHERE col IS NOT NULL`:

```sql
-- ❌ Riesgo: si hay department_id NULL en la subquery, resultado vacío
SELECT first_name FROM employees
WHERE department_id NOT IN (SELECT id FROM departments);

-- ✅ Seguro
SELECT first_name FROM employees
WHERE department_id NOT IN (
    SELECT id FROM departments WHERE id IS NOT NULL
);
```

---

## 3. EXISTS y NOT EXISTS

`EXISTS` es `TRUE` si la subquery retorna al menos una fila.
La subquery suele correlacionarse con la consulta exterior:

```sql
-- Departamentos que tienen al menos un empleado activo
SELECT name
FROM departments d
WHERE EXISTS (
    SELECT 1
    FROM employees e
    WHERE e.department_id = d.id
      AND e.is_active = 1
);
```

`SELECT 1` es idiomático: no importa qué columna retorne, solo si hay filas.

---

## 4. NOT EXISTS

Detecta registros sin filas relacionadas (alternativa segura a NOT IN):

```sql
-- Departamentos SIN empleados
SELECT name
FROM departments d
WHERE NOT EXISTS (
    SELECT 1
    FROM employees e
    WHERE e.department_id = d.id
);
```

---

## Checklist

- [ ] ¿Sabes cuándo `NOT IN` puede devolver un resultado vacío inesperado?
- [ ] ¿Por qué `SELECT 1` dentro de EXISTS es suficiente?
- [ ] ¿Cuándo preferirías EXISTS en lugar de IN?
- [ ] ¿Puedes escribir `NOT EXISTS` para reemplazar un LEFT JOIN con NULL?

## Referencias

- https://www.sqlite.org/lang_expr.html#in_op
- https://www.postgresql.org/docs/current/functions-subquery.html
