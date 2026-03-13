# Glosario — Semana 20: LATERAL Joins

Términos clave ordenados alfabéticamente.

---

## C

**correlación**
Referencia a columnas de una tabla externa dentro de una subquery.
En SQL estándar solo se permite en la cláusula `WHERE`; con `LATERAL`
también se permite en `FROM`.

**CROSS JOIN LATERAL**
Variante de `LATERAL` sin condición `ON`. Equivale a
`JOIN LATERAL ... ON TRUE`. La subquery se evalúa por cada fila izquierda.
```sql
SELECT e.name, s.total FROM employees e
CROSS JOIN LATERAL (SELECT SUM(amount) AS total FROM sales
                    WHERE employee_id = e.id) AS s;
```

---

## J

**JOIN LATERAL**
Extensión de SQL que permite que una subquery o función en `FROM`
haga referencia a columnas de tablas anteriores en la misma cláusula.
```sql
FROM tabla1 t1
JOIN LATERAL (SELECT ... WHERE col = t1.id LIMIT 1) AS sub ON TRUE
```

---

## L

**LATERAL**
Palabra clave que habilita correlación dentro de `FROM`.
Sin `LATERAL`, una subquery en `FROM` no puede ver columnas
de otras tablas definidas en el mismo `FROM`.

**LEFT JOIN LATERAL**
Igual que `JOIN LATERAL` pero conserva las filas de la tabla izquierda
aunque la subquery no retorne resultados (`NULL` en columnas de la subquery).

---

## R

**RETURNS TABLE**
Cláusula de una función PL/pgSQL o SQL que indica que retorna
múltiples filas con columnas tipadas. Puede usarse con `LATERAL`
en `FROM`.
```sql
CREATE FUNCTION fn_items(p_id INT)
RETURNS TABLE (name TEXT, qty INT) LANGUAGE sql AS $$
    SELECT name, qty FROM items WHERE group_id = p_id;
$$;
```

---

## S

**subquery correlacionada**
Subquery que hace referencia a columnas de la query exterior.
Se re-evalúa por cada fila. Con `LATERAL` se puede colocar en `FROM`,
no solo en `WHERE` o `SELECT`.

---

## T

**Top-N por grupo**
Patrón de consulta para obtener los N registros con mayor valor
de una métrica, agrupados por una categoría.
Implementable con `ROW_NUMBER()` o con `JOIN LATERAL ... LIMIT N`.

---

## U

**unnest()**
Función de PostgreSQL que expande un array a un conjunto de filas.
Combinada con `WITH ORDINALITY` retorna también la posición.
```sql
SELECT val, pos FROM unnest(ARRAY['a','b','c'])
    WITH ORDINALITY AS t(val, pos);
```

**WITH ORDINALITY**
Modificador de funciones tabulares que agrega una columna de posición
(número de fila dentro del resultado de la función).
