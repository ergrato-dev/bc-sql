# Ejercicio 01 — EXPLAIN ANALYZE e índice B-tree

## Tema

Observar cómo cambia el plan de ejecución al agregar un índice B-tree
y verificar la mejora con `EXPLAIN ANALYZE`.

## Cómo ejecutar

1. Levanta el contenedor:
   ```bash
   docker compose -f _scripts/docker-compose.yml up -d
   ```
2. Carga el esquema:
   ```bash
   docker compose -f _scripts/docker-compose.yml exec -T postgres \
     psql -U bootcamp -d bootcamp_db < bootcamp/week-23/2-practicas/ejercicio-01/starter/setup.sql
   ```
3. Conéctate:
   ```bash
   docker compose -f _scripts/docker-compose.yml exec postgres \
     psql -U bootcamp -d bootcamp_db
   ```
4. Abre `starter/ejercicio.sql` y sigue los pasos.

---

## Esquema de trabajo

Tabla `orders` con 2 000 filas y tabla `customers` con 200 filas.

---

### Paso 1: EXPLAIN sin índice

Ver el plan antes de crear índices:

```sql
EXPLAIN SELECT *
FROM orders
WHERE customer_id = 15;
```

**Descomenta "PASO 1".**

---

### Paso 2: Crear índice y comparar

```sql
CREATE INDEX idx_orders_customer ON orders (customer_id);

EXPLAIN ANALYZE SELECT *
FROM orders
WHERE customer_id = 15;
```

**Descomenta "PASO 2".**

---

### Paso 3: Índice compuesto para JOIN

Índice que optimiza un JOIN frecuente con filtro de estado:

```sql
CREATE INDEX idx_orders_status_cust ON orders (status, customer_id);

EXPLAIN ANALYZE
SELECT o.id, o.total_amount, c.name
FROM orders o
JOIN customers c ON o.customer_id = c.id
WHERE o.status = 'pending';
```

**Descomenta "PASO 3".**

---

### Paso 4: Index Only Scan con índice cubriente

```sql
CREATE INDEX idx_orders_cover
    ON orders (status, created_at, total_amount);

EXPLAIN ANALYZE
SELECT status, created_at, total_amount
FROM orders
WHERE status = 'pending';
```

**Descomenta "PASO 4".**
