-- ============================================================
-- DEMOS INSTRUCTOR — Semana 05: Operadores y filtros
-- Base de datos: northwind (PostgreSQL 16 · Docker)
-- ⚠️  SOLO USO INTERNO — No compartir con aprendices
-- ============================================================
-- Conectar al contenedor:
--   docker compose -f scripts/docker-compose.yml exec postgres \
--     psql -U bootcamp -d northwind
-- ============================================================


-- ── 1. Operadores de comparación ─────────────────────────────

-- Productos con precio mayor a 50
SELECT product_name, unit_price FROM products WHERE unit_price > 50 ORDER BY unit_price;

-- Productos descontinuados (boolean)
SELECT product_name, discontinued FROM products WHERE discontinued = TRUE;

-- Empleados contratados antes del año 1993
SELECT first_name, last_name, hire_date FROM employees WHERE hire_date < '1993-01-01';


-- ── 2. BETWEEN ───────────────────────────────────────────────
-- Productos con precio entre $10 y $30:
SELECT product_name, unit_price
FROM products
WHERE unit_price BETWEEN 10 AND 30
ORDER BY unit_price;

-- Pedidos realizados durante el año 1997:
SELECT order_id, customer_id, order_date
FROM orders
WHERE order_date BETWEEN '1997-01-01' AND '1997-12-31'
ORDER BY order_date;


-- ── 3. IN ────────────────────────────────────────────────────
-- Clientes de países específicos:
SELECT company_name, city, country
FROM customers
WHERE country IN ('Germany', 'France', 'UK')
ORDER BY country, city;

-- Pedidos atendidos por empleados 1, 3 o 5:
SELECT order_id, employee_id, order_date
FROM orders
WHERE employee_id IN (1, 3, 5)
ORDER BY employee_id;


-- ── 4. NOT IN ────────────────────────────────────────────────
-- Proveedores fuera de América del Norte:
SELECT company_name, country
FROM suppliers
WHERE country NOT IN ('USA', 'Canada', 'Mexico')
ORDER BY country;


-- ── 5. LIKE ──────────────────────────────────────────────────
-- % = cualquier cantidad de caracteres; _ = exactamente uno

-- Productos que comienzan con 'Ch':
SELECT product_name FROM products WHERE product_name LIKE 'Ch%';

-- Productos que contienen 'sauce' en cualquier posición:
SELECT product_name FROM products WHERE LOWER(product_name) LIKE '%sauce%';

-- Clientes cuyo contacto tiene el título "Sales%":
SELECT company_name, contact_name, contact_title
FROM customers
WHERE contact_title LIKE 'Sales%';


-- ── 6. AND / OR / NOT ────────────────────────────────────────
-- Productos caros Y con poco stock (urgentes para reordenar):
SELECT product_name, unit_price, units_in_stock
FROM products
WHERE unit_price > 30
  AND units_in_stock < 15
  AND discontinued = FALSE
ORDER BY units_in_stock;

-- Clientes de España O Portugal:
SELECT company_name, country
FROM customers
WHERE country = 'Spain' OR country = 'Portugal';

-- Precaución: paréntesis cuando mezclas AND y OR
SELECT product_name, unit_price, discontinued
FROM products
WHERE (unit_price > 50 OR units_in_stock < 5)
  AND discontinued = FALSE;
