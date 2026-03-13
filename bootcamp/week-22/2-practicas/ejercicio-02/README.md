# Ejercicio 02 — Contención @>, jsonb_set y jsonb_agg

## Tema

Buscar con el operador `@>` usando índice GIN, modificar documentos
con `jsonb_set` y construir reportes con `jsonb_agg`.

## Cómo ejecutar

1. Levanta el contenedor:
   ```bash
   docker compose -f _scripts/docker-compose.yml up -d
   ```
2. Carga el esquema:
   ```bash
   docker compose -f _scripts/docker-compose.yml exec -T postgres \
     psql -U bootcamp -d bootcamp_db < bootcamp/week-22/2-practicas/ejercicio-02/starter/setup.sql
   ```
3. Conéctate:
   ```bash
   docker compose -f _scripts/docker-compose.yml exec postgres \
     psql -U bootcamp -d bootcamp_db
   ```
4. Abre `starter/ejercicio.sql` y sigue los pasos.

---

## Esquema de trabajo

Misma tabla `products` con índice GIN sobre `attributes`.

---

### Paso 1: Índice GIN y contención @>

Crear el índice y comparar plan de ejecución:

```sql
CREATE INDEX idx_products_attrs ON products USING GIN (attributes);

EXPLAIN SELECT name
FROM products
WHERE attributes @> '{"color": "silver"}';
```

**Descomenta "PASO 1".**

---

### Paso 2: Modificar documentos con jsonb_set

Agregar la clave `warranty_years` a todos los productos con `ram_gb`:

```sql
UPDATE products
SET attributes = jsonb_set(attributes, '{warranty_years}', '2', TRUE)
WHERE attributes ? 'ram_gb';
```

**Descomenta "PASO 2".**

---

### Paso 3: jsonb_build_object y jsonb_agg

Construir un reporte de productos por categoría como documentos JSON:

```sql
SELECT
    category,
    jsonb_agg(
        jsonb_build_object(
            'id',    id,
            'name',  name,
            'color', attributes ->> 'color'
        )
    ) AS products_json
FROM products
GROUP BY category
ORDER BY category;
```

**Descomenta "PASO 3".**

---

### Paso 4: Eliminar claves con - (minus)

Quitar el campo `brand` de todos los documentos:

```sql
UPDATE products
SET attributes = attributes - 'brand'
WHERE attributes ? 'brand';

SELECT name, attributes FROM products WHERE name LIKE 'Laptop%';
```

**Descomenta "PASO 4".**
