-- ============================================
-- 03-northwind-create.sql
-- Crea la base de datos Northwind (base de datos de ejemplo).
-- Se ejecuta automáticamente en el primer arranque del contenedor.
-- ============================================

-- Northwind: dominio de empresa de importación/exportación
-- Tablas: categories, customers, employees, orders, order_details,
--         products, shippers, suppliers, territories, regions
-- Fuente: https://github.com/pthom/northwind_psql

CREATE DATABASE northwind
    ENCODING = 'UTF8'
    LC_COLLATE = 'en_US.UTF-8'
    LC_CTYPE = 'en_US.UTF-8'
    TEMPLATE = template0;
