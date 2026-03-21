# 1. JSON vs JSONB

## Objetivo

Entender cuándo usar `JSON` y cuándo usar `JSONB`, y crear tablas con
columnas de tipo documento.

> Referencia: https://www.postgresql.org/docs/16/datatype-json.html

---

## 1. Diferencias fundamentales

`JSON` guarda el texto del documento exactamente como se insertó.
`JSONB` guarda el documento en formato binario optimizado.

```sql
-- JSON: preserva formato, espacios y claves duplicadas
SELECT '{"a": 1,  "a": 2}'::JSON;
-- Resultado: {"a": 1,  "a": 2}

-- JSONB: normaliza, elimina duplicados, reordena claves
SELECT '{"a": 1,  "a": 2}'::JSONB;
-- Resultado: {"a": 2}
```

> Regla: **usar siempre JSONB** salvo que necesites preservar el
> texto original exacto.

---

## 2. Crear una columna JSONB

```sql
CREATE TABLE products (
    id         SERIAL       PRIMARY KEY,
    name       TEXT         NOT NULL,
    attributes JSONB        NOT NULL DEFAULT '{}'
);

INSERT INTO products (name, attributes) VALUES
('Laptop Pro',  '{"color": "silver", "ram_gb": 16, "storage_gb": 512}'),
('Tablet Air',  '{"color": "black",  "ram_gb": 8,  "storage_gb": 256}'),
('Monitor 4K',  '{"resolution": "3840x2160", "hz": 60, "hdr": true}');
```

---

## 3. Acceso básico con `->` y `->>`

| Operador | Retorna | Uso |
|----------|---------|-----|
| `->` | `JSONB` | para anidamiento o comparaciones JSON |
| `->>` | `TEXT` | para mostrar valores o comparar como texto |

```sql
-- Acceder al campo 'color' como JSONB
SELECT attributes -> 'color' FROM products;

-- Acceder al campo 'color' como TEXT
SELECT attributes ->> 'color' FROM products;

-- Filtrar por valor de campo
SELECT name FROM products
WHERE attributes ->> 'color' = 'black';
```

---

## 4. Checklist

- ¿Cuál es la diferencia entre `JSON` y `JSONB`?
- ¿Qué retorna `->` y qué retorna `->>`?
- ¿Por qué JSONB reordena las claves?
- ¿En qué caso usarías JSON en lugar de JSONB?

---

## Referencias

- https://www.postgresql.org/docs/16/datatype-json.html
- https://www.postgresql.org/docs/16/functions-json.html
