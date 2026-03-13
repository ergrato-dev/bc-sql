# Ejercicio 02 — FIRST_VALUE, LAST_VALUE y CREATE VIEW

## Objetivo

Usar `FIRST_VALUE()` y `LAST_VALUE()` correctamente con frame clause,
y encapsular la consulta en una **vista** reutilizable.

## Cómo ejecutar

```bash
docker compose -f _scripts/docker-compose.yml exec -T postgres \
  psql -U bootcamp -d bootcamp_db < starter/setup.sql
docker compose -f _scripts/docker-compose.yml exec postgres \
  psql -U bootcamp -d bootcamp_db -f /dev/stdin < starter/ejercicio.sql
```

## Esquema disponible

Reutiliza el esquema del ejercicio 01 (`monthly_sales` + `departments`).

---

## Paso 1: FIRST_VALUE por departamento

El mayor monto histórico de cada departamento aparece en cada fila:

```sql
SELECT
    sale_month,
    department_id,
    amount,
    FIRST_VALUE(amount) OVER (
        PARTITION BY department_id
        ORDER BY amount DESC
    ) AS dept_best
FROM monthly_sales
ORDER BY department_id, sale_month;
```

**Abre `starter/ejercicio.sql`** y descomenta la sección **PASO 1**.

---

## Paso 2: LAST_VALUE con frame extendido

Sin el frame clause correcto, LAST_VALUE devuelve el valor actual:

```sql
SELECT
    sale_month,
    department_id,
    amount,
    LAST_VALUE(amount) OVER (
        PARTITION BY department_id
        ORDER BY amount DESC
        ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
    ) AS dept_worst
FROM monthly_sales
ORDER BY department_id, sale_month;
```

**Descomenta la sección PASO 2.**

---

## Paso 3: Alias de ventana con WINDOW

Evita repetir la definición usando `WINDOW w AS (...)`:

```sql
SELECT
    sale_month,
    department_id,
    amount,
    FIRST_VALUE(amount) OVER w AS dept_best,
    LAST_VALUE(amount)  OVER w AS dept_worst
FROM monthly_sales
WINDOW w AS (
    PARTITION BY department_id
    ORDER BY amount DESC
    ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
)
ORDER BY department_id, sale_month;
```

**Descomenta la sección PASO 3.**

---

## Paso 4: CREATE VIEW y consulta a la vista

Guarda la consulta del paso 3 como vista y filtra desde ella:

```sql
CREATE OR REPLACE VIEW v_dept_sales_analysis AS
SELECT
    sale_month,
    department_id,
    amount,
    FIRST_VALUE(amount) OVER w AS dept_best,
    LAST_VALUE(amount)  OVER w AS dept_worst
FROM monthly_sales
WINDOW w AS (
    PARTITION BY department_id
    ORDER BY amount DESC
    ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
);

-- Consultar la vista como si fuera una tabla
SELECT *
FROM v_dept_sales_analysis
WHERE department_id = 1
ORDER BY sale_month;
```

**Descomenta la sección PASO 4.**
