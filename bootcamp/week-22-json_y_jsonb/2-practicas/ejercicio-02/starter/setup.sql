-- ============================================
-- Semana 22: JSON y JSONB
-- Ejercicio 02 — Setup del esquema
-- Motor: PostgreSQL 16
-- ============================================

DROP TABLE IF EXISTS products;

CREATE TABLE products (
    id          SERIAL       PRIMARY KEY,
    name        TEXT         NOT NULL,
    category    TEXT         NOT NULL,
    attributes  JSONB        NOT NULL DEFAULT '{}'
);

INSERT INTO products (name, category, attributes) VALUES
('Laptop Pro',
 'computadoras',
 '{"color": "silver", "ram_gb": 16, "storage_gb": 512, "brand": "TechCo"}'),

('Laptop Air',
 'computadoras',
 '{"color": "space-gray", "ram_gb": 8, "storage_gb": 256, "brand": "TechCo"}'),

('Tablet Plus',
 'tablets',
 '{"color": "black", "ram_gb": 8, "storage_gb": 128, "pen": true}'),

('Tablet Mini',
 'tablets',
 '{"color": "silver", "ram_gb": 4, "storage_gb": 64,  "pen": false}'),

('Monitor 4K',
 'monitores',
 '{"resolution": "3840x2160", "hz": 60, "hdr": true, "inches": 27}'),

('Monitor FHD',
 'monitores',
 '{"resolution": "1920x1080", "hz": 144, "hdr": false, "inches": 24}'),

('Camera X200',
 'camaras',
 '{"sensor": {"megapixels": 24, "type": "CMOS"}, "zoom": 10, "color": "black"}'),

('Camera Z50',
 'camaras',
 '{"sensor": {"megapixels": 50, "type": "BSI-CMOS"}, "zoom": 20, "color": "silver"}'),

('Hub USB Pro',
 'accesorios',
 '{"ports": ["USB-A", "USB-C", "HDMI", "SD"], "powered": true, "watts": 65}'),

('Teclado Mech',
 'accesorios',
 '{"layout": "QWERTY", "backlit": true, "switches": "blue", "color": "black"}');
