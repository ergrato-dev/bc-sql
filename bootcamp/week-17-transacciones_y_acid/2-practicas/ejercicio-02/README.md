# Ejercicio 02 — SAVEPOINT y manejo de errores

## Tema

Usar `SAVEPOINT`, `ROLLBACK TO SAVEPOINT` y `RELEASE SAVEPOINT`
para controlar rollbacks parciales dentro de una única transacción.

## Cómo ejecutar

1. Asegúrate de tener Docker corriendo:
   ```bash
   docker compose -f scripts/docker-compose.yml up -d
   ```
2. Carga el esquema:
   ```bash
   docker compose -f scripts/docker-compose.yml exec -T postgres \
     psql -U bootcamp -d bootcamp_db < bootcamp/week-17-transacciones_y_acid/2-practicas/ejercicio-02/starter/setup.sql
   ```
3. Conecta e interactúa:
   ```bash
   docker compose -f scripts/docker-compose.yml exec postgres \
     psql -U bootcamp -d bootcamp_db
   ```
4. Abre `starter/ejercicio.sql` y sigue los pasos.

---

## Esquema de trabajo

Misma tabla `accounts` del ejercicio anterior.

### Paso 1: SAVEPOINT y rollback parcial

Crea un SAVEPOINT tras el primer INSERT. Luego intenta
insertar un segundo registro inválido y haz ROLLBACK al
SAVEPOINT. Confirma que solo se guardó el primer INSERT.

```sql
BEGIN;
    INSERT INTO accounts (owner, balance) VALUES ('Nuevo A', 500);
    SAVEPOINT sp1;
    INSERT INTO accounts (owner, balance) VALUES ('Inválido', -100);
    ROLLBACK TO SAVEPOINT sp1;
COMMIT;

SELECT * FROM accounts ORDER BY id;
```

**Abre `starter/ejercicio.sql`** y descomenta la sección "PASO 1".

---

### Paso 2: SAVEPOINTs en cadena

Usa dos SAVEPOINTs consecutivos. Haz ROLLBACK solo al segundo,
dejando los cambios anteriores a sp2 pero descartando
los posteriores.

```sql
BEGIN;
    UPDATE accounts SET balance = balance + 100 WHERE id = 1;
    SAVEPOINT sp_a;
    UPDATE accounts SET balance = balance + 200 WHERE id = 2;
    SAVEPOINT sp_b;
    UPDATE accounts SET balance = balance + 300 WHERE id = 3;
    ROLLBACK TO SAVEPOINT sp_b;
    -- id=1 y id=2 tienen sus incrementos; id=3 no
COMMIT;
```

**Descomenta la sección "PASO 2".**

---

### Paso 3: RELEASE SAVEPOINT

Crea un SAVEPOINT, realiza operaciones correctas y luego
libéralo con RELEASE. Verifica que RELEASE no deshace
los cambios; solo elimina el marcador.

```sql
BEGIN;
    UPDATE accounts SET balance = balance - 50 WHERE id = 1;
    SAVEPOINT sp_temporal;
    UPDATE accounts SET balance = balance - 50 WHERE id = 2;
    RELEASE SAVEPOINT sp_temporal;
COMMIT;
```

**Descomenta la sección "PASO 3".**

---

### Paso 4: Transacción compleja con múltiples SAVEPOINTs

Implementa una secuencia realista: crédito, descuento
condicional y reporte final, usando SAVEPOINTs para
revertir solo el descuento si fuera inválido.

```sql
BEGIN;
    UPDATE accounts SET balance = balance + 1000 WHERE id = 3;
    SAVEPOINT antes_descuento;
    UPDATE accounts SET balance = balance - 600  WHERE id = 3;
    -- Verificar si el saldo sigue siendo positivo
    -- Si la cuenta cayó a menos de 500, revertir solo el descuento
    ROLLBACK TO SAVEPOINT antes_descuento;
COMMIT;
```

**Descomenta la sección "PASO 4".**
