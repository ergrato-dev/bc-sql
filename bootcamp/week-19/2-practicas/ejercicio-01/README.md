# Ejercicio 01 — Trigger de auditoría AFTER INSERT/UPDATE/DELETE

## Tema

Implementar un trigger `AFTER` que registra automáticamente
cada cambio en la tabla `products` dentro de una tabla `audit_log`.

## Cómo ejecutar

1. Asegúrate de tener Docker corriendo:
   ```bash
   docker compose -f _scripts/docker-compose.yml up -d
   ```
2. Carga el esquema:
   ```bash
   docker compose -f _scripts/docker-compose.yml exec -T postgres \
     psql -U bootcamp -d bootcamp_db < bootcamp/week-19/2-practicas/ejercicio-01/starter/setup.sql
   ```
3. Conecta e interactúa:
   ```bash
   docker compose -f _scripts/docker-compose.yml exec postgres \
     psql -U bootcamp -d bootcamp_db
   ```
4. Abre `starter/ejercicio.sql` y sigue los pasos.

---

## Esquema de trabajo

Tabla `products` y tabla `audit_log`.

### Paso 1: Crear la trigger function de auditoría

Crea `fn_audit_changes` que inserta una fila en `audit_log`
con el tipo de operación, el id afectado y la tabla.

```sql
CREATE OR REPLACE FUNCTION fn_audit_changes()
RETURNS TRIGGER
LANGUAGE plpgsql
AS $$
BEGIN
    INSERT INTO audit_log (table_name, action, record_id, detail)
    VALUES (
        TG_TABLE_NAME,
        TG_OP,
        COALESCE(NEW.id, OLD.id),
        FORMAT('old_price=%s new_price=%s',
               OLD.price, NEW.price)
    );
    RETURN NULL;
END;
$$;
```

**Abre `starter/ejercicio.sql`** y descomenta la sección "PASO 1".

---

### Paso 2: Crear el trigger AFTER y probarlo

Crea el trigger que llama a `fn_audit_changes` y verifica
que se registra una fila al hacer INSERT, UPDATE y DELETE.

```sql
CREATE TRIGGER trg_audit_products
AFTER INSERT OR UPDATE OR DELETE ON products
FOR EACH ROW EXECUTE FUNCTION fn_audit_changes();

INSERT INTO products (name, price, stock, category)
VALUES ('Test item', 99.00, 5, 'test');

SELECT * FROM audit_log ORDER BY id DESC LIMIT 3;
```

**Descomenta la sección "PASO 2".**

---

### Paso 3: UPDATE y DELETE — verificar registro en log

Actualiza el precio de un producto y luego elimínalo.
Consulta el log para confirmar que ambas acciones quedaron registradas.

```sql
UPDATE products SET price = 120.00 WHERE name = 'Test item';
DELETE FROM products WHERE name = 'Test item';

SELECT table_name, action, record_id, detail, executed_at
FROM audit_log
ORDER BY id DESC
LIMIT 5;
```

**Descomenta la sección "PASO 3".**

---

### Paso 4: Deshabilitar y habilitar el trigger

Deshabilita el trigger, realiza un cambio y confirma que
no se generó registro. Luego habilítalo de nuevo.

```sql
ALTER TABLE products DISABLE TRIGGER trg_audit_products;

UPDATE products SET price = price * 1.1 WHERE category = 'furniture';

SELECT COUNT(*) AS nuevos_logs FROM audit_log
WHERE executed_at > NOW() - INTERVAL '5 seconds';

ALTER TABLE products ENABLE TRIGGER trg_audit_products;
```

**Descomenta la sección "PASO 4".**
