# Ejercicio 02 — Generación de secuencias

## Objetivo

Usar CTEs recursivas para generar series numéricas y de fechas,
y combinarlas con `LEFT JOIN` para detectar períodos sin actividad.

## Cómo ejecutar

```bash
docker compose -f _scripts/docker-compose.yml exec -T postgres \
  psql -U bootcamp -d bootcamp_db < starter/setup.sql
docker compose -f _scripts/docker-compose.yml exec postgres \
  psql -U bootcamp -d bootcamp_db -f /dev/stdin < starter/ejercicio.sql
```

## Esquema disponible

Tabla `daily_sales` con ventas por fecha (no todas las fechas tienen registro).

---

## Paso 1: Serie numérica del 1 al 10

```sql
WITH RECURSIVE serie AS (
    SELECT 1 AS n
    UNION ALL
    SELECT n + 1
    FROM serie
    WHERE n < 10
)
SELECT n FROM serie;
```

**Abre `starter/ejercicio.sql`** y descomenta la sección **PASO 1**.

---

## Paso 2: Serie de fechas — enero 2024

```sql
WITH RECURSIVE calendario AS (
    SELECT CAST('2024-01-01' AS DATE) AS dia
    UNION ALL
    SELECT dia + INTERVAL '1 day'
    FROM calendario
    WHERE dia < '2024-01-07'
)
SELECT dia FROM calendario;
```

**Descomenta la sección PASO 2.**

---

## Paso 3: Calendario con ventas (LEFT JOIN)

Muestra todos los días de la semana, incluso los que no tienen ventas:

```sql
WITH RECURSIVE calendario AS (
    SELECT CAST('2024-01-01' AS DATE) AS dia
    UNION ALL
    SELECT dia + INTERVAL '1 day'
    FROM calendario
    WHERE dia < '2024-01-07'
)
SELECT
    c.dia                           AS fecha,
    COALESCE(SUM(s.amount), 0)      AS total_ventas,
    COALESCE(COUNT(s.id), 0)        AS num_transacciones
FROM calendario c
LEFT JOIN daily_sales s ON s.sale_date = c.dia
GROUP BY c.dia
ORDER BY c.dia;
```

**Descomenta la sección PASO 3.**

---

## Paso 4: generate_series() — alternativa PostgreSQL

```sql
SELECT
    gs.dia::DATE                    AS fecha,
    COALESCE(SUM(s.amount), 0)      AS total_ventas
FROM generate_series(
    '2024-01-01'::DATE,
    '2024-01-07'::DATE,
    '1 day'::INTERVAL
) AS gs(dia)
LEFT JOIN daily_sales s ON s.sale_date = gs.dia::DATE
GROUP BY gs.dia
ORDER BY gs.dia;
```

**Descomenta la sección PASO 4.**
