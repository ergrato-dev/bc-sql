# 3. Índices parciales, compuestos y monitoreo

## Objetivo

Crear índices parciales y compuestos para casos específicos, y consultar
las vistas de sistema para monitorear el rendimiento.

> Referencia: https://www.postgresql.org/docs/16/indexes-partial.html

---

## 1. Índice parcial

Indexa solo las filas que satisfacen una condición `WHERE`. Más pequeño
y más rápido de mantener que un índice completo.

```sql
-- Solo indexar pedidos con estado 'pending'
-- Si el 95% de pedidos están en 'completed', este índice es muy eficiente
CREATE INDEX idx_orders_pending
    ON orders (created_at)
    WHERE status = 'pending';

-- La consulta debe contener la misma condición para usar el índice
SELECT * FROM orders
WHERE status = 'pending'
  AND created_at >= CURRENT_DATE - INTERVAL '7 days';
```

---

## 2. Índice compuesto

Combina múltiples columnas en un solo índice. Las columnas de mayor
selectividad (más valores únicos) van primero.

```sql
-- Útil cuando las consultas filtran por region Y status juntos
CREATE INDEX idx_orders_region_status ON orders (region, status);

-- La query debe usar el prefijo del índice izquierdo
SELECT * FROM orders WHERE region = 'norte' AND status = 'pending';
```

---

## 3. VACUUM y ANALYZE

```sql
-- Actualizar estadísticas de una tabla
ANALYZE orders;

-- Reclamar espacio de filas muertas y actualizar estadísticas
VACUUM ANALYZE orders;
```

---

## 4. Vistas de monitoreo

```sql
-- Ver tamaño e índices de una tabla
SELECT
    schemaname,
    tablename,
    n_live_tup     AS filas_vivas,
    n_dead_tup     AS filas_muertas,
    last_analyze
FROM pg_stat_user_tables
WHERE tablename = 'orders';

-- Listar índices de la base de datos
SELECT indexname, tablename, indexdef
FROM pg_indexes
WHERE schemaname = 'public'
ORDER BY tablename;
```

---

## 5. Checklist

- ¿Cuándo conviene un índice parcial?
- ¿Qué columna va primera en un índice compuesto?
- ¿Qué hace `VACUUM ANALYZE`?
- ¿Qué columna de `pg_stat_user_tables` indica filas eliminadas sin limpiar?

---

## Referencias

- https://www.postgresql.org/docs/16/indexes-partial.html
- https://www.postgresql.org/docs/16/routine-vacuuming.html
