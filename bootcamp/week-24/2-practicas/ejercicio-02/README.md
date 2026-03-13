# Ejercicio 02 — Trigger de auditoría y reporte JSONB

## Objetivo

Implementar un trigger de auditoría genérico, un trigger de validación
y un reporte JSONB que consolida datos de múltiples tablas.

## Cómo ejecutar

1. Asegúrate de haber ejecutado el setup del ejercicio 01
2. Carga este setup adicional:
   ```bash
   docker compose -f _scripts/docker-compose.yml exec -T postgres \
     psql -U bootcamp -d bootcamp_db < starter/setup.sql
   ```
3. Abre el ejercicio:
   ```bash
   docker compose -f _scripts/docker-compose.yml exec postgres \
     psql -U bootcamp -d bootcamp_db -f /dev/stdin < starter/ejercicio.sql
   ```

---

### Paso 1: Tabla audit_log y trigger de auditoría

Crear la tabla `audit_log` y un trigger `AFTER INSERT OR UPDATE OR DELETE`
sobre `products`:

```sql
CREATE TABLE IF NOT EXISTS audit_log (
    id          BIGSERIAL   PRIMARY KEY,
    table_name  TEXT        NOT NULL,
    action      TEXT        NOT NULL,
    record_id   INTEGER,
    changed_at  TIMESTAMP   NOT NULL DEFAULT NOW()
);

CREATE OR REPLACE FUNCTION fn_audit_products()
RETURNS TRIGGER LANGUAGE plpgsql AS $$
BEGIN
    INSERT INTO audit_log (table_name, action, record_id)
    VALUES (TG_TABLE_NAME, TG_OP, COALESCE(NEW.id, OLD.id));
    RETURN NEW;
END;
$$;

CREATE TRIGGER trg_audit_products
    AFTER INSERT OR UPDATE OR DELETE ON products
    FOR EACH ROW EXECUTE FUNCTION fn_audit_products();
```

**Abre `starter/ejercicio.sql`** y descomenta la sección del Paso 1.

---

### Paso 2: Trigger de validación BEFORE UPDATE

Impedir que el precio de un producto sea reducido por debajo del 50%
de su valor actual:

```sql
CREATE OR REPLACE FUNCTION fn_validate_price()
RETURNS TRIGGER LANGUAGE plpgsql AS $$
BEGIN
    IF NEW.price < OLD.price * 0.5 THEN
        RAISE EXCEPTION
            'Precio inválido: no se puede reducir el precio en más del 50%%.'
            ' Precio actual: %, Nuevo: %', OLD.price, NEW.price;
    END IF;
    RETURN NEW;
END;
$$;

CREATE TRIGGER trg_validate_price
    BEFORE UPDATE OF price ON products
    FOR EACH ROW EXECUTE FUNCTION fn_validate_price();
```

**Abre `starter/ejercicio.sql`** y descomenta la sección del Paso 2.

---

### Paso 3: jsonb_set para actualizar atributos

Actualizar un campo dentro del JSONB `attributes` sin reemplazar
el documento completo:

```sql
UPDATE products
SET attributes = jsonb_set(attributes, '{stock_alert}', 'true', true)
WHERE stock < 50;

SELECT name, attributes->'stock_alert' AS alert
FROM products
WHERE (attributes->>'stock_alert')::BOOLEAN = TRUE;
```

**Abre `starter/ejercicio.sql`** y descomenta la sección del Paso 3.

---

### Paso 4: Reporte consolidado con jsonb_agg

Construir un documento JSON por cliente que incluya sus pedidos:

```sql
SELECT
    c.id,
    c.name,
    jsonb_build_object(
        'total_orders',  COUNT(o.id),
        'total_spent',   SUM(o.total_amount),
        'orders',        jsonb_agg(
            jsonb_build_object(
                'id',     o.id,
                'status', o.status,
                'amount', o.total_amount
            ) ORDER BY o.created_at
        )
    ) AS summary
FROM customers c
JOIN orders o ON o.customer_id = c.id
GROUP BY c.id, c.name
ORDER BY c.name;
```

**Abre `starter/ejercicio.sql`** y descomenta la sección del Paso 4.
