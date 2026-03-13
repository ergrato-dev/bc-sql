# Glosario — Semana 17: Transacciones y ACID

Términos SQL ordenados alfabéticamente.

---

## ACID

Acrónimo para las cuatro propiedades que garantizan la fiabilidad
de una transacción: **A**tomicidad, **C**onsistencia, **A**islamiento
y **D**urabilidad.

---

## Atomicidad

Propiedad que asegura que todas las sentencias de una transacción se
ejecutan o ninguna se aplica. No existe resultado intermedio visible.

---

## Aislamiento (Isolation)

Propiedad que garantiza que las transacciones concurrentes no se ven
entre sí hasta que hacen COMMIT. Implementado en PostgreSQL mediante MVCC.

---

## BEGIN

Abre un bloque de transacción explícito. Equivalente a `START TRANSACTION`.

```sql
BEGIN;
```

---

## COMMIT

Confirma y persiste todos los cambios del bloque de transacción actual.

```sql
COMMIT;
```

---

## Consistencia (Consistency)

Propiedad que garantiza que la base de datos pasa de un estado válido
a otro estado válido; las constraints nunca quedan violadas.

---

## Dirty Read

Lectura de datos modificados por una transacción que aún no hizo COMMIT.
PostgreSQL nunca permite dirty reads (ni en READ UNCOMMITTED).

---

## Durabilidad (Durability)

Propiedad que garantiza que un COMMIT persiste en disco aunque el servidor
falle inmediatamente después. Implementado mediante WAL (Write-Ahead Log).

---

## MVCC

*Multi-Version Concurrency Control*. Mecanismo de PostgreSQL que crea
snapshots de datos para que las transacciones concurrentes no bloqueen
mutuamente sus lecturas.

---

## READ COMMITTED

Nivel de aislamiento por defecto en PostgreSQL. Cada sentencia dentro
de la transacción ve los commits que ya ocurrieron al inicio de esa sentencia.

---

## RELEASE SAVEPOINT

Elimina un marcador SAVEPOINT sin deshacer los cambios realizados
después de haberlo creado.

```sql
RELEASE SAVEPOINT sp1;
```

---

## REPEATABLE READ

Nivel de aislamiento en el que todas las sentencias de la transacción
ven el mismo snapshot. Previene dirty reads y non-repeatable reads.

---

## ROLLBACK

Cancela todos los cambios del bloque de transacción actual, devolviendo
la base de datos al estado previo al BEGIN.

```sql
ROLLBACK;
```

---

## ROLLBACK TO SAVEPOINT

Deshace los cambios realizados después de un SAVEPOINT específico
sin cancelar toda la transacción.

```sql
ROLLBACK TO SAVEPOINT sp1;
```

---

## SAVEPOINT

Marcador interno dentro de una transacción abierta que permite
revertir parcialmente hasta ese punto.

```sql
SAVEPOINT nombre;
```

---

## SERIALIZABLE

Nivel de aislamiento más estricto. Las transacciones se comportan como
si se ejecutaran de forma completamente secuencial.

---

## WAL (Write-Ahead Log)

Registro en disco donde PostgreSQL escribe cada cambio antes de aplicarlo
en las páginas de datos. Garantiza la durabilidad ante fallos.
