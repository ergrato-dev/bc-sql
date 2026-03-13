# Generación de secuencias con CTEs recursivas

## Objetivos

1. Generar series numéricas sin tablas auxiliares
2. Generar rangos de fechas para análisis por período
3. Usar `generate_series()` de PostgreSQL como alternativa

> En **PostgreSQL** existe `generate_series()` que es más eficiente.
> El CTE recursivo es el método portable a cualquier motor SQL.

---

## 1. Serie numérica

```sql
-- Genera los números del 1 al 10
WITH RECURSIVE serie AS (
    SELECT 1 AS n
    UNION ALL
    SELECT n + 1
    FROM serie
    WHERE n < 10
)
SELECT n FROM serie;
```

---

## 2. Rango de fechas

```sql
-- Genera todos los días de enero 2024
WITH RECURSIVE dias AS (
    SELECT CAST('2024-01-01' AS DATE) AS dia
    UNION ALL
    SELECT dia + INTERVAL '1 day'
    FROM dias
    WHERE dia < '2024-01-31'
)
SELECT dia FROM dias;
```

---

## 3. Caso de uso: completar datos faltantes

Combinar la serie de fechas con datos reales para mostrar días sin ventas:

```sql
WITH RECURSIVE calendar AS (
    SELECT CAST('2024-01-01' AS DATE) AS sale_date
    UNION ALL
    SELECT sale_date + INTERVAL '1 day'
    FROM calendar
    WHERE sale_date < '2024-01-07'
)
SELECT
    c.sale_date,
    COALESCE(SUM(s.amount), 0) AS total_sales
FROM calendar c
LEFT JOIN sales s ON s.sale_date = c.sale_date
GROUP BY c.sale_date
ORDER BY c.sale_date;
```

---

## 4. generate_series() en PostgreSQL

En PostgreSQL 16 es más idiomático usar la función built-in:

```sql
-- Equivalente — más eficiente en PostgreSQL
SELECT generate_series(1, 10) AS n;

-- Serie de fechas
SELECT generate_series(
    '2024-01-01'::DATE,
    '2024-01-31'::DATE,
    '1 day'::INTERVAL
)::DATE AS dia;
```

---

## Checklist

- [ ] ¿El caso base inicializa el primer valor de la serie?
- [ ] ¿El caso recursivo incrementa el valor correctamente?
- [ ] ¿La condición `WHERE` acota la serie al rango deseado?
- [ ] ¿En PostgreSQL podría usar `generate_series()` en su lugar?

## Referencias

- https://www.postgresql.org/docs/current/functions-srf.html
- https://www.postgresql.org/docs/current/queries-with.html
