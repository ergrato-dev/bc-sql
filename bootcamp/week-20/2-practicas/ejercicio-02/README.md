# Ejercicio 02 — Top-N por grupo y funciones tabulares

## Tema

Implementar el patrón Top-N por grupo usando `JOIN LATERAL`
y llamar funciones `RETURNS TABLE` desde la cláusula `FROM`.

## Cómo ejecutar

1. Levanta el contenedor:
   ```bash
   docker compose -f _scripts/docker-compose.yml up -d
   ```
2. Carga el esquema:
   ```bash
   docker compose -f _scripts/docker-compose.yml exec -T postgres \
     psql -U bootcamp -d bootcamp_db < bootcamp/week-20/2-practicas/ejercicio-02/starter/setup.sql
   ```
3. Conéctate:
   ```bash
   docker compose -f _scripts/docker-compose.yml exec postgres \
     psql -U bootcamp -d bootcamp_db
   ```
4. Abre `starter/ejercicio.sql` y sigue los pasos.

---

## Esquema de trabajo

Tablas: `categories`, `products`, `order_items`.

### Paso 1: Top-3 productos más vendidos por categoría

Usa `JOIN LATERAL` para obtener los 3 productos
con mayor cantidad vendida en cada categoría.

```sql
SELECT
    c.name          AS category,
    top3.product_name,
    top3.total_sold
FROM categories c
JOIN LATERAL (
    SELECT p.name AS product_name,
           COALESCE(SUM(oi.quantity), 0) AS total_sold
    FROM products p
    LEFT JOIN order_items oi ON oi.product_id = p.id
    WHERE p.category_id = c.id
    GROUP BY p.id, p.name
    ORDER BY total_sold DESC
    LIMIT 3
) AS top3 ON TRUE
ORDER BY c.name, top3.total_sold DESC;
```

**Abre `starter/ejercicio.sql`** y descomenta la sección "PASO 1".

---

### Paso 2: Función tabular + LATERAL

Crea `fn_top_products(p_cat_id INT, p_limit INT)` que retorna
los productos más vendidos, luego úsala con `CROSS JOIN LATERAL`.

```sql
CREATE OR REPLACE FUNCTION fn_top_products(
    p_cat_id INT,
    p_limit  INT DEFAULT 3
)
RETURNS TABLE (product_name TEXT, total_sold BIGINT)
LANGUAGE sql AS $$
    SELECT p.name,
           COALESCE(SUM(oi.quantity), 0)::BIGINT
    FROM products p
    LEFT JOIN order_items oi ON oi.product_id = p.id
    WHERE p.category_id = p_cat_id
    GROUP BY p.id, p.name
    ORDER BY 2 DESC
    LIMIT p_limit;
$$;

SELECT c.name AS category, tp.product_name, tp.total_sold
FROM categories c
CROSS JOIN LATERAL fn_top_products(c.id, 3) AS tp
ORDER BY c.name, tp.total_sold DESC;
```

**Descomenta la sección "PASO 2".**

---

### Paso 3: Paginación por grupo con OFFSET

Obtén la "página 2" (productos del puesto 4 al 6) de cada categoría.

```sql
SELECT
    c.name AS category,
    page.product_name,
    page.total_sold
FROM categories c
CROSS JOIN LATERAL fn_top_products(c.id, 6) AS all_top
CROSS JOIN LATERAL (
    SELECT p2.name AS product_name,
           COALESCE(SUM(oi2.quantity), 0) AS total_sold
    FROM products p2
    LEFT JOIN order_items oi2 ON oi2.product_id = p2.id
    WHERE p2.category_id = c.id
    GROUP BY p2.id, p2.name
    ORDER BY total_sold DESC
    LIMIT 3 OFFSET 3
) AS page ON TRUE
ORDER BY c.name, page.total_sold DESC;
```

**Descomenta la sección "PASO 3".**

---

### Paso 4: unnest() con LATERAL

Expande un array de tags de producto a filas individuales
usando `unnest()` y `WITH ORDINALITY`.

```sql
SELECT p.name, tag.value, tag.position
FROM products p
CROSS JOIN LATERAL
    unnest(p.tags) WITH ORDINALITY AS tag(value, position)
ORDER BY p.name, tag.position;
```

**Descomenta la sección "PASO 4".**
