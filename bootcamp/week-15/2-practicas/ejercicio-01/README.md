# Ejercicio 01 — LEAD y LAG para comparar filas

## Objetivo

Usar `LAG()` y `LEAD()` para acceder a filas anteriores/siguientes
y calcular diferencias entre periodos consecutivos.

## Cómo ejecutar

```bash
docker compose -f _scripts/docker-compose.yml exec -T postgres \
  psql -U bootcamp -d bootcamp_db < starter/setup.sql
docker compose -f _scripts/docker-compose.yml exec postgres \
  psql -U bootcamp -d bootcamp_db -f /dev/stdin < starter/ejercicio.sql
```

## Esquema disponible

Tabla: `monthly_sales(id, sale_month DATE, department_id INT, amount NUMERIC)`

---

## Paso 1: LAG — acceder al mes anterior

```sql
SELECT
    sale_month,
    amount,
    LAG(amount, 1, 0) OVER (ORDER BY sale_month) AS prev_amount
FROM monthly_sales
ORDER BY sale_month;
```

**Abre `starter/ejercicio.sql`** y descomenta la sección **PASO 1**.

---

## Paso 2: Calcular la diferencia (delta)

```sql
SELECT
    sale_month,
    amount,
    LAG(amount, 1, 0) OVER (ORDER BY sale_month)           AS prev_amount,
    amount - LAG(amount, 1, 0) OVER (ORDER BY sale_month)  AS delta
FROM monthly_sales
ORDER BY sale_month;
```

**Descomenta la sección PASO 2.**

---

## Paso 3: LAG por departamento (PARTITION BY)

```sql
SELECT
    sale_month,
    department_id,
    amount,
    LAG(amount, 1, 0) OVER (
        PARTITION BY department_id
        ORDER BY sale_month
    ) AS prev_dept_amount
FROM monthly_sales
ORDER BY department_id, sale_month;
```

**Descomenta la sección PASO 3.**

---

## Paso 4: LEAD — ver el siguiente mes

```sql
SELECT
    sale_month,
    amount,
    LEAD(amount, 1, NULL) OVER (ORDER BY sale_month) AS next_amount
FROM monthly_sales
ORDER BY sale_month;
```

**Descomenta la sección PASO 4.**
