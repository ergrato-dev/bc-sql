-- ============================================
-- Semana 07: Constraints — Ejercicio 02
-- PRAGMA, NULLIF, Integridad referencial
-- ============================================
-- Ejecuta primero: setup.sql

-- ============================================
-- PASO 1: Inspeccionar constraints con PRAGMA
-- ============================================

-- Muestra columnas, tipos y si son NOT NULL (notnull = 1):

-- PRAGMA table_info(employees);


-- ============================================
-- PASO 2: Insertar datos válidos
-- ============================================

-- Inserta un empleado respetando todos los constraints:

-- INSERT INTO employees
--     (id, first_name, last_name, salary, level, department_id)
-- VALUES
--     (10, 'Hugo', 'Reyes', 62000.00, 'mid', 2);

-- Verifica que se insertó:
-- SELECT * FROM employees WHERE id = 10;


-- ============================================
-- PASO 3: NULLIF — operación segura
-- ============================================

-- Calcula el bonus como % del salario; evita división por cero:

-- SELECT
--     first_name,
--     salary,
--     COALESCE(bonus, 0)                               AS bonus,
--     ROUND(
--         COALESCE(bonus, 0) / NULLIF(salary, 0) * 100,
--         2
--     )                                                AS bonus_pct
-- FROM employees;


-- ============================================
-- PASO 4: Verificar integridad referencial
-- ============================================

-- Busca employees con department_id que no existe en departments.
-- Resultado esperado: 0 filas (FK garantiza integridad):

-- SELECT DISTINCT department_id
-- FROM   employees
-- WHERE  department_id NOT IN (SELECT id FROM departments);
