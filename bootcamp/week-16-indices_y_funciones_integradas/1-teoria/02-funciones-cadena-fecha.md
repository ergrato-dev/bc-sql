# Funciones de cadena y fecha

## Objetivos

- Transformar y limpiar texto con funciones de cadena
- Extraer y formatear fechas con funciones temporales de PostgreSQL

## 1. Funciones de cadena más usadas

```sql
SELECT
    UPPER('hola mundo'),          -- 'HOLA MUNDO'
    LOWER('HOLA MUNDO'),          -- 'hola mundo'
    TRIM('  hola  '),             -- 'hola'
    LENGTH('hola'),               -- 4
    SUBSTRING('hola mundo', 1, 4),-- 'hola'  (1-based)
    REPLACE('hola mundo', 'mundo', 'SQL'), -- 'hola SQL'
    CONCAT('hola', ' ', 'mundo'), -- 'hola mundo'
    'hola' || ' ' || 'mundo';     -- 'hola mundo' (operador ||)
```

> Ver diagrama: [02-funciones-mapa.svg](../0-assets/02-funciones-mapa.svg)

## 2. Funciones de fecha y tiempo

```sql
SELECT
    NOW(),                          -- timestamp actual con zona horaria
    CURRENT_DATE,                   -- solo la fecha (DATE)
    CURRENT_TIMESTAMP,              -- equivalente a NOW()
    DATE_TRUNC('month', NOW()),     -- primer día del mes actual
    EXTRACT(YEAR FROM NOW()),       -- número del año actual
    AGE('2024-06-15'::DATE, '1990-03-01'::DATE); -- intervalo
```

## 3. Formatear fechas con TO_CHAR

```sql
SELECT
    TO_CHAR(NOW(), 'YYYY-MM-DD'),       -- '2024-06-15'
    TO_CHAR(NOW(), 'DD/MM/YYYY'),       -- '15/06/2024'
    TO_CHAR(NOW(), 'Month YYYY'),       -- 'June    2024'
    TO_CHAR(salary, 'FM$999,999.00');  -- '$82,000.00'
```

## 4. Comparar y filtrar fechas

```sql
-- Empleados contratados en el último año
SELECT first_name, hire_date
FROM employees
WHERE hire_date >= CURRENT_DATE - INTERVAL '1 year';

-- Empleados del mes de enero
SELECT first_name, hire_date
FROM employees
WHERE EXTRACT(MONTH FROM hire_date) = 1;
```

## Checklist

- ¿Cómo concatenas dos columnas de texto en PostgreSQL?
- ¿Cuál es la diferencia entre NOW() y CURRENT_DATE?
- ¿Qué devuelve DATE_TRUNC('month', '2024-06-15')?
- ¿Cómo filtras registros de los últimos 30 días?

## Referencias

- https://www.postgresql.org/docs/16/functions-string.html
- https://www.postgresql.org/docs/16/functions-datetime.html
