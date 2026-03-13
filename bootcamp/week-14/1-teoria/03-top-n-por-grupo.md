# Filtrar top-N por grupo con CTE

## Objetivos

1. Entender por qué no se puede filtrar por una window function en el mismo `SELECT`
2. Usar un CTE para calcular el ranking y luego filtrar en la consulta exterior
3. Aplicar el patrón top-N por grupo en casos reales

---

## 1. El problema: no se puede filtrar en el mismo nivel

```sql
-- ❌ ERROR: no se puede usar alias de window function en WHERE
SELECT
    first_name,
    salary,
    ROW_NUMBER() OVER (PARTITION BY department_id ORDER BY salary DESC) AS rn
FROM employees
WHERE rn = 1;   -- ERROR: column "rn" does not exist
```

---

## 2. Solución: CTE + WHERE en la consulta exterior

```sql
-- ✅ CORRECTO: calcular el ranking en CTE, filtrar afuera
WITH ranked AS (
    SELECT
        first_name,
        department_id,
        salary,
        ROW_NUMBER() OVER (
            PARTITION BY department_id
            ORDER BY salary DESC
        ) AS rn
    FROM employees
)
SELECT first_name, department_id, salary
FROM ranked
WHERE rn = 1
ORDER BY department_id;
```

---

## 3. Top-3 por departamento con DENSE_RANK

```sql
WITH ranked AS (
    SELECT
        e.first_name,
        d.name           AS department_name,
        e.salary,
        DENSE_RANK() OVER (
            PARTITION BY e.department_id
            ORDER BY e.salary DESC
        ) AS salary_rank
    FROM employees e
    INNER JOIN departments d ON e.department_id = d.id
)
SELECT first_name, department_name, salary, salary_rank
FROM ranked
WHERE salary_rank <= 3
ORDER BY department_name, salary_rank;
```

---

## 4. Eliminar duplicados con ROW_NUMBER

```sql
-- Mantener solo la fila más reciente por empleado
WITH deduped AS (
    SELECT
        employee_id,
        first_name,
        updated_at,
        ROW_NUMBER() OVER (
            PARTITION BY employee_id
            ORDER BY updated_at DESC
        ) AS rn
    FROM employee_history
)
SELECT employee_id, first_name, updated_at
FROM deduped
WHERE rn = 1;
```

---

## Checklist

- [ ] ¿Sé por qué no puedo usar `WHERE rn = 1` en el mismo `SELECT`?
- [ ] ¿El CTE calcula el ranking y la consulta exterior lo filtra?
- [ ] ¿`rn = 1` selecciona el top-1, `rn <= 3` selecciona el top-3?
- [ ] ¿`DENSE_RANK()` es mejor que `RANK()` para rankings contiguos?

## Referencias

- https://www.postgresql.org/docs/current/tutorial-window.html
- https://mode.com/sql-tutorial/sql-window-functions/
