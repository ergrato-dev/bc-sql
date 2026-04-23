-- ============================================================
-- DEMOS INSTRUCTOR — Semana 24: Proyecto Integrador Final
-- Base de datos: northwind (PostgreSQL 16 · Docker)
-- ⚠️  SOLO USO INTERNO — No compartir con aprendices
-- ============================================================
-- Conectar al contenedor:
--   docker compose -f scripts/docker-compose.yml exec postgres \
--     psql -U bootcamp -d northwind
-- ============================================================
-- PROPÓSITO: Demo de live-coding de referencia que integra
--   TODOS los conceptos del bootcamp sobre datos reales.
--   Usar como modelo para evaluar el nivel del proyecto final.
-- ============================================================


-- ════════════════════════════════════════════════════════════
-- MÓDULO 1: Diseño y calidad del esquema
-- ════════════════════════════════════════════════════════════

-- Ver el modelo relacional completo
SELECT
    tc.table_name,
    kcu.column_name,
    ccu.table_name  AS referencia_tabla,
    ccu.column_name AS referencia_columna
FROM information_schema.table_constraints tc
JOIN information_schema.key_column_usage   kcu ON tc.constraint_name = kcu.constraint_name
JOIN information_schema.constraint_column_usage ccu ON tc.constraint_name = ccu.constraint_name
WHERE tc.constraint_type = 'FOREIGN KEY'
ORDER BY tc.table_name;


-- ════════════════════════════════════════════════════════════
-- MÓDULO 2: Análisis de ventas completo (CTEs encadenadas)
-- ════════════════════════════════════════════════════════════
WITH
ventas_linea AS (
    SELECT
        o.order_id,
        o.customer_id,
        o.employee_id,
        DATE_TRUNC('month', o.order_date)::DATE   AS mes,
        p.category_id,
        od.product_id,
        ROUND(od.unit_price * od.quantity * (1 - od.discount), 2) AS importe
    FROM orders o
    JOIN order_details od ON o.order_id   = od.order_id
    JOIN products      p  ON od.product_id = p.product_id
),
ventas_categoria_mes AS (
    SELECT
        mes,
        cat.category_name,
        ROUND(SUM(importe), 2)  AS ventas,
        COUNT(DISTINCT order_id) AS pedidos
    FROM ventas_linea vl
    JOIN categories cat ON vl.category_id = cat.category_id
    GROUP BY mes, cat.category_name
),
ranked AS (
    SELECT *,
           RANK() OVER (PARTITION BY mes ORDER BY ventas DESC)   AS rk_mes,
           LAG(ventas)  OVER (PARTITION BY category_name ORDER BY mes) AS ventas_mes_ant,
           SUM(ventas)  OVER (PARTITION BY category_name ORDER BY mes
               ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS acumulado
    FROM ventas_categoria_mes
)
SELECT
    mes,
    category_name,
    ventas,
    ventas_mes_ant,
    ROUND((ventas - ventas_mes_ant) / NULLIF(ventas_mes_ant, 0) * 100, 1) AS variacion_pct,
    acumulado,
    rk_mes AS ranking_en_mes
FROM ranked
ORDER BY mes, rk_mes;


-- ════════════════════════════════════════════════════════════
-- MÓDULO 3: Jerarquía de empleados + performance
-- ════════════════════════════════════════════════════════════
WITH RECURSIVE org AS (
    SELECT employee_id, first_name || ' ' || last_name AS nombre,
           reports_to, 0 AS nivel
    FROM employees WHERE reports_to IS NULL
    UNION ALL
    SELECT e.employee_id, e.first_name || ' ' || e.last_name,
           e.reports_to, o.nivel + 1
    FROM employees e JOIN org o ON e.reports_to = o.employee_id
),
performance AS (
    SELECT
        employee_id,
        COUNT(DISTINCT order_id)                                   AS pedidos,
        ROUND(SUM(od.unit_price * od.quantity * (1 - od.discount)), 2) AS ventas
    FROM orders o JOIN order_details od USING(order_id)
    GROUP BY employee_id
)
SELECT
    repeat('  ', nivel) || o.nombre  AS organigrama,
    o.nivel,
    p.pedidos,
    p.ventas,
    CASE
        WHEN p.ventas >= 100000 THEN 'Top'
        WHEN p.ventas >= 60000  THEN 'Mid'
        ELSE                        'Dev'
    END AS tier
FROM org o
JOIN performance p USING(employee_id)
ORDER BY o.nivel, p.ventas DESC;


-- ════════════════════════════════════════════════════════════
-- MÓDULO 4: Función + Vista + Índice
-- ════════════════════════════════════════════════════════════

-- Función de reporte de cliente
CREATE OR REPLACE FUNCTION fn_resumen_cliente(p_customer_id TEXT)
RETURNS TABLE (
    total_pedidos   BIGINT,
    total_facturado NUMERIC,
    primer_pedido   DATE,
    ultimo_pedido   DATE,
    producto_top    TEXT
)
LANGUAGE plpgsql AS $$
BEGIN
    RETURN QUERY
    WITH base AS (
        SELECT o.order_id, o.order_date::DATE,
               od.product_id,
               od.unit_price * od.quantity * (1 - od.discount) AS importe
        FROM orders o JOIN order_details od USING(order_id)
        WHERE o.customer_id = p_customer_id
    ),
    top_prod AS (
        SELECT p.product_name
        FROM base b JOIN products p USING(product_id)
        GROUP BY p.product_name
        ORDER BY SUM(b.importe) DESC
        LIMIT 1
    )
    SELECT
        COUNT(DISTINCT b.order_id),
        ROUND(SUM(b.importe), 2),
        MIN(b.order_date),
        MAX(b.order_date),
        (SELECT product_name FROM top_prod)
    FROM base b;
END;
$$;

-- Probar:
SELECT * FROM fn_resumen_cliente('ALFKI');
SELECT * FROM fn_resumen_cliente('QUICK');

-- Vista materializada del ranking de clientes
CREATE OR REPLACE VIEW v_ranking_clientes AS
SELECT
    c.customer_id,
    c.company_name,
    c.country,
    COUNT(DISTINCT o.order_id)                                    AS pedidos,
    ROUND(SUM(od.unit_price * od.quantity * (1 - od.discount)), 2) AS facturado,
    RANK() OVER (ORDER BY SUM(od.unit_price * od.quantity * (1 - od.discount)) DESC) AS ranking
FROM customers c
JOIN orders o        ON c.customer_id = o.customer_id
JOIN order_details od ON o.order_id   = od.order_id
GROUP BY c.customer_id, c.company_name, c.country;

SELECT * FROM v_ranking_clientes WHERE ranking <= 10;

-- Limpiar objetos de demo
DROP FUNCTION IF EXISTS fn_resumen_cliente(TEXT);
DROP VIEW    IF EXISTS v_ranking_clientes;
