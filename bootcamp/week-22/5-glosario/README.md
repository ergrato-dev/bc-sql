# Glosario — Semana 22: JSON y JSONB

Términos SQL y PostgreSQL ordenados alfabéticamente.

---

## @>

Operador de contención JSONB. Verifica que el documento izquierdo contiene
todos los pares clave-valor del documento derecho. Puede usar índice GIN.

```sql
SELECT * FROM products WHERE attributes @> '{"color": "silver"}';
```

---

## ?

Operador de existencia JSONB. Verifica si existe una clave en el nivel
raíz del documento. También soporta índice GIN.

```sql
SELECT * FROM products WHERE attributes ? 'hdr';
```

---

## ->

Operador de acceso JSONB. Retorna el valor de un campo como `JSONB`.
Útil para anidamiento o comparaciones que requieren tipo JSON.

```sql
SELECT attributes -> 'sensor' FROM products;
```

---

## ->>

Operador de acceso JSONB. Retorna el valor de un campo como `TEXT`.
Útil para filtros con `=`, `LIKE`, `ORDER BY`.

```sql
SELECT attributes ->> 'color' FROM products;
```

---

## #>>

Operador de acceso por path JSONB. Navega documentos anidados a través
de un array de claves y retorna `TEXT`.

```sql
SELECT attributes #>> '{sensor, megapixels}' FROM products;
```

---

## JSONB

Tipo de dato PostgreSQL para documentos JSON almacenados en formato
binario optimizado. Normaliza el documento (reordena claves, elimina
duplicados) y soporta índices GIN.

```sql
CREATE TABLE t (data JSONB);
```

---

## jsonb_agg

Función de agregación que convierte un grupo de filas en un array JSONB.

```sql
SELECT category, jsonb_agg(name) FROM products GROUP BY category;
```

---

## jsonb_build_object

Construye un documento JSONB a partir de pares clave-valor.

```sql
SELECT jsonb_build_object('id', id, 'name', name) FROM products;
```

---

## jsonb_set

Modifica el valor de un campo en un documento JSONB. No hace `UPDATE`
por sí solo — debe usarse dentro de `SET`.

```sql
UPDATE products
SET attributes = jsonb_set(attributes, '{warranty}', '2', TRUE);
```

---

## jsonb_strip_nulls

Elimina todos los campos con valor `null` de un documento JSONB.

```sql
SELECT jsonb_strip_nulls('{"a": 1, "b": null}'::JSONB);
-- {"a": 1}
```

---

## operador - (minus)

Elimina una clave de un documento JSONB (versión escalar) o un elemento
de un array JSONB (versión por índice numérico).

```sql
UPDATE products SET attributes = attributes - 'brand';
```
