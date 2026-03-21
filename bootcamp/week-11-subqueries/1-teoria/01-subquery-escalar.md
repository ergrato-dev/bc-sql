# Subquery Escalar

## Objetivo

Al terminar esta sección, podrás:

- Definir qué es una subquery escalar y dónde usarla
- Comparar un valor contra el resultado de una subquery
- Escribir subqueries en `SELECT`, `WHERE` y `HAVING`

## Diagrama

→ [Anidamiento de subqueries](../0-assets/01-subquery-anidamiento.svg)

---

## 1. ¿Qué es una subquery?

Una subquery (subconsulta) es una consulta `SELECT` anidada dentro de otra.
La consulta exterior usa el resultado de la interior.

```sql
SELECT first_name
FROM employees
WHERE salary > (SELECT AVG(salary) FROM employees);
```

La subquery `(SELECT AVG(salary) FROM employees)` devuelve un solo número.
La consulta exterior filtra con ese número.

---

## 2. Subquery en WHERE

Compara una columna contra un valor calculado dinámicamente:

```sql
-- Empleados con sueldo mayor al máximo de Marketing
SELECT
    first_name,
    salary
FROM employees
WHERE salary > (
    SELECT MAX(e2.salary)
    FROM employees   e2
    INNER JOIN departments d ON e2.department_id = d.id
    WHERE d.name = 'Marketing'
);
```

---

## 3. Subquery en SELECT

Agrega una columna calculada globalmente a cada fila:

```sql
SELECT
    first_name,
    salary,
    (SELECT AVG(salary) FROM employees) AS company_avg
FROM employees;
```

---

## 4. Subquery correlacionada

Referencia columnas de la consulta exterior. Se ejecuta una vez por fila:

```sql
-- Empleados que ganan más que el promedio de su propio departamento
SELECT first_name, salary, department_id
FROM employees e
WHERE salary > (
    SELECT AVG(e2.salary)
    FROM employees e2
    WHERE e2.department_id = e.department_id
);
```

---

## Checklist

- [ ] ¿Una subquery escalar siempre devuelve exactamente una fila y una columna?
- [ ] ¿Sabes dónde colocar los paréntesis de la subquery?
- [ ] ¿Entiendes la diferencia entre subquery independiente y correlacionada?
- [ ] ¿Puedes reescribir el ejemplo como JOIN?

## Referencias

- https://www.sqlite.org/lang_select.html
- https://www.postgresql.org/docs/current/functions-subquery.html
