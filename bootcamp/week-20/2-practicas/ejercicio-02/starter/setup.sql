-- ============================================
-- Semana 20: LATERAL Joins
-- Ejercicio 02 — Configuración del esquema
-- Motor: PostgreSQL 16
-- ============================================

DROP TABLE IF EXISTS order_items;
DROP TABLE IF EXISTS products;
DROP TABLE IF EXISTS categories;

CREATE TABLE categories (
    id      SERIAL  PRIMARY KEY,
    name    TEXT    NOT NULL
);

CREATE TABLE products (
    id              SERIAL  PRIMARY KEY,
    name            TEXT    NOT NULL,
    category_id     INT     NOT NULL REFERENCES categories (id),
    price           NUMERIC(10, 2) NOT NULL CHECK (price > 0),
    tags            TEXT[]  NOT NULL DEFAULT '{}'
);

CREATE TABLE order_items (
    id          SERIAL  PRIMARY KEY,
    product_id  INT     NOT NULL REFERENCES products (id),
    quantity    INT     NOT NULL CHECK (quantity > 0),
    ordered_at  DATE    NOT NULL DEFAULT CURRENT_DATE
);

INSERT INTO categories (name)
VALUES ('Electronics'), ('Furniture'), ('Clothing');

INSERT INTO products (name, category_id, price, tags)
VALUES
    ('Laptop Pro',       1, 1299.99, ARRAY['portable','high-performance']),
    ('Monitor 4K',       1,  449.00, ARRAY['display','4k','wide']),
    ('Teclado Mecánico', 1,   89.99, ARRAY['peripherals','mechanical']),
    ('Mouse Inalámbrico',1,   45.00, ARRAY['peripherals','wireless']),
    ('Auriculares BT',   1,  129.00, ARRAY['audio','bluetooth']),
    ('Escritorio Exec',  2,  320.00, ARRAY['office','wood']),
    ('Silla Ergonómica', 2,  560.00, ARRAY['ergonomic','office']),
    ('Estantería',       2,  180.00, ARRAY['storage','wood']),
    ('Camisa L',         3,   45.00, ARRAY['tops','casual']),
    ('Jeans Slim',       3,   79.00, ARRAY['bottoms','denim']),
    ('Zapatillas Run',   3,  110.00, ARRAY['footwear','sport']);

INSERT INTO order_items (product_id, quantity, ordered_at)
VALUES
    (1,  42, '2024-01-10'), (1,  38, '2024-02-12'), (1,  55, '2024-03-05'),
    (2,  31, '2024-01-15'), (2,  27, '2024-02-20'),
    (3,  18, '2024-01-22'), (3,  22, '2024-03-10'), (3,  16, '2024-04-01'),
    (4,  10, '2024-02-08'), (4,   8, '2024-03-18'),
    (5,  25, '2024-01-30'), (5,  19, '2024-02-25'),
    (6,  19, '2024-01-12'), (6,  17, '2024-02-14'), (6,  21, '2024-03-22'),
    (7,  18, '2024-01-18'), (7,  15, '2024-02-28'),
    (8,   9, '2024-03-05'), (8,  12, '2024-04-10'),
    (9,  54, '2024-01-06'), (9,  48, '2024-02-10'), (9,  43, '2024-03-15'),
    (10, 43, '2024-01-20'), (10, 39, '2024-02-22'), (10, 37, '2024-03-28'),
    (11, 31, '2024-01-25'), (11, 28, '2024-02-18');
