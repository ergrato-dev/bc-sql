-- ============================================
-- Semana 17: Transacciones y ACID
-- Ejercicio 01 — BEGIN, COMMIT y ROLLBACK
-- Motor: PostgreSQL 16
-- ============================================

-- ============================================
-- PASO 1: Ver saldos iniciales
-- ============================================

-- Consulta los saldos antes de cualquier modificación
-- Descomenta las siguientes líneas:

-- SELECT
--     id,
--     owner,
--     balance
-- FROM accounts
-- ORDER BY id;


-- ============================================
-- PASO 2: Transferencia exitosa con COMMIT
-- ============================================

-- Transfiere 300 de la cuenta 1 a la cuenta 2
-- Luego verifica que ambos saldos actualizaron
-- Descomenta las siguientes líneas:

-- BEGIN;
--     UPDATE accounts SET balance = balance - 300 WHERE id = 1;
--     UPDATE accounts SET balance = balance + 300 WHERE id = 2;
-- COMMIT;

-- SELECT id, owner, balance FROM accounts ORDER BY id;


-- ============================================
-- PASO 3: Rollback por decisión explícita
-- ============================================

-- Inicia una transferencia pero cancélala antes del COMMIT
-- Verifica que el saldo de la cuenta 3 no cambió
-- Descomenta las siguientes líneas:

-- BEGIN;
--     UPDATE accounts SET balance = balance - 500 WHERE id = 3;
--     ROLLBACK;

-- SELECT id, owner, balance FROM accounts WHERE id = 3;


-- ============================================
-- PASO 4: Rollback por violación de CHECK
-- ============================================

-- Intenta dejar la cuenta 2 en negativo
-- La constraint CHECK provoca error y aborta la transacción
-- Descomenta las siguientes líneas:

-- BEGIN;
--     UPDATE accounts SET balance = balance - 99999 WHERE id = 2;
-- ROLLBACK;

-- SELECT id, owner, balance FROM accounts ORDER BY id;
