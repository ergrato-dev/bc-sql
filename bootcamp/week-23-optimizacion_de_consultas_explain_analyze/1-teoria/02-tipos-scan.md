# 2. Tipos de scan: Seq, Index y Index Only

## Objetivo

Distinguir cuándo PostgreSQL usa cada tipo de scan y cómo crear índices
que transformen un seq scan en un index scan.

> Referencia: https://www.postgresql.org/docs/16/indexes-types.html

---

## 1. Seq Scan

Lee toda la tabla fila por fila. Eficiente solo cuando se recuperan
la mayoría de las filas (>10-20% del total).

```sql
-- Sin índice sobre status → Seq Scan
EXPLAIN SELECT * FROM orders WHERE status = 'pending';
-- Seq Scan on orders  (cost=0.00..253.00 rows=800 width=64)
--   Filter: (status = 'pending')
```

---

## 2. Index Scan

Usa el índice para localizar las filas y luego accede a la tabla para
recuperar columnas adicionales. Ideal cuando se recuperan pocas filas.

```sql
CREATE INDEX idx_orders_status ON orders (status);

EXPLAIN SELECT * FROM orders WHERE status = 'pending';
-- Index Scan using idx_orders_status on orders  ...
--   Index Cond: (status = 'pending')
```

---

## 3. Index Only Scan

Todas las columnas requeridas están en el índice. No accede a la tabla.
Es el más rápido para consultas de cobertura.

```sql
-- Índice que cubre todas las columnas del SELECT
CREATE INDEX idx_orders_cover
    ON orders (status, created_at, total_amount);

EXPLAIN SELECT status, created_at, total_amount
FROM orders
WHERE status = 'pending';
-- Index Only Scan using idx_orders_cover on orders  ...
```

---

## 4. Cuándo PostgreSQL ignora el índice

- La columna indexada está dentro de una función: `LOWER(name) = 'hola'`
- La query recupera más del ~15% de las filas
- Las estadísticas están desactualizadas (ejecutar `ANALYZE`)

---

## 5. Checklist

- ¿Cuándo es más rápido un seq scan que un index scan?
- ¿Qué es un índice de cobertura?
- ¿Por qué `LOWER(col) = 'x'` no usa el índice sobre `col`?
- ¿Cómo forzar actualización de estadísticas?

---

## Referencias

- https://www.postgresql.org/docs/16/indexes-types.html
- https://use-the-index-luke.com/sql/anatomy
