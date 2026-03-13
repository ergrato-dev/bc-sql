# Ejercicio 01 — Esquema integrador con búsqueda y análisis

## Objetivo

Construir un esquema multi-tabla que combina DDL, JOINs, CTEs,
window functions y Full-Text Search en un único flujo de trabajo.

## Cómo ejecutar

1. Asegúrate de tener Docker corriendo
2. Levanta el contenedor:
   ```bash
   docker compose -f _scripts/docker-compose.yml up -d
   ```
3. Carga el esquema:
   ```bash
   docker compose -f _scripts/docker-compose.yml exec -T postgres \
     psql -U bootcamp -d bootcamp_db < starter/setup.sql
   ```
4. Abre el ejercicio:
   ```bash
   docker compose -f _scripts/docker-compose.yml exec postgres \
     psql -U bootcamp -d bootcamp_db -f /dev/stdin < starter/ejercicio.sql
   ```

---

### Paso 1: Explorar el esquema y hacer un JOIN base

Antes de analizar, inspecciona las tablas y escribe un JOIN que
combine `products`, `categories` y `order_items`:

```sql
SELECT
    c.name              AS category_name,
    p.name              AS product_name,
    SUM(oi.quantity)    AS total_sold
FROM categories c
JOIN products p       ON p.category_id = c.id
JOIN order_items oi   ON oi.product_id = p.id
GROUP BY c.name, p.name
ORDER BY total_sold DESC
LIMIT 10;
```

**Abre `starter/ejercicio.sql`** y descomenta la sección del Paso 1.

---

### Paso 2: CTE para productos más vendidos por categoría

Usar una CTE con `ROW_NUMBER()` para obtener el top-2 de productos
por categoría:

```sql
WITH ranked_products AS (
    SELECT
        c.name                                  AS category_name,
        p.name                                  AS product_name,
        SUM(oi.quantity)                        AS total_sold,
        ROW_NUMBER() OVER (
            PARTITION BY c.id
            ORDER BY SUM(oi.quantity) DESC
        )                                       AS rn
    FROM categories c
    JOIN products p     ON p.category_id = c.id
    JOIN order_items oi ON oi.product_id = p.id
    GROUP BY c.id, c.name, p.id, p.name
)
SELECT category_name, product_name, total_sold
FROM ranked_products
WHERE rn <= 2
ORDER BY category_name, rn;
```

**Abre `starter/ejercicio.sql`** y descomenta la sección del Paso 2.

---

### Paso 3: Full-Text Search sobre productos

Buscar productos usando `plainto_tsquery` sobre el campo
`search_vector` precalculado:

```sql
SELECT
    p.name,
    ts_rank(p.search_vector, query) AS rank
FROM products p,
     plainto_tsquery('spanish', 'inalámbrico bluetooth') AS query
WHERE p.search_vector @@ query
ORDER BY rank DESC;
```

**Abre `starter/ejercicio.sql`** y descomenta la sección del Paso 3.

---

### Paso 4: EXPLAIN ANALYZE del JOIN principal

Medir el costo del JOIN del Paso 1 con y sin índice:

```sql
-- Sin índice primero:
EXPLAIN ANALYZE
SELECT p.name, SUM(oi.quantity)
FROM products p
JOIN order_items oi ON oi.product_id = p.id
GROUP BY p.name;

-- Crear índice y volver a medir:
CREATE INDEX IF NOT EXISTS idx_order_items_product
    ON order_items (product_id);
```

**Abre `starter/ejercicio.sql`** y descomenta la sección del Paso 4.
