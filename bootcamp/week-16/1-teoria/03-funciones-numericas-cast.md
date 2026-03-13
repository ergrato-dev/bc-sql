# Funciones numéricas y CAST

## Objetivos

- Redondear y truncar números con `ROUND`, `CEIL`, `FLOOR`
- Convertir tipos de datos con `CAST` y el operador `::`
- Combinar funciones numéricas con agregaciones

## 1. Funciones numéricas básicas

```sql
SELECT
    ROUND(3.7),          -- 4   (redondea al entero más cercano)
    ROUND(3.456, 2),     -- 3.46 (2 decimales)
    CEIL(3.1),           -- 4   (redondea hacia arriba)
    FLOOR(3.9),          -- 3   (redondea hacia abajo)
    ABS(-42),            -- 42  (valor absoluto)
    MOD(10, 3),          -- 1   (módulo / resto)
    POWER(2, 10);        -- 1024
```

## 2. ROUND en agregaciones

```sql
-- Salario promedio redondeado a 2 decimales
SELECT
    department_id,
    ROUND(AVG(salary), 2) AS avg_salary
FROM employees
GROUP BY department_id
ORDER BY avg_salary DESC;
```

## 3. CAST y el operador ::

Convierte un valor de un tipo a otro:

```sql
-- CAST explícito
SELECT CAST('2024-06-15' AS DATE);
SELECT CAST(salary AS INT) FROM employees;

-- Operador :: (sintaxis PostgreSQL)
SELECT '2024-06-15'::DATE;
SELECT salary::INT FROM employees;
SELECT '42.5'::NUMERIC;
```

## 4. Combinar CAST con funciones

```sql
-- Calcular porcentaje de cambio como texto formateado
SELECT
    sale_month,
    amount,
    ROUND(
        (amount - LAG(amount) OVER (ORDER BY sale_month))
        / NULLIF(LAG(amount) OVER (ORDER BY sale_month), 0) * 100,
        1
    ) AS pct_change
FROM monthly_sales;
```

> `NULLIF(..., 0)` evita división por cero cuando el valor anterior es 0.

## Checklist

- ¿Cuál es la diferencia entre ROUND(3.5) y FLOOR(3.5)?
- ¿Por qué usaríamos NULLIF en una división?
- ¿Cuándo prefieres `::DATE` sobre `CAST(... AS DATE)`?
- ¿Qué resuelve `CAST` que no puede hacer `ROUND`?

## Referencias

- https://www.postgresql.org/docs/16/functions-math.html
- https://www.postgresql.org/docs/16/sql-expressions.html#SQL-SYNTAX-TYPE-CASTS
