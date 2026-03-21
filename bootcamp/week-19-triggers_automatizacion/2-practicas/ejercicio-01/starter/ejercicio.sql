-- ============================================
-- Semana 19: Triggers
-- Ejercicio 01 — Trigger de auditoría AFTER INSERT/UPDATE/DELETE
-- Motor: PostgreSQL 16
-- ============================================

-- ============================================
-- PASO 1: Crear la trigger function de auditoría
-- ============================================

-- Crea fn_audit_changes que registra la operación en audit_log
-- usando TG_TABLE_NAME y TG_OP
-- Descomenta las siguientes líneas:

-- CREATE OR REPLACE FUNCTION fn_audit_changes()
-- RETURNS TRIGGER
-- LANGUAGE plpgsql
-- AS $$
-- BEGIN
--     INSERT INTO audit_log (table_name, action, record_id, detail)
--     VALUES (
--         TG_TABLE_NAME,
--         TG_OP,
--         COALESCE(NEW.id, OLD.id),
--         FORMAT('old_price=%s new_price=%s',
--                OLD.price, NEW.price)
--     );
--     RETURN NULL;
-- END;
-- $$;


-- ============================================
-- PASO 2: Crear el trigger AFTER y probarlo
-- ============================================

-- Asocia fn_audit_changes a products y verifica con INSERT
-- Descomenta las siguientes líneas:

-- CREATE TRIGGER trg_audit_products
-- AFTER INSERT OR UPDATE OR DELETE ON products
-- FOR EACH ROW EXECUTE FUNCTION fn_audit_changes();

-- INSERT INTO products (name, price, stock, category)
-- VALUES ('Test item', 99.00, 5, 'test');

-- SELECT * FROM audit_log ORDER BY id DESC LIMIT 3;


-- ============================================
-- PASO 3: UPDATE y DELETE — verificar en log
-- ============================================

-- Actualiza el precio y luego elimina el registro de prueba
-- Consulta el log para ver los tres eventos registrados
-- Descomenta las siguientes líneas:

-- UPDATE products SET price = 120.00 WHERE name = 'Test item';
-- DELETE FROM products WHERE name = 'Test item';

-- SELECT
--     table_name,
--     action,
--     record_id,
--     detail,
--     executed_at
-- FROM audit_log
-- ORDER BY id DESC
-- LIMIT 5;


-- ============================================
-- PASO 4: Deshabilitar y habilitar el trigger
-- ============================================

-- Deshabilita el trigger, realiza un cambio masivo,
-- verifica que no hay nuevos logs, y vuelve a habilitarlo
-- Descomenta las siguientes líneas:

-- ALTER TABLE products DISABLE TRIGGER trg_audit_products;

-- UPDATE products SET price = price * 1.1 WHERE category = 'furniture';

-- SELECT COUNT(*) AS nuevos_logs FROM audit_log
-- WHERE executed_at > NOW() - INTERVAL '5 seconds';

-- ALTER TABLE products ENABLE TRIGGER trg_audit_products;
