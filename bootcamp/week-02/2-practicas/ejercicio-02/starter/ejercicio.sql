-- ============================================
-- Semana 02: DDL — Diseño de Esquemas
-- Ejercicio 02 — Modificar Tablas Existentes
-- ============================================
-- Instrucción: descomenta cada sección al llegar al paso del README.

-- ============================================
-- PASO 2: Agregar columna phone a employees
-- ============================================

-- Descomenta las siguientes líneas:
-- ALTER TABLE employees
-- ADD COLUMN phone TEXT;

-- ============================================
-- PASO 3: Agregar columna con NOT NULL + DEFAULT
-- ============================================

-- Descomenta las siguientes líneas:
-- ALTER TABLE employees
-- ADD COLUMN is_active INTEGER NOT NULL DEFAULT 1;

-- ============================================
-- PASO 4: Renombrar columna phone → phone_number
-- ============================================

-- Descomenta las siguientes líneas:
-- ALTER TABLE employees
-- RENAME COLUMN phone TO phone_number;

-- ============================================
-- PASO 5: Renombrar tabla employees → staff
-- ============================================

-- Descomenta las siguientes líneas:
-- ALTER TABLE employees
-- RENAME TO staff;

-- ============================================
-- PASO 6: Verificar estructura final
-- ============================================

-- Descomenta las siguientes líneas:
-- PRAGMA table_info(staff);
-- SELECT * FROM staff;
