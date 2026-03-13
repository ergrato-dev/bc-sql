# 03 — LATERAL en la práctica

## Objetivos

1. Implementar el patrón "Top-N por grupo" con `LATERAL`.
2. Paginar resultados por grupo usando `OFFSET/LIMIT` en una subquery lateral.
3. Reconocer los casos donde `LATERAL` supera a `ROW_NUMBER()`.

---

## 1. Patrón Top-N por grupo

Obtener los 2 productos más vendidos de cada categoría:

```sql
-- Con window function (referencia semana 14)
SELECT category, product_name, total_sold
FROM (
    SELECT category, product_name, total_sold,
           ROW_NUMBER() OVER (
               PARTITION BY category ORDER BY total_sold DESC
           ) AS rn
    FROM sales_summary
) ranked
WHERE rn <= 2;

-- Con LATERAL (más directo cuando la fuente es una tabla grande)
SELECT c.category, top2.product_name, top2.total_sold
FROM categories c
JOIN LATERAL (
    SELECT product_name, total_sold
    FROM sales_summary
    WHERE sales_summary.category = c.category
    ORDER BY total_sold DESC
    LIMIT 2
) AS top2 ON TRUE;
```

---

## 2. Paginación por grupo con OFFSET

```sql
-- Página 2 (filas 3-4) de ventas por empleado
SELECT e.name, page.product_name, page.amount
FROM employees e
CROSS JOIN LATERAL (
    SELECT product_name, amount
    FROM sales
    WHERE employee_id = e.id
    ORDER BY amount DESC
    LIMIT 2 OFFSET 2
) AS page;
```

---

## 3. LATERAL con unnest()

`unnest()` es una función tabular integrada útil con `LATERAL`:

```sql
-- Expandir un array a filas con su índice original
SELECT u.id, elem.val, elem.pos
FROM users u
CROSS JOIN LATERAL
    unnest(u.tags) WITH ORDINALITY AS elem(val, pos);
```

---

## 4. Checklist

- ¿En qué escenarios `LATERAL` es más eficiente que `ROW_NUMBER()`?
- ¿Cómo aplico `OFFSET` dentro de una subquery lateral?
- ¿Qué hace `WITH ORDINALITY` en `unnest()`?
- ¿Puedo encadenar dos `LATERAL` en la misma cláusula `FROM`?

## Referencias

- https://www.postgresql.org/docs/16/functions-array.html
- https://use-the-index-luke.com/sql/partial-results/top-n-queries
