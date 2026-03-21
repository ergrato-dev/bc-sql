-- Semana 24: Proyecto Integrador Final
-- ejercicio.sql — Ejercicio 02 (starter)
-- Motor: PostgreSQL 16
-- Instrucciones: descomenta cada sección cuando llegues al paso correspondiente
-- ============================================

-- ============================================
-- PASO 1: Trigger de auditoría AFTER
-- ============================================

-- Crea la función y el trigger de auditoría para la tabla products
-- Descomenta las siguientes líneas:

-- CREATE OR REPLACE FUNCTION fn_audit_products()
-- RETURNS TRIGGER LANGUAGE plpgsql AS $$
-- BEGIN
--     INSERT INTO audit_log (table_name, action, record_id)
--     VALUES (TG_TABLE_NAME, TG_OP, COALESCE(NEW.id, OLD.id));
--     RETURN NEW;
-- END;
-- $$;

-- CREATE TRIGGER trg_audit_products
--     AFTER INSERT OR UPDATE OR DELETE ON products
--     FOR EACH ROW EXECUTE FUNCTION fn_audit_products();

-- Prueba el trigger insertando y luego actualizando un producto:
-- INSERT INTO products (category_id, name, description, price, stock)
-- VALUES (1, 'Producto de Prueba', 'Solo para probar el trigger', 9.99, 5);

-- UPDATE products SET stock = 0 WHERE name = 'Producto de Prueba';

-- Verifica que audit_log tiene registros:
-- SELECT * FROM audit_log ORDER BY changed_at DESC LIMIT 5;


-- ============================================
-- PASO 2: Trigger de validación BEFORE UPDATE
-- ============================================

-- Impide reducir el precio en más del 50% en un solo UPDATE
-- Descomenta las siguientes líneas:

-- CREATE OR REPLACE FUNCTION fn_validate_price()
-- RETURNS TRIGGER LANGUAGE plpgsql AS $$
-- BEGIN
--     IF NEW.price < OLD.price * 0.5 THEN
--         RAISE EXCEPTION
--             'Precio inválido: no se puede reducir el precio en más del 50%%.'
--             ' Precio actual: %, Nuevo: %', OLD.price, NEW.price;
--     END IF;
--     RETURN NEW;
-- END;
-- $$;

-- CREATE TRIGGER trg_validate_price
--     BEFORE UPDATE OF price ON products
--     FOR EACH ROW EXECUTE FUNCTION fn_validate_price();

-- Prueba: esta actualización debe fallar:
-- UPDATE products SET price = 1.00 WHERE name = 'Silla Ergonómica Mesh';

-- Esta debe funcionar (reducción del 20%):
-- UPDATE products SET price = 240.00 WHERE name = 'Silla Ergonómica Mesh';


-- ============================================
-- PASO 3: jsonb_set — actualizar campo JSONB
-- ============================================

-- Agrega un campo 'stock_alert' = true en atributos de productos con pocos items
-- Descomenta las siguientes líneas:

-- UPDATE products
-- SET attributes = jsonb_set(attributes, '{stock_alert}', 'true', true)
-- WHERE stock < 50;

-- SELECT name, stock, attributes->'stock_alert' AS alert
-- FROM products
-- WHERE (attributes->>'stock_alert')::BOOLEAN = TRUE;


-- ============================================
-- PASO 4: Reporte consolidado con jsonb_agg
-- ============================================

-- Construye un documento JSON por cliente con sus pedidos
-- Descomenta las siguientes líneas:

-- SELECT
--     c.id,
--     c.name,
--     jsonb_build_object(
--         'total_orders',  COUNT(o.id),
--         'total_spent',   SUM(o.total_amount),
--         'orders',        jsonb_agg(
--             jsonb_build_object(
--                 'id',     o.id,
--                 'status', o.status,
--                 'amount', o.total_amount
--             ) ORDER BY o.created_at
--         )
--     ) AS summary
-- FROM customers c
-- JOIN orders o ON o.customer_id = c.id
-- GROUP BY c.id, c.name
-- ORDER BY c.name;
