# Glosario — Semana 19: Triggers

Términos clave ordenados alfabéticamente.

---

## A

**AFTER**
Momento de ejecución de un trigger: después de que la operación DML
modifica la tabla. Se usa para auditoría y cálculos derivados.
```sql
CREATE TRIGGER trg_x AFTER INSERT ON tabla FOR EACH ROW ...;
```

---

## B

**BEFORE**
Momento de ejecución de un trigger: antes de que la operación llegue
a disco. Se usa para validar o transformar los datos de `NEW`.
```sql
CREATE TRIGGER trg_x BEFORE INSERT OR UPDATE ON tabla FOR EACH ROW ...;
```

---

## C

**CREATE TRIGGER**
Sentencia DDL que asocia una función trigger a una tabla y un evento.
```sql
CREATE TRIGGER nombre AFTER INSERT ON tabla
FOR EACH ROW EXECUTE FUNCTION fn_trigger();
```

---

## D

**DISABLE TRIGGER**
Pausa temporalmente un trigger sin eliminarlo.
```sql
ALTER TABLE tabla DISABLE TRIGGER nombre_trigger;
```

**DROP TRIGGER**
Elimina un trigger de una tabla. No elimina la función asociada.
```sql
DROP TRIGGER IF EXISTS nombre_trigger ON tabla;
```

---

## E

**ENABLE TRIGGER**
Reactiva un trigger previamente deshabilitado.
```sql
ALTER TABLE tabla ENABLE TRIGGER nombre_trigger;
```

---

## F

**FOR EACH ROW**
Indica que el trigger se ejecuta una vez por cada fila afectada.

**FOR EACH STATEMENT**
Indica que el trigger se ejecuta una sola vez por sentencia DML,
sin importar cuántas filas afecta.

---

## I

**INSTEAD OF**
Tipo de trigger que reemplaza la operación DML. Solo aplica sobre vistas.

---

## N

**NEW**
Registro de tipo `RECORD` con los valores que se van a insertar/actualizar.
Disponible en `INSERT` y `UPDATE`.

---

## O

**OLD**
Registro de tipo `RECORD` con los valores anteriores al cambio.
Disponible en `UPDATE` y `DELETE`.

---

## R

**RETURNS TRIGGER**
Tipo de retorno obligatorio para toda función de trigger.
```sql
CREATE FUNCTION fn() RETURNS TRIGGER LANGUAGE plpgsql AS $$ ... $$;
```

---

## T

**TG_OP**
Variable especial con el nombre de la operación que disparó el trigger:
`'INSERT'`, `'UPDATE'`, `'DELETE'` o `'TRUNCATE'`.

**TG_TABLE_NAME**
Variable especial con el nombre de la tabla que disparó el trigger.

**trigger**
Objeto de base de datos que ejecuta automáticamente una función
cuando ocurre un evento DML (`INSERT`, `UPDATE`, `DELETE`) sobre una tabla.

**trigger function**
Función PL/pgSQL de retorno `RETURNS TRIGGER` que contiene
la lógica que ejecuta el trigger.
