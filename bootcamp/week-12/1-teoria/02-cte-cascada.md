# CTEs en cascada

## Objetivos

1. Encadenar múltiples CTEs en una sola cláusula `WITH`
2. Referenciar un CTE anterior desde un CTE posterior
3. Construir pipelines de transformación de datos en pasos

📊 Ver diagrama [0-assets/01-cte-estructura.svg](../0-assets/01-cte-estructura.svg)

---

## 1. Sintaxis de CTEs múltiples

Se separan con coma dentro de la misma cláusula `WITH`:

```sql
WITH cte_uno AS (
    SELECT ...
    FROM tabla_a
),
cte_dos AS (
    SELECT ...
    FROM cte_uno         -- referencia al CTE anterior
    WHERE condicion
)
SELECT *
FROM cte_dos;
```

---

## 2. Pipeline de tres pasos

```sql
-- Paso 1: empleados activos de cada depto
WITH activos_por_depto AS (
    SELECT
        department_id,
        COUNT(*)       AS total_activos,
        AVG(salary)    AS avg_salary
    FROM employees
    WHERE is_active = 1
    GROUP BY department_id
),
-- Paso 2: deptos con promedio salarial alto
deptos_alto_sueldo AS (
    SELECT department_id
    FROM activos_por_depto
    WHERE avg_salary > 55000
)
-- Consulta final: nombres de empleados en esos deptos
SELECT
    e.first_name,
    e.last_name,
    e.salary
FROM employees e
WHERE e.department_id IN (
    SELECT department_id FROM deptos_alto_sueldo
)
ORDER BY e.salary DESC;
```

---

## 3. Cuándo usar CTEs en cascada

- El resultado de un paso intermedio se usa en el siguiente
- La lógica tiene pasos claramente distinguibles
- Un JOIN complejo necesita pre-filtrar datos primero

```sql
WITH sin_manager AS (
    SELECT employee_id, first_name
    FROM employees
    WHERE manager_id IS NULL
),
conteo AS (
    SELECT COUNT(*) AS total_sin_manager
    FROM sin_manager
)
SELECT total_sin_manager
FROM conteo;
```

---

## Checklist

- [ ] ¿Los CTEs están separados por coma dentro del mismo `WITH`?
- [ ] ¿Cada CTE tiene un nombre que describe su paso?
- [ ] ¿El orden de los CTEs es correcto (el anterior antes del que lo usa)?
- [ ] ¿La consulta principal referencia el último CTE del pipeline?

## Referencias

- https://www.sqlite.org/lang_with.html
- https://mode.com/sql-tutorial/sql-with-as/
