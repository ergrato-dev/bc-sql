# Glosario — Semana 23: Optimización y EXPLAIN ANALYZE

Términos SQL y PostgreSQL ordenados alfabéticamente.

---

## ANALYZE

Comando que actualiza las estadísticas de distribución de datos de una
tabla. Las estadísticas son usadas por el planificador para elegir el
mejor plan de ejecución.

```sql
ANALYZE orders;
```

---

## cost = X..Y

Campo del plan de ejecución. `X` = costo de retornar la primera fila.
`Y` = costo total estimado para retornar todas las filas. El costo no
es tiempo en segundos; es una unidad relativa configurable.

---

## EXPLAIN

Muestra el plan de ejecución estimado de una sentencia SQL sin ejecutarla.

```sql
EXPLAIN SELECT * FROM orders WHERE status = 'pending';
```

---

## EXPLAIN ANALYZE

Ejecuta la sentencia y muestra el plan estimado **y** los tiempos reales.

```sql
EXPLAIN ANALYZE SELECT * FROM orders WHERE status = 'pending';
```

---

## Index Only Scan

Plan de ejecución donde todas las columnas del `SELECT` están en el índice.
No accede a la tabla (heap). Es el scan más eficiente.

---

## Index Scan

Plan de ejecución donde PostgreSQL usa el índice para encontrar los
punteros a filas y luego accede a la tabla para recuperar columnas adicionales.

---

## índice compuesto

Índice sobre dos o más columnas. Útil para consultas con filtros por
múltiples columnas simultáneamente. Las columnas más selectivas van primero.

```sql
CREATE INDEX idx ON orders (region, status);
```

---

## índice cubriente (covering index)

Índice que contiene todas las columnas que necesita una consulta.
Permite Index Only Scan evitando leer la tabla.

---

## índice funcional

Índice sobre el resultado de una expresión o función en lugar de una columna.

```sql
CREATE INDEX idx_lower_name ON customers (LOWER(name));
```

---

## índice parcial

Índice que solo incluye filas que satisfacen una condición WHERE.
Más pequeño y más rápido de mantener.

```sql
CREATE INDEX idx_pending ON orders (created_at) WHERE status = 'pending';
```

---

## pg_indexes

Vista del sistema que lista todos los índices de la base de datos con
su definición DDL.

---

## pg_stat_user_tables

Vista del sistema con estadísticas de uso de tablas de usuario.
Incluye filas vivas, filas muertas y fecha del último ANALYZE.

---

## Seq Scan

Plan de ejecución donde PostgreSQL lee la tabla completa fila por fila.
Eficiente cuando se recupera una fracción grande de las filas.

---

## VACUUM

Comando que recupera espacio ocupado por filas eliminadas o actualizadas
(filas muertas). `VACUUM ANALYZE` hace ambas operaciones.

```sql
VACUUM ANALYZE orders;
```
