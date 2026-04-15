# Ejercicio 01 — BEGIN, COMMIT y ROLLBACK

## Tema

Controlar transacciones explícitas para garantizar la atomicidad
de operaciones financieras.

## Cómo ejecutar

1. Asegúrate de tener Docker corriendo:
   ```bash
   docker compose -f scripts/docker-compose.yml up -d
   ```
2. Carga el esquema:
   ```bash
   docker compose -f scripts/docker-compose.yml exec -T postgres \
     psql -U bootcamp -d bootcamp_db < bootcamp/week-17-transacciones_y_acid/2-practicas/ejercicio-01/starter/setup.sql
   ```
3. Conecta e interactúa:
   ```bash
   docker compose -f scripts/docker-compose.yml exec postgres \
     psql -U bootcamp -d bootcamp_db
   ```
4. Abre `starter/ejercicio.sql` y sigue los pasos.

---

## Esquema de trabajo

Tabla `accounts` con tres cuentas bancarias.

### Paso 1: Ver saldos iniciales

Antes de modificar nada, consulta el estado de las cuentas
para tener un punto de referencia.

```sql
SELECT id, owner, balance
FROM accounts
ORDER BY id;
```

**Abre `starter/ejercicio.sql`** y descomenta la sección "PASO 1".

---

### Paso 2: Transferencia exitosa con COMMIT

Transfiere 300 de la cuenta 1 a la cuenta 2 dentro de un bloque
`BEGIN … COMMIT`. Luego verifica que ambos saldos cambiaron.

```sql
BEGIN;
    UPDATE accounts SET balance = balance - 300 WHERE id = 1;
    UPDATE accounts SET balance = balance + 300 WHERE id = 2;
COMMIT;

SELECT id, owner, balance FROM accounts ORDER BY id;
```

**Descomenta la sección "PASO 2".**

---

### Paso 3: Rollback por decisión explícita

Inicia una transferencia de 500 desde la cuenta 3, pero
antes de hacer COMMIT decide cancelarla con ROLLBACK.
Verifica que el saldo de la cuenta 3 no cambió.

```sql
BEGIN;
    UPDATE accounts SET balance = balance - 500 WHERE id = 3;
    -- Cambiamos de opinión: cancelamos
    ROLLBACK;

SELECT id, owner, balance FROM accounts WHERE id = 3;
```

**Descomenta la sección "PASO 3".**

---

### Paso 4: Rollback automático por violación de CHECK

Intenta dejar el saldo de la cuenta 2 en negativo.
La constraint `CHECK (balance >= 0)` provoca un error
y PostgreSQL cancela toda la transacción.

```sql
BEGIN;
    UPDATE accounts SET balance = balance - 99999 WHERE id = 2;
    -- El error anterior deja la transacción en estado de aborto
    -- Debes cerrar con ROLLBACK antes de cualquier nueva sentencia
ROLLBACK;

SELECT id, owner, balance FROM accounts ORDER BY id;
```

**Descomenta la sección "PASO 4".**
