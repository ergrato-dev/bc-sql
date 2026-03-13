# Ejercicio 02 — DENSE_RANK y Top-N por grupo

## Objetivo

Combinar `DENSE_RANK()` con CTEs para obtener los **N mejores registros
por grupo** — patrón fundamental en análisis de datos.

## Cómo ejecutar

```bash
docker compose -f _scripts/docker-compose.yml exec -T postgres \
  psql -U bootcamp -d bootcamp_db < starter/setup.sql
docker compose -f _scripts/docker-compose.yml exec postgres \
  psql -U bootcamp -d bootcamp_db -f /dev/stdin < starter/ejercicio.sql
```

## Esquema disponible

Reutiliza el esquema del ejercicio 01. Vuelve a ejecutar `setup.sql` si
limpiaste la base.

---

## Paso 1: DENSE_RANK() por departamento

Clasifica empleados dentro de su departamento con DENSE_RANK:

```sql
SELECT
    first_name,
    department_id,
    salary,
    DENSE_RANK() OVER (
        PARTITION BY department_id
        ORDER BY salary DESC
    ) AS dept_rank
FROM employees
ORDER BY department_id, salary DESC;
```

**Abre `starter/ejercicio.sql`** y descomenta la sección **PASO 1**.

---

## Paso 2: El empleado de mayor salario por departamento

Usa CTE + `WHERE dept_rank = 1` para filtrar solo el #1 de cada área:

```sql
WITH ranked AS (
    SELECT
        first_name,
        department_id,
        salary,
        DENSE_RANK() OVER (
            PARTITION BY department_id
            ORDER BY salary DESC
        ) AS dept_rank
    FROM employees
)
SELECT first_name, department_id, salary
FROM ranked
WHERE dept_rank = 1;
```

**Descomenta la sección PASO 2.**

---

## Paso 3: Top-2 por departamento

Cambia el filtro a `dept_rank <= 2` para los dos mejores:

```sql
WITH ranked AS (
    SELECT
        first_name,
        department_id,
        salary,
        DENSE_RANK() OVER (
            PARTITION BY department_id
            ORDER BY salary DESC
        ) AS dept_rank
    FROM employees
)
SELECT first_name, department_id, salary, dept_rank
FROM ranked
WHERE dept_rank <= 2
ORDER BY department_id, dept_rank;
```

**Descomenta la sección PASO 3.**

---

## Paso 4: Top-3 global de la empresa

Sin PARTITION BY, el ranking es global. Filtra los 3 mejores:

```sql
WITH global_ranked AS (
    SELECT
        first_name,
        salary,
        DENSE_RANK() OVER (ORDER BY salary DESC) AS company_rank
    FROM employees
)
SELECT first_name, salary, company_rank
FROM global_ranked
WHERE company_rank <= 3
ORDER BY company_rank;
```

**Descomenta la sección PASO 4.**
