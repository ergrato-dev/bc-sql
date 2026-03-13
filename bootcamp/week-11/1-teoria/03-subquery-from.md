# Subquery en FROM — Tabla Derivada

## Objetivo

Al terminar esta sección, podrás:

- Usar una subquery en la cláusula `FROM` como tabla derivada
- Agregar un alias obligatorio a la subquery
- Combinar tablas derivadas con JOINs externos

## Diagrama

→ [Subquery en FROM vs JOIN](../0-assets/02-subquery-from.svg)

---

## 1. ¿Qué es una tabla derivada?

Una subquery en `FROM` actúa como una tabla temporal sin nombre con un alias:

```sql
SELECT dept_stats.department, dept_stats.avg_salary
FROM (
    SELECT
        d.name      AS department,
        AVG(e.salary) AS avg_salary
    FROM employees   e
    INNER JOIN departments d ON e.department_id = d.id
    GROUP BY d.name
) AS dept_stats        -- alias OBLIGATORIO
WHERE dept_stats.avg_salary > 60000;
```

La tabla derivada `dept_stats` existe solo durante la ejecución de la query.

---

## 2. Por qué es necesario el alias

Sin alias SQLite lanza un error. El alias permite referenciar columnas
de la subquery en el `SELECT` y `WHERE` externos:

```sql
-- ❌ Error: subquery en FROM sin alias
SELECT * FROM (SELECT id FROM employees);

-- ✅ Correcto
SELECT * FROM (SELECT id FROM employees) AS sub;
```

---

## 3. JOIN con tabla derivada

Las tablas derivadas se pueden combinar con tablas reales:

```sql
SELECT
    e.first_name,
    e.salary,
    dept_avg.avg_salary
FROM employees e
INNER JOIN (
    SELECT
        department_id,
        AVG(salary) AS avg_salary
    FROM employees
    GROUP BY department_id
) AS dept_avg ON e.department_id = dept_avg.department_id;
```

---

## 4. Subquery vs CTE

La misma lógica puede escribirse como CTE (`WITH`) en semana 12.
Las CTEs son más legibles para subqueries reutilizadas o encadenadas.

---

## Checklist

- [ ] ¿Siempre agregas alias a la subquery en FROM?
- [ ] ¿Puedes referenciar columnas de la tabla derivada en el WHERE externo?
- [ ] ¿Entiendes por qué la tabla derivada desaparece tras la ejecución?
- [ ] ¿Sabes cuándo preferir CTE sobre tabla derivada?

## Referencias

- https://www.sqlite.org/lang_select.html#fromclause
- https://mode.com/sql-tutorial/sql-subqueries/
