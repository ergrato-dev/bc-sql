# 2. Patrones de producción

## Objetivo

Identificar los patrones SQL más usados en sistemas reales y saber
cuándo aplicar cada uno.

> Referencia: https://www.postgresql.org/docs/16/

---

## 1. Patrón de auditoría genérica

Trigger que registra todos los cambios en cualquier tabla usando
`TG_TABLE_NAME` y `TG_OP`:

```sql
CREATE OR REPLACE FUNCTION fn_audit_generic()
RETURNS TRIGGER LANGUAGE plpgsql AS $$
BEGIN
    INSERT INTO audit_log (table_name, action, record_id, detail)
    VALUES (
        TG_TABLE_NAME,
        TG_OP,
        COALESCE(NEW.id, OLD.id),
        FORMAT('%s -> %s', OLD, NEW)
    );
    RETURN NEW;
END;
$$;
```

---

## 2. Patrón de ranking segmentado

Top-N por grupo sin subqueries correlacionadas:

```sql
WITH ranked AS (
    SELECT
        *,
        ROW_NUMBER() OVER (
            PARTITION BY category_id
            ORDER BY total_sales DESC
        ) AS rn
    FROM products
)
SELECT * FROM ranked WHERE rn <= 3;
```

---

## 3. Patrón de reporte dinámico con JSONB

Construir documentos JSON en la capa de base de datos para APIs:

```sql
SELECT
    c.id,
    jsonb_build_object(
        'customer', c.name,
        'orders',   jsonb_agg(
            jsonb_build_object('id', o.id, 'total', o.total_amount)
        )
    ) AS customer_data
FROM customers c
JOIN orders o ON c.id = o.customer_id
GROUP BY c.id, c.name;
```

---

## 4. Checklist

- ¿Por qué usar `TG_TABLE_NAME` en lugar de hardcodear el nombre de la tabla?
- ¿Cuándo usar `ROW_NUMBER` vs `RANK` en un ranking?
- ¿Para qué sirve `jsonb_agg` en un reporte de API?
- ¿Qué debe tener un índice cubriente para evitar heap fetch?

---

## Referencias

- https://www.postgresql.org/docs/16/plpgsql-trigger.html
- https://www.postgresql.org/docs/16/functions-window.html
