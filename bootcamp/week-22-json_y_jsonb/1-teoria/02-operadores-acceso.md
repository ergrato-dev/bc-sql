# 2. Operadores de acceso

## Objetivo

Navegar por documentos anidados con `->`, `->>` y `#>`, y filtrar filas
con condiciones sobre campos JSON.

> Referencia: https://www.postgresql.org/docs/16/functions-json.html

---

## 1. Acceso a campos anidados con `#>`

Para documentos con más de un nivel se usa `#>` (retorna JSONB) o `#>>`
(retorna TEXT) seguido de un path como array:

```sql
-- Documento con anidamiento
INSERT INTO products (name, attributes) VALUES
('Camera X200',
 '{"sensor": {"megapixels": 24, "type": "CMOS"}, "zoom": 10}');

-- Acceder a sensor.megapixels
SELECT attributes #>> '{sensor, megapixels}' AS mp
FROM products
WHERE name = 'Camera X200';
```

---

## 2. Verificar existencia de clave con `?`

```sql
-- ¿Tiene el campo 'hdr'?
SELECT name
FROM products
WHERE attributes ? 'hdr';

-- ¿Tiene alguno de estos campos?
SELECT name
FROM products
WHERE attributes ?| ARRAY['hdr', 'zoom'];

-- ¿Tiene todos estos campos?
SELECT name
FROM products
WHERE attributes ?& ARRAY['color', 'ram_gb'];
```

---

## 3. Acceso a elementos de array JSON

```sql
INSERT INTO products (name, attributes) VALUES
('Hub USB',
 '{"ports": ["USB-A", "USB-C", "HDMI"], "powered": false}');

-- Primer elemento del array (índice 0)
SELECT attributes -> 'ports' -> 0 AS primer_puerto
FROM products WHERE name = 'Hub USB';

-- Todos los puertos como texto
SELECT attributes #>> '{ports, 1}' AS segundo_puerto
FROM products WHERE name = 'Hub USB';
```

---

## 4. Checklist

- ¿Cuándo usar `#>` en lugar de `->`?
- ¿Qué diferencia hay entre `?`, `?|` y `?&`?
- ¿Cómo acceder al tercer elemento de un array JSON?
- ¿Qué retorna `attributes -> 'ports' -> 0`?

---

## Referencias

- https://www.postgresql.org/docs/16/functions-json.html
- https://www.postgresql.org/docs/16/datatype-json.html#JSON-INDEXING
