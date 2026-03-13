-- Semana 24: Proyecto Integrador Final
-- setup.sql — Ejercicio 01: Esquema integrador
-- Motor: PostgreSQL 16
-- ============================================

-- Limpieza previa
DROP TABLE IF EXISTS order_items  CASCADE;
DROP TABLE IF EXISTS orders       CASCADE;
DROP TABLE IF EXISTS products     CASCADE;
DROP TABLE IF EXISTS categories   CASCADE;
DROP TABLE IF EXISTS customers    CASCADE;

-- ============================================
-- TABLAS
-- ============================================

CREATE TABLE categories (
    id        SERIAL       PRIMARY KEY,
    name      TEXT         NOT NULL UNIQUE,
    is_active BOOLEAN      NOT NULL DEFAULT TRUE
);

CREATE TABLE products (
    id             SERIAL          PRIMARY KEY,
    category_id    INTEGER         NOT NULL REFERENCES categories(id),
    name           TEXT            NOT NULL,
    description    TEXT            NOT NULL DEFAULT '',
    price          NUMERIC(10,2)   NOT NULL CHECK (price >= 0),
    stock          INTEGER         NOT NULL DEFAULT 0,
    attributes     JSONB           NOT NULL DEFAULT '{}',
    search_vector  TSVECTOR,
    created_at     DATE            NOT NULL DEFAULT CURRENT_DATE
);

CREATE TABLE customers (
    id         SERIAL  PRIMARY KEY,
    name       TEXT    NOT NULL,
    email      TEXT    NOT NULL UNIQUE,
    region     TEXT    NOT NULL DEFAULT 'nacional',
    created_at DATE    NOT NULL DEFAULT CURRENT_DATE
);

CREATE TABLE orders (
    id           SERIAL          PRIMARY KEY,
    customer_id  INTEGER         NOT NULL REFERENCES customers(id),
    status       TEXT            NOT NULL DEFAULT 'pending'
                                 CHECK (status IN ('pending','processing','completed','cancelled')),
    total_amount NUMERIC(10,2)   NOT NULL DEFAULT 0,
    created_at   DATE            NOT NULL DEFAULT CURRENT_DATE
);

CREATE TABLE order_items (
    id          SERIAL          PRIMARY KEY,
    order_id    INTEGER         NOT NULL REFERENCES orders(id),
    product_id  INTEGER         NOT NULL REFERENCES products(id),
    quantity    INTEGER         NOT NULL CHECK (quantity > 0),
    unit_price  NUMERIC(10,2)   NOT NULL CHECK (unit_price >= 0)
);

-- ============================================
-- DATOS DE PRUEBA
-- ============================================

INSERT INTO categories (name) VALUES
    ('Electrónica'),
    ('Hogar'),
    ('Deportes'),
    ('Libros');

INSERT INTO products (category_id, name, description, price, stock, attributes) VALUES
    (1, 'Auriculares Inalámbricos Pro',
        'Auriculares bluetooth con cancelación de ruido activa',
        89.99, 150,
        '{"brand":"SoundMax","color":"negro","connectivity":"bluetooth","battery_hours":30}'),
    (1, 'Teclado Mecánico RGB',
        'Teclado mecánico compacto con retroiluminación RGB',
        129.00, 80,
        '{"brand":"KeyMaster","layout":"tenkeyless","switch":"blue","color":"blanco"}'),
    (1, 'Webcam Full HD',
        'Cámara web 1080p con micrófono incorporado para videoconferencias',
        59.99, 200,
        '{"brand":"ViewCam","resolution":"1080p","fps":30,"has_mic":true}'),
    (2, 'Silla Ergonómica Mesh',
        'Silla de oficina ergonómica con soporte lumbar ajustable',
        299.00, 40,
        '{"brand":"ErgoSeat","material":"mesh","max_kg":120,"color":"gris"}'),
    (2, 'Escritorio Ajustable',
        'Escritorio de pie con ajuste de altura eléctrico',
        449.00, 20,
        '{"brand":"DeskPro","width_cm":140,"memory_positions":3,"color":"blanco"}'),
    (3, 'Zapatillas Running Trail',
        'Calzado técnico para trail running con suela vibram',
        115.00, 90,
        '{"brand":"TrailFoot","sizes":["38","39","40","41","42","43"],"waterproof":true}'),
    (3, 'Mochila Hidratación 20L',
        'Mochila con reservorio de hidratación para ciclismo y senderismo',
        75.00, 60,
        '{"brand":"HydroGear","capacity_liters":20,"bladder_liters":2,"color":"azul"}'),
    (4, 'PostgreSQL: Up and Running',
        'Guía práctica de PostgreSQL para desarrolladores',
        42.00, 300,
        '{"author":"Regina Obe","edition":3,"pages":368,"language":"english"}'),
    (4, 'Diseño de Bases de Datos',
        'Fundamentos de modelado relacional y normalización',
        38.50, 200,
        '{"author":"Varios","edition":2,"pages":290,"language":"spanish"}'),
    (1, 'Hub USB-C 7 en 1',
        'Adaptador USB-C multipuerto para laptops y tablets',
        45.00, 120,
        '{"brand":"ConnectHub","ports":7,"thunderbolt":false,"color":"plateado"}');

-- Poblar search_vector
UPDATE products
SET search_vector =
    setweight(to_tsvector('spanish', COALESCE(name, '')), 'A') ||
    setweight(to_tsvector('spanish', COALESCE(description, '')), 'B');

-- Índice GIN para FTS
CREATE INDEX idx_products_sv ON products USING GIN (search_vector);

INSERT INTO customers (name, email, region) VALUES
    ('Ana García',     'ana@mail.com',    'norte'),
    ('Luis Martínez',  'luis@mail.com',   'sur'),
    ('Elena Torres',   'elena@mail.com',  'centro'),
    ('Carlos Ruiz',    'carlos@mail.com', 'norte'),
    ('Sofía Pérez',    'sofia@mail.com',  'sur');

INSERT INTO orders (customer_id, status, total_amount, created_at) VALUES
    (1, 'completed', 219.98, '2024-01-15'),
    (2, 'completed', 129.00, '2024-01-20'),
    (3, 'completed', 374.00, '2024-02-01'),
    (4, 'processing', 75.00, '2024-02-10'),
    (5, 'completed', 80.50, '2024-02-15'),
    (1, 'completed', 45.00, '2024-03-01'),
    (2, 'pending',  115.00, '2024-03-05'),
    (3, 'completed', 299.00,'2024-03-10');

INSERT INTO order_items (order_id, product_id, quantity, unit_price) VALUES
    (1, 1, 1, 89.99),
    (1, 3, 1, 59.99),  -- webcam + auriculares → 219.98 ✓
    (2, 2, 1, 129.00),
    (3, 4, 1, 299.00),
    (3, 7, 1, 75.00),
    (4, 7, 1, 75.00),
    (5, 8, 1, 42.00),
    (5, 9, 1, 38.50),
    (6, 10, 1, 45.00),
    (7, 6, 1, 115.00),
    (8, 4, 1, 299.00);
