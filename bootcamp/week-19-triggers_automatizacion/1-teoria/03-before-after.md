# Triggers BEFORE, AFTER y gestión del ciclo de vida

## Objetivo

Elegir entre `BEFORE` y `AFTER` según el caso de uso
y gestionar el ciclo de vida de un trigger.

## 1. Cuándo usar BEFORE vs AFTER

| Caso de uso | Momento recomendado |
|-------------|---------------------|
| Validar datos antes de guardar | `BEFORE` |
| Transformar datos (normalizar) | `BEFORE` |
| Auditoría de cambios confirmados | `AFTER` |
| Actualizar tablas relacionadas | `AFTER` |
| Calcular totales derivados | `AFTER` |

## 2. Ejemplo AFTER — auditoría

```sql
CREATE OR REPLACE FUNCTION fn_log_changes()
RETURNS TRIGGER
LANGUAGE plpgsql
AS $$
BEGIN
    INSERT INTO audit_log (action, detail)
    VALUES (TG_OP,
            FORMAT('tabla=%s id=%s',
                   TG_TABLE_NAME,
                   COALESCE(NEW.id, OLD.id)));
    RETURN NULL;
END;
$$;

CREATE TRIGGER trg_log_products
AFTER INSERT OR UPDATE OR DELETE ON products
FOR EACH ROW EXECUTE FUNCTION fn_log_changes();
```

## 3. Deshabilitar y habilitar un trigger

```sql
-- Deshabilitar (útil para cargas masivas)
ALTER TABLE products DISABLE TRIGGER trg_log_products;

-- Rehabilitar
ALTER TABLE products ENABLE TRIGGER trg_log_products;

-- Deshabilitar todos los triggers de la tabla
ALTER TABLE products DISABLE TRIGGER ALL;
```

## 4. Eliminar un trigger

```sql
DROP TRIGGER IF EXISTS trg_log_products ON products;
```

> `DROP TRIGGER` no elimina la trigger function.
> Usa `DROP FUNCTION` por separado si ya no la necesitas.

## Checklist de comprensión

1. ¿Por qué se recomienda `AFTER` para auditoría en lugar de `BEFORE`?
2. ¿Qué pasa con los registros de auditoría si la operación
   falla y se hace ROLLBACK?
3. ¿Para qué sirve deshabilitar un trigger temporalmente?
4. Si eliminas el trigger, ¿la función asociada también desaparece?

## Referencias

- [PostgreSQL — ALTER TABLE DISABLE TRIGGER](https://www.postgresql.org/docs/16/sql-altertable.html)
- [PostgreSQL — DROP TRIGGER](https://www.postgresql.org/docs/16/sql-droptrigger.html)
