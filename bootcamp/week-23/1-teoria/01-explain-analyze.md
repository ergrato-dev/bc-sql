# 1. EXPLAIN y EXPLAIN ANALYZE

## Objetivo

Leer la salida de `EXPLAIN` y `EXPLAIN ANALYZE` para entender cómo
PostgreSQL ejecuta una consulta.

> Referencia: https://www.postgresql.org/docs/16/using-explain.html

---

## 1. Diferencia entre EXPLAIN y EXPLAIN ANALYZE

`EXPLAIN` muestra el plan estimado sin ejecutar la query.
`EXPLAIN ANALYZE` ejecuta la query y muestra tiempos reales.

```sql
-- Muestra plan estimado (no ejecuta)
EXPLAIN SELECT * FROM orders WHERE customer_id = 42;

-- Ejecuta y muestra tiempos reales
EXPLAIN ANALYZE SELECT * FROM orders WHERE customer_id = 42;
```

> Usar `EXPLAIN ANALYZE` con precaución en tablas de producción
> con UPDATE o DELETE — sí modifica datos.

---

## 2. Anatomía del plan de ejecución

```
Seq Scan on orders  (cost=0.00..12.50 rows=250 width=64)
                          ^      ^      ^       ^
                      costo   costo  filas   bytes
                      inicio  total  estim.  por fila
                                            
  Filter: (customer_id = 42)
  Rows Removed by Filter: 750
  Actual time=0.012..0.430 rows=12 loops=1
```

| Campo | Significado |
|-------|-------------|
| `cost=0.00..12.50` | Costo estimado de inicio..total |
| `rows=250` | Filas estimadas |
| `Actual time` | Tiempo real de inicio..total en ms |
| `rows=12` | Filas reales retornadas |

---

## 3. Visualizar con EXPLAIN (ANALYZE, BUFFERS)

```sql
EXPLAIN (ANALYZE, BUFFERS)
SELECT o.id, c.name
FROM orders o
JOIN customers c ON o.customer_id = c.id
WHERE o.status = 'pending';
```

---

## 4. Checklist

- ¿Qué diferencia hay entre cost estimado y tiempo real?
- ¿Qué significa `Rows Removed by Filter`?
- ¿Por qué `EXPLAIN` no modifica datos pero `EXPLAIN ANALYZE` sí?
- ¿Qué indica un costo alto en un nodo del plan?

---

## Referencias

- https://www.postgresql.org/docs/16/using-explain.html
- https://www.postgresql.org/docs/16/sql-explain.html
