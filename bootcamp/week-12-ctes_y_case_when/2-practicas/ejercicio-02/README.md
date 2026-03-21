# Ejercicio 02 — CASE WHEN y CTEs combinados

## Objetivo

Aplicar `CASE WHEN` para clasificar filas en categorías y combinar esta
técnica con CTEs para construir reportes analíticos claros.

## Esquema disponible

Tablas: `locations`, `departments`, `employees` (mismo setup que ejercicio 01)

---

## Paso 1: CASE WHEN simple — banda salarial

Clasifica cada empleado en `'Alto'`, `'Medio'` o `'Bajo'`:

```sql
SELECT
    first_name,
    last_name,
    salary,
    CASE
        WHEN salary >= 70000 THEN 'Alto'
        WHEN salary >= 50000 THEN 'Medio'
        ELSE                      'Bajo'
    END AS salary_band
FROM employees
WHERE is_active = 1
ORDER BY salary DESC;
```

**Abre `starter/ejercicio.sql`** y descomenta la sección **PASO 1**.

---

## Paso 2: CASE simple (igualdad de columna)

Traduce el `department_id` a nombre usando `CASE` simple:

```sql
SELECT
    first_name,
    CASE department_id
        WHEN 1 THEN 'Tech'
        WHEN 2 THEN 'Mkt'
        WHEN 3 THEN 'HR'
        ELSE        'Otro'
    END AS dept_short
FROM employees
ORDER BY department_id;
```

**Descomenta la sección PASO 2.**

---

## Paso 3: CASE WHEN con agregación condicional

Cuenta empleados por categoría salarial dentro de cada depto:

```sql
SELECT
    department_id,
    COUNT(*)                                        AS total,
    COUNT(CASE WHEN salary >= 70000 THEN 1 END)     AS high_earners,
    COUNT(CASE WHEN salary BETWEEN 50000 AND 69999 THEN 1 END) AS mid_earners,
    COUNT(CASE WHEN salary < 50000 THEN 1 END)      AS low_earners
FROM employees
WHERE is_active = 1
GROUP BY department_id
ORDER BY department_id;
```

**Descomenta la sección PASO 3.**

---

## Paso 4: CTE con CASE WHEN — reporte completo

El CTE clasifica; la consulta principal agrupa por banda:

```sql
WITH clasificados AS (
    SELECT
        e.first_name,
        e.salary,
        d.name AS department_name,
        CASE
            WHEN e.salary >= 70000 THEN 'Alto'
            WHEN e.salary >= 50000 THEN 'Medio'
            ELSE                        'Bajo'
        END AS salary_band
    FROM employees e
    INNER JOIN departments d ON e.department_id = d.id
    WHERE e.is_active = 1
)
SELECT
    salary_band,
    COUNT(*)             AS total,
    ROUND(AVG(salary), 2) AS avg_salary
FROM clasificados
GROUP BY salary_band
ORDER BY avg_salary DESC;
```

**Descomenta la sección PASO 4.**
