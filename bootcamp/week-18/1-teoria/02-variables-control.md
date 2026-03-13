# Variables, condicionales y bucles en PL/pgSQL

## Objetivo

Controlar el flujo de ejecución dentro de funciones y procedimientos
con variables, `IF` y estructuras de repetición.

## 1. Bloque DECLARE

Las variables se declaran antes del `BEGIN`:

```sql
DECLARE
    v_total   NUMERIC := 0;
    v_counter INT     := 0;
    v_label   TEXT;
BEGIN
    -- ...
END;
```

> Convención: prefijo `v_` para variables locales.

## 2. IF / ELSIF / ELSE

```sql
IF v_total > 1000 THEN
    v_label := 'premium';
ELSIF v_total > 500 THEN
    v_label := 'standard';
ELSE
    v_label := 'basic';
END IF;
```

## 3. LOOP / EXIT WHEN

Bucle genérico con condición de salida explícita:

```sql
LOOP
    v_counter := v_counter + 1;
    EXIT WHEN v_counter >= 5;
END LOOP;
```

## 4. FOR sobre un rango

```sql
FOR i IN 1..10 LOOP
    RAISE NOTICE 'Iteración %', i;
END LOOP;
```

## 5. FOR sobre una consulta

Itera fila a fila sobre el resultado de un SELECT:

```sql
DECLARE
    rec RECORD;
BEGIN
    FOR rec IN SELECT id, owner FROM accounts LOOP
        RAISE NOTICE 'Cuenta %: %', rec.id, rec.owner;
    END LOOP;
END;
```

## Checklist de comprensión

1. ¿Dónde se declaran las variables en PL/pgSQL?
2. ¿Puedes asignar con `:=` y con `SELECT INTO`? ¿Cuándo usar cada una?
3. ¿Qué hace `RAISE NOTICE`? ¿Aparece en el resultado de la consulta?
4. ¿Cómo salir de un bucle `FOR` antes de que termine el rango?

## Referencias

- [PostgreSQL — PL/pgSQL Declarations](https://www.postgresql.org/docs/16/plpgsql-declarations.html)
- [PostgreSQL — Control Structures](https://www.postgresql.org/docs/16/plpgsql-control-structures.html)
