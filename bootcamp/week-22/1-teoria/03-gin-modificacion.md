# 3. Índice GIN, modificación y agregación

## Objetivo

Crear índices GIN sobre columnas JSONB, usar `@>` para búsquedas eficientes,
modificar documentos con `jsonb_set` y construir reportes con `jsonb_agg`.

> Referencia: https://www.postgresql.org/docs/16/datatype-json.html#JSON-INDEXING

---

## 1. Operador de contención `@>`

Verifica que el lado izquierdo contiene el documento del lado derecho:

```sql
-- Buscar productos con color silver
SELECT name
FROM products
WHERE attributes @> '{"color": "silver"}';

-- Buscar con 16 GB de RAM
SELECT name
FROM products
WHERE attributes @> '{"ram_gb": 16}';
```

`@>` puede usar un índice GIN; `->>`+`=` no puede.

---

## 2. Crear índice GIN sobre JSONB

```sql
CREATE INDEX idx_products_attrs ON products USING GIN (attributes);
```

Ahora las consultas con `@>`, `?`, `?|`, `?&` usan el índice.

---

## 3. Modificar documentos con jsonb_set

`jsonb_set(target, path, new_value, create_missing)` retorna el documento
modificado (no hace UPDATE por sí solo):

```sql
-- Cambiar el valor de 'ram_gb'
UPDATE products
SET attributes = jsonb_set(attributes, '{ram_gb}', '32')
WHERE name = 'Laptop Pro';

-- Agregar una clave nueva
UPDATE products
SET attributes = jsonb_set(attributes, '{warranty_years}', '2', TRUE)
WHERE attributes ? 'ram_gb';
```

---

## 4. Agregar filas con jsonb_agg

```sql
-- Construir un documento por categoría agrupando products
SELECT
    attributes ->> 'color'   AS color,
    jsonb_agg(
        jsonb_build_object('id', id, 'name', name)
    )                        AS items
FROM products
WHERE attributes ? 'color'
GROUP BY color;
```

---

## 5. Checklist

- ¿Cuál es la diferencia entre `@>` y `->>`+`=`?
- ¿Qué tipo de índice soporta `@>`?
- ¿Qué hace `jsonb_set`?
- ¿Para qué sirve `jsonb_agg`?

---

## Referencias

- https://www.postgresql.org/docs/16/functions-json.html
- https://www.postgresql.org/docs/16/datatype-json.html#JSON-INDEXING
