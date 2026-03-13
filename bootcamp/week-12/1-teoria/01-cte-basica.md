# CTE básica: la cláusula WITH

## Objetivos

1. Definir qué es un CTE y cómo se escribe con la cláusula `WITH`
2. Reescribir una tabla derivada como CTE
3. Referenciar el CTE en la consulta principal

📊 Ver diagrama [0-assets/01-cte-estructura.svg](../0-assets/01-cte-estructura.svg)

---

## 1. ¿Qué es un CTE?

Un CTE (Common Table Expression) define un resultado con nombre que
existe solo durante la ejecución de la consulta. Se declara con `WITH`
antes del `SELECT` principal.

```sql
WITH nombre_cte AS (
    SELECT columna1, columna2
    FROM tabla
    WHERE condicion
)
SELECT columna1, columna2
FROM nombre_cte;
```

---

## 2. CTE vs tabla derivada

Ambos producen el mismo resultado, pero el CTE es más legible:

```sql
-- Tabla derivada (subquery en FROM)
SELECT first_name, salary
FROM (
    SELECT first_name, salary
    FROM employees
    WHERE is_active = 1
) AS activos;
```

```sql
-- CTE equivalente — más claro y reutilizable
WITH activos AS (
    SELECT first_name, salary
    FROM employees
    WHERE is_active = 1
)
SELECT first_name, salary
FROM activos;
```

---

## 3. CTE con JOIN en la consulta principal

El CTE se usa como cualquier tabla:

```sql
WITH empleados_activos AS (
    SELECT
        employee_id,
        first_name,
        last_name,
        department_id,
        salary
    FROM employees
    WHERE is_active = 1
)
SELECT
    e.first_name,
    e.last_name,
    d.name AS department_name
FROM empleados_activos e
INNER JOIN departments d ON e.department_id = d.id
ORDER BY d.name, e.last_name;
```

---

## 4. Reglas clave

- La cláusula `WITH` va antes del `SELECT` principal
- El nombre del CTE es libre, pero debe ser descriptivo
- La consulta principal **debe** referenciar el CTE
- El CTE no persiste más allá de la consulta

---

## Checklist

- [ ] ¿Puedo reescribir una tabla derivada como CTE?
- [ ] ¿El nombre del CTE describe su contenido?
- [ ] ¿La consulta principal referencia el CTE correctamente?
- [ ] ¿El CTE mejora la legibilidad respecto a la subquery?

## Referencias

- https://www.sqlite.org/lang_with.html
- https://www.postgresql.org/docs/current/queries-with.html
