-- ============================================
-- Semana 01: Introducción a Bases de Datos Relacionales
-- Setup — Ejercicio 01
-- ============================================

-- Tabla de categorías
CREATE TABLE IF NOT EXISTS categories (
    id   INTEGER PRIMARY KEY,
    name TEXT    NOT NULL UNIQUE
);

-- Tabla de productos
CREATE TABLE IF NOT EXISTS products (
    id          INTEGER PRIMARY KEY,
    name        TEXT    NOT NULL,
    price       REAL    NOT NULL,
    stock       INTEGER NOT NULL DEFAULT 0,
    category_id INTEGER,
    FOREIGN KEY (category_id) REFERENCES categories(id)
);

-- Datos de prueba: categorías
INSERT INTO categories (id, name) VALUES
    (1, 'stationery'),
    (2, 'bags'),
    (3, 'electronics'),
    (4, 'books');

-- Datos de prueba: productos
INSERT INTO products (id, name, price, stock, category_id) VALUES
    (1,  'Notebook',        15.99,  120, 1),
    (2,  'Pen',              2.50,  500, 1),
    (3,  'Backpack',        45.00,   30, 2),
    (4,  'Laptop Stand',    29.99,   15, 3),
    (5,  'USB-C Hub',       39.99,   25, 3),
    (6,  'Sticky Notes',     4.75,  200, 1),
    (7,  'SQL for Dummies', 24.90,   10, 4),
    (8,  'Tote Bag',        18.00,   40, 2),
    (9,  'Highlighter Set',  8.50,   75, 1),
    (10, 'Python Crash Course', 32.00, 8, 4);
