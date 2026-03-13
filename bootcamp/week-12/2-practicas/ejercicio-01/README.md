# Ejercicio 01 — CTEs simples y encadenados

## Objetivo

Practicar la escritura de CTEs con `WITH` para simplificar consultas
complejas, encadenando dos CTEs en un pipeline de transformación.

## Esquema disponible

Tablas: `locations`, `departments`, `employees`

---

## Paso 1: CTE simple — empleados activos

Un CTE que filtra solo empleados activos para reutilizarlo:

```sql
WITH activos AS (
    SELECT
        employee_id,
        first_name,
        last_name,
        salary,
        department_id
    FROM employees
    WHERE is_active = 1
)
SELECT first_name, last_name, salary
FROM activos
ORDER BY salary DESC;
```

**Abre `starter/ejercicio.sql`** y descomenta la sección **PASO 1**.

---

## Paso 2: CTE con JOIN en consulta principal

El CTE pre-filtra; el `JOIN` se hace en la consulta principal:

```sql
WITH activos AS (
    SELECT employee_id, first_name, salary, department_id
    FROM employees
    WHERE is_active = 1
)
SELECT
    a.first_name,
    d.name AS department_name,
    a.salary
FROM activos a
INNER JOIN departments d ON a.department_id = d.id
ORDER BY d.name, a.salary DESC;
```

**Descomenta la sección PASO 2.**

---

## Paso 3: Dos CTEs encadenados

El segundo CTE filtra datos del primero:

```sql
WITH promedios AS (
    SELECT
        department_id,
        AVG(salary) AS avg_sal
    FROM employees
    WHERE is_active = 1
    GROUP BY department_id
),
deptos_premium AS (
    SELECT department_id
    FROM promedios
    WHERE avg_sal > 55000
)
SELECT
    e.first_name,
    e.salary
FROM employees e
WHERE e.department_id IN (SELECT department_id FROM deptos_premium)
ORDER BY e.salary DESC;
```

**Descomenta la sección PASO 3.**

---

## Paso 4: CTE que resume, consulta que filtra

Construye métricas en el CTE y aplica un umbral en la consulta principal:

```sql
WITH resumen_depto AS (
    SELECT
        d.name AS department_name,
        COUNT(e.employee_id) AS total_employees,
        ROUND(AVG(e.salary), 2) AS avg_salary
    FROM departments d
    LEFT JOIN employees e ON e.department_id = d.id
    GROUP BY d.id, d.name
)
SELECT department_name, total_employees, avg_salary
FROM resumen_depto
WHERE total_employees >= 2
ORDER BY avg_salary DESC;
```

**Descomenta la sección PASO 4.**
