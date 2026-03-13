# Ejercicio 02 — Índices parciales, VACUUM y monitoreo

## Tema

Crear índices parciales para casos específicos, ejecutar `VACUUM ANALYZE`
y consultar vistas del sistema para monitorear el estado de las tablas.

## Cómo ejecutar

1. Levanta el contenedor:
   ```bash
   docker compose -f _scripts/docker-compose.yml up -d
   ```
2. Carga el esquema:
   ```bash
   docker compose -f _scripts/docker-compose.yml exec -T postgres \
     psql -U bootcamp -d bootcamp_db < bootcamp/week-23/2-practicas/ejercicio-02/starter/setup.sql
   ```
3. Conéctate:
   ```bash
   docker compose -f _scripts/docker-compose.yml exec postgres \
     psql -U bootcamp -d bootcamp_db
   ```
4. Abre `starter/ejercicio.sql` y sigue los pasos.

---

## Esquema de trabajo

Mismas tablas `orders` y `customers` (2 000 y 200 filas).

---

### Paso 1: Índice parcial

Solo los pedidos `pending` son consultados activamente. Un índice parcial
cubre solo esas filas:

```sql
CREATE INDEX idx_orders_pending
    ON orders (created_at)
    WHERE status = 'pending';

EXPLAIN ANALYZE
SELECT * FROM orders
WHERE status = 'pending'
  AND created_at >= CURRENT_DATE - INTERVAL '30 days';
```

**Descomenta "PASO 1".**

---

### Paso 2: Por qué las funciones rompen los índices

```sql
-- Sin índice funcional: no usa idx_orders_customer
EXPLAIN SELECT * FROM orders
WHERE customer_id::TEXT = '15';

-- Con índice funcional correcto
CREATE INDEX idx_orders_customer_cast ON orders ((customer_id::TEXT));
EXPLAIN SELECT * FROM orders WHERE customer_id::TEXT = '15';
```

**Descomenta "PASO 2".**

---

### Paso 3: VACUUM ANALYZE

```sql
VACUUM ANALYZE orders;

SELECT
    tablename,
    n_live_tup     AS filas_vivas,
    n_dead_tup     AS filas_muertas,
    last_analyze
FROM pg_stat_user_tables
WHERE tablename = 'orders';
```

**Descomenta "PASO 3".**

---

### Paso 4: Listar índices con pg_indexes

```sql
SELECT
    indexname,
    tablename,
    indexdef
FROM pg_indexes
WHERE schemaname = 'public'
  AND tablename IN ('orders', 'customers')
ORDER BY tablename, indexname;
```

**Descomenta "PASO 4".**
