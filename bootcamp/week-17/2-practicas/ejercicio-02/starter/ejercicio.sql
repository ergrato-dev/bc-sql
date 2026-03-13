-- ============================================
-- Semana 17: Transacciones y ACID
-- Ejercicio 02 — SAVEPOINT y manejo de errores
-- Motor: PostgreSQL 16
-- ============================================

-- ============================================
-- PASO 1: SAVEPOINT y rollback parcial
-- ============================================

-- Inserta un registro, crea un SAVEPOINT, luego intenta
-- insertar uno inválido y revierte solo ese último
-- Descomenta las siguientes líneas:

-- BEGIN;
--     INSERT INTO accounts (owner, balance) VALUES ('Nuevo A', 500.00);
--     SAVEPOINT sp1;
--     INSERT INTO accounts (owner, balance) VALUES ('Inválido', -100.00);
--     ROLLBACK TO SAVEPOINT sp1;
-- COMMIT;

-- SELECT * FROM accounts ORDER BY id;


-- ============================================
-- PASO 2: SAVEPOINTs en cadena
-- ============================================

-- Actualiza tres cuentas con SAVEPOINTs intermedios,
-- luego revierte solo la última actualización
-- Descomenta las siguientes líneas:

-- BEGIN;
--     UPDATE accounts SET balance = balance + 100 WHERE id = 1;
--     SAVEPOINT sp_a;
--     UPDATE accounts SET balance = balance + 200 WHERE id = 2;
--     SAVEPOINT sp_b;
--     UPDATE accounts SET balance = balance + 300 WHERE id = 3;
--     ROLLBACK TO SAVEPOINT sp_b;
-- COMMIT;

-- SELECT id, owner, balance FROM accounts ORDER BY id;


-- ============================================
-- PASO 3: RELEASE SAVEPOINT
-- ============================================

-- Crea un SAVEPOINT, realiza cambios válidos y libéralo
-- Verifica que RELEASE no deshace los cambios
-- Descomenta las siguientes líneas:

-- BEGIN;
--     UPDATE accounts SET balance = balance - 50 WHERE id = 1;
--     SAVEPOINT sp_temporal;
--     UPDATE accounts SET balance = balance - 50 WHERE id = 2;
--     RELEASE SAVEPOINT sp_temporal;
-- COMMIT;

-- SELECT id, owner, balance FROM accounts ORDER BY id;


-- ============================================
-- PASO 4: Transacción compleja con múltiples SAVEPOINTs
-- ============================================

-- Aplica un crédito a la cuenta 3, luego un descuento condicional
-- Si el saldo quedaría bajo cierto umbral, revierte solo el descuento
-- Descomenta las siguientes líneas:

-- BEGIN;
--     UPDATE accounts SET balance = balance + 1000 WHERE id = 3;
--     SAVEPOINT antes_descuento;
--     UPDATE accounts SET balance = balance - 600  WHERE id = 3;
--     -- Revertimos el descuento para proteger el saldo mínimo
--     ROLLBACK TO SAVEPOINT antes_descuento;
-- COMMIT;

-- SELECT id, owner, balance FROM accounts WHERE id = 3;
