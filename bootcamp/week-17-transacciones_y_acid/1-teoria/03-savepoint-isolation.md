# SAVEPOINT y niveles de aislamiento

## Objetivo

Usar `SAVEPOINT` para deshacer sólo parte de una transacción
y conocer los cuatro niveles de aislamiento de PostgreSQL.

## 1. SAVEPOINT

Un `SAVEPOINT` es un marcador interno dentro de una transacción
en curso. Permite deshacer hasta ese punto sin cancelar todo.

```sql
BEGIN;
    INSERT INTO accounts (owner, balance) VALUES ('Ana', 1000);
    SAVEPOINT sp1;
    INSERT INTO accounts (owner, balance) VALUES ('Error', -999);
    -- Deshacemos solo desde sp1 en adelante
    ROLLBACK TO SAVEPOINT sp1;
    -- Ana sí se insertó; Error no
COMMIT;
```

## 2. RELEASE SAVEPOINT

Libera el marcador cuando ya no lo necesitas.

```sql
SAVEPOINT sp1;
-- ... operaciones OK ...
RELEASE SAVEPOINT sp1;   -- borra el marcador, no los cambios
```

## 3. Niveles de aislamiento

PostgreSQL soporta cuatro niveles definidos por el estándar SQL:

| Nivel | Dirty Read | Non-Repeatable | Phantom |
|-------|-----------|----------------|---------|
| READ UNCOMMITTED | Posible* | Posible | Posible |
| READ COMMITTED (defecto) | No | Posible | Posible |
| REPEATABLE READ | No | No | No** |
| SERIALIZABLE | No | No | No |

> *PostgreSQL trata READ UNCOMMITTED igual que READ COMMITTED.
> **PostgreSQL REPEATABLE READ también previene phantoms.

```sql
-- Cambiar el nivel para una transacción
BEGIN TRANSACTION ISOLATION LEVEL REPEATABLE READ;
    SELECT balance FROM accounts WHERE id = 1;
    -- ... otras operaciones ...
COMMIT;
```

## 4. Cuándo usar cada nivel

- **READ COMMITTED**: la mayoría de casos; buen rendimiento
- **REPEATABLE READ**: reportes que leen la misma fila varias veces
- **SERIALIZABLE**: lógica financiera crítica; máxima seguridad

## Checklist de comprensión

1. ¿Qué ocurre si haces `ROLLBACK TO SAVEPOINT sp1` y luego `COMMIT`?
   ¿Se pierden las filas insertadas antes de sp1?
2. ¿Por qué READ UNCOMMITTED no existe realmente en PostgreSQL?
3. ¿En qué nivel puedes ver el INSERT de otra sesión que
   aún no hizo COMMIT?
4. ¿Puedes tener dos SAVEPOINTs con el mismo nombre?

## Referencias

- [PostgreSQL — SAVEPOINT](https://www.postgresql.org/docs/16/sql-savepoint.html)
- [PostgreSQL — Transaction Isolation](https://www.postgresql.org/docs/16/transaction-iso.html)
