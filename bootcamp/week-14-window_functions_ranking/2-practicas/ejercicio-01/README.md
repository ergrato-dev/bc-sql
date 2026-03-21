# Ejercicio 01 — ROW_NUMBER y RANK básicos

## Objetivo

Practicar `ROW_NUMBER()` y `RANK()` con `OVER(PARTITION BY ... ORDER BY ...)`
para numerar y clasificar filas dentro de grupos.

## Cómo ejecutar

```bash
docker compose -f _scripts/docker-compose.yml exec -T postgres \
  psql -U bootcamp -d bootcamp_db < starter/setup.sql
docker compose -f _scripts/docker-compose.yml exec postgres \
  psql -U bootcamp -d bootcamp_db -f /dev/stdin < starter/ejercicio.sql
```

## Esquema disponible

Tablas: `departments`, `employees`

---

## Paso 1: ROW_NUMBER() global sin PARTITION BY

Numera todos los empleados según su salario descendente:

```sql
SELECT
    first_name,
    salary,
    ROW_NUMBER() OVER (ORDER BY salary DESC) AS global_rank
FROM employees
ORDER BY salary DESC;
```

**Abre `starter/ejercicio.sql`** y descomenta la sección **PASO 1**.

---

## Paso 2: ROW_NUMBER() con PARTITION BY

La numeración reinicia para cada departamento:

```sql
SELECT
    first_name,
    department_id,
    salary,
    ROW_NUMBER() OVER (
        PARTITION BY department_id
        ORDER BY salary DESC
    ) AS dept_row_num
FROM employees
ORDER BY department_id, salary DESC;
```

**Descomenta la sección PASO 2.**

---

## Paso 3: RANK() con empates

Dos empleados con el mismo salario comparten rango:

```sql
SELECT
    first_name,
    salary,
    RANK() OVER (ORDER BY salary DESC)        AS rnk,
    ROW_NUMBER() OVER (ORDER BY salary DESC)  AS row_num
FROM employees
ORDER BY salary DESC;
```

**Descomenta la sección PASO 3.**

---

## Paso 4: Las tres funciones en paralelo

Compara las tres funciones en la misma consulta:

```sql
SELECT
    first_name,
    salary,
    ROW_NUMBER() OVER (ORDER BY salary DESC) AS row_num,
    RANK()       OVER (ORDER BY salary DESC) AS rnk,
    DENSE_RANK() OVER (ORDER BY salary DESC) AS dense_rnk
FROM employees
ORDER BY salary DESC;
```

**Descomenta la sección PASO 4.**
