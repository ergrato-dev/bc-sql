# Glosario — Semana 18: Funciones y Procedimientos PL/pgSQL

Términos SQL ordenados alfabéticamente.

---

## CALL

Instrucción para invocar un procedimiento almacenado.
No se puede usar dentro de un `SELECT`.

```sql
CALL sp_restock(1, 10);
```

---

## CREATE FUNCTION

Crea una función reutilizable con nombre, parámetros, tipo de retorno
y cuerpo en PL/pgSQL (u otro lenguaje).

```sql
CREATE OR REPLACE FUNCTION fn_nombre(p INT) RETURNS TEXT ...
```

---

## CREATE PROCEDURE

Crea un procedimiento que puede manejar transacciones (`COMMIT`/`ROLLBACK`)
y se invoca con `CALL`. Disponible desde PostgreSQL 11.

---

## DECLARE

Sección de un bloque PL/pgSQL donde se declaran variables locales,
antes del `BEGIN`.

---

## DO

Ejecuta un bloque PL/pgSQL anónimo sin crear un objeto persistente.

```sql
DO $$ BEGIN ... END; $$;
```

---

## DROP FUNCTION / DROP PROCEDURE

Elimina una función o procedimiento. Se debe indicar la firma completa.

```sql
DROP FUNCTION IF EXISTS fn_nombre(INT);
DROP PROCEDURE IF EXISTS sp_nombre(INT, INT);
```

---

## EXCEPTION

Bloque dentro de un `BEGIN…END` que captura errores en tiempo de ejecución.

```sql
EXCEPTION
    WHEN check_violation THEN ...
    WHEN OTHERS THEN ...
END;
```

---

## FORMAT()

Función que construye cadenas con sustitución de valores posicionales,
similar a `printf`. Seguro contra inyección de datos.

```sql
FORMAT('usuario=%s saldo=%s', v_name, v_balance)
```

---

## LANGUAGE plpgsql

Especifica el motor de ejecución del cuerpo de la función o procedimiento.
Alternativas: `sql`, `python`, `perl`, etc.

---

## RAISE EXCEPTION

Lanza un error con mensaje personalizado, interrumpiendo la ejecución
del bloque actual.

```sql
RAISE EXCEPTION 'Stock insuficiente: %', v_stock;
```

---

## RAISE NOTICE

Emite un mensaje informativo sin interrumpir la ejecución.
Útil para depuración.

```sql
RAISE NOTICE 'Procesando id=%', rec.id;
```

---

## RETURN QUERY

Dentro de una función `RETURNS TABLE` o `RETURNS SETOF`, añade filas
al conjunto de resultados de retorno.

```sql
RETURN QUERY SELECT * FROM products WHERE stock < p_min;
```

---

## SELECT INTO

Asigna el resultado de un SELECT a una variable o lista de variables
dentro de un bloque PL/pgSQL.

```sql
SELECT name, stock INTO v_name, v_stock FROM products WHERE id = p_id;
```

---

## SQLERRM

Variable especial disponible dentro de un bloque `EXCEPTION` que
contiene el texto descriptivo del último error capturado.

---

## SQLSTATE

Código estándar de 5 caracteres que identifica el tipo de error.
Ejemplo: `'23514'` = check_violation, `'23503'` = foreign_key_violation.
