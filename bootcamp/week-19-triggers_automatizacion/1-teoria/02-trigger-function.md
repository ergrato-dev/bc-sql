# NEW, OLD y la trigger function

## Objetivo

Usar las variables especiales `NEW` y `OLD` para leer
o modificar los datos de la fila que disparó el trigger.

## 1. Variables especiales

Dentro de una trigger function dispuesta `FOR EACH ROW`:

| Variable | INSERT | UPDATE | DELETE |
|----------|--------|--------|--------|
| `NEW` | Fila nueva | Fila nueva | NULL |
| `OLD` | NULL | Fila anterior | Fila eliminada |

## 2. TG_OP — operación que disparó el trigger

```sql
IF TG_OP = 'INSERT' THEN
    RAISE NOTICE 'Inserción de id=%', NEW.id;
ELSIF TG_OP = 'UPDATE' THEN
    RAISE NOTICE 'Actualización id=% precio % → %',
                 NEW.id, OLD.price, NEW.price;
ELSIF TG_OP = 'DELETE' THEN
    RAISE NOTICE 'Eliminación de id=%', OLD.id;
END IF;
```

## 3. TG_TABLE_NAME — nombre de la tabla

Permite reutilizar la misma función en varias tablas:

```sql
INSERT INTO audit_log (table_name, action, old_data, new_data)
VALUES (TG_TABLE_NAME, TG_OP,
        row_to_json(OLD)::TEXT,
        row_to_json(NEW)::TEXT);
```

## 4. Valor de retorno de la trigger function

| Situación | Qué retornar |
|-----------|-------------|
| BEFORE ROW — continuar | `RETURN NEW;` |
| BEFORE ROW — cancelar la operación | `RETURN NULL;` |
| AFTER ROW o STATEMENT | `RETURN NULL;` (se ignora) |

```sql
-- Trigger BEFORE que normaliza el texto antes de guardar
CREATE OR REPLACE FUNCTION fn_normalize_name()
RETURNS TRIGGER
LANGUAGE plpgsql
AS $$
BEGIN
    NEW.name := TRIM(UPPER(NEW.name));
    RETURN NEW;
END;
$$;
```

## Checklist de comprensión

1. En un trigger `BEFORE DELETE`, ¿`NEW` tiene valor?
2. ¿Qué ocurre si una trigger BEFORE retorna NULL?
3. ¿Cómo modificas el valor que se va a insertar
   desde la trigger function?
4. ¿Cuándo usarías `TG_TABLE_NAME` en lugar de escribir
   el nombre de la tabla directamente?

## Referencias

- [PostgreSQL — Overview of Trigger Behavior](https://www.postgresql.org/docs/16/trigger-definition.html)
- [PostgreSQL — Trigger Functions in PL/pgSQL](https://www.postgresql.org/docs/16/plpgsql-trigger.html)
