-- ============================================
-- Semana 18: Funciones y Procedimientos PL/pgSQL
-- Ejercicio 02 — Procedimientos almacenados y EXCEPTION
-- Motor: PostgreSQL 16
-- ============================================

-- ============================================
-- PASO 1: Procedimiento básico con CALL
-- ============================================

-- Crea sp_restock que añade stock a un producto
-- y llámalo con CALL
-- Descomenta las siguientes líneas:

-- CREATE OR REPLACE PROCEDURE sp_restock(p_id INT, p_qty INT)
-- LANGUAGE plpgsql
-- AS $$
-- BEGIN
--     UPDATE products
--     SET stock = stock + p_qty
--     WHERE id = p_id;
--     COMMIT;
-- END;
-- $$;

-- CALL sp_restock(1, 10);
-- SELECT id, name, stock FROM products WHERE id = 1;


-- ============================================
-- PASO 2: Procedimiento con validación y EXCEPTION
-- ============================================

-- Crea sp_sell que verifica el stock antes de descontar
-- Lanza excepción si no hay suficiente stock
-- Descomenta las siguientes líneas:

-- CREATE OR REPLACE PROCEDURE sp_sell(p_id INT, p_qty INT)
-- LANGUAGE plpgsql
-- AS $$
-- DECLARE
--     v_stock INT;
-- BEGIN
--     SELECT stock INTO v_stock FROM products WHERE id = p_id;
--
--     IF v_stock < p_qty THEN
--         RAISE EXCEPTION
--             'Stock insuficiente: disponible=% solicitado=%',
--             v_stock, p_qty;
--     END IF;
--
--     UPDATE products SET stock = stock - p_qty WHERE id = p_id;
--     COMMIT;
-- EXCEPTION
--     WHEN OTHERS THEN
--         RAISE EXCEPTION 'Error en sp_sell: %', SQLERRM;
-- END;
-- $$;

-- CALL sp_sell(4, 1);    -- Debe funcionar (Escritorio, stock=3)
-- CALL sp_sell(4, 100);  -- Debe lanzar excepción


-- ============================================
-- PASO 3: Procedimiento con log de auditoría
-- ============================================

-- Crea sp_sell_audited que registra cada venta en audit_log
-- Descomenta las siguientes líneas:

-- CREATE OR REPLACE PROCEDURE sp_sell_audited(p_id INT, p_qty INT)
-- LANGUAGE plpgsql
-- AS $$
-- DECLARE
--     v_name  TEXT;
--     v_stock INT;
-- BEGIN
--     SELECT name, stock INTO v_name, v_stock
--     FROM products WHERE id = p_id;
--
--     IF v_stock < p_qty THEN
--         INSERT INTO audit_log (action, detail)
--         VALUES ('SELL_FAILED',
--                 FORMAT('id=%s qty_requested=%s stock=%s',
--                        p_id, p_qty, v_stock));
--         COMMIT;
--         RAISE EXCEPTION 'Stock insuficiente para %', v_name;
--     END IF;
--
--     UPDATE products SET stock = stock - p_qty WHERE id = p_id;
--
--     INSERT INTO audit_log (action, detail)
--     VALUES ('SELL_OK',
--             FORMAT('product=%s qty=%s', v_name, p_qty));
--     COMMIT;
-- END;
-- $$;

-- CALL sp_sell_audited(2, 5);
-- SELECT * FROM audit_log ORDER BY id DESC LIMIT 5;


-- ============================================
-- PASO 4: Bloque DO anónimo
-- ============================================

-- Usa DO para reabastecer todos los productos
-- con stock menor a 5 llamando a sp_restock
-- Descomenta las siguientes líneas:

-- DO $$
-- DECLARE
--     rec RECORD;
-- BEGIN
--     FOR rec IN
--         SELECT id, name, stock FROM products WHERE stock < 5
--     LOOP
--         CALL sp_restock(rec.id, 20);
--         RAISE NOTICE 'Reabastecido: % (era %)', rec.name, rec.stock;
--     END LOOP;
-- END;
-- $$;

-- SELECT id, name, stock FROM products ORDER BY stock;
