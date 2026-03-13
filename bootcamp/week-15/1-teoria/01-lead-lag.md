# LEAD y LAG — desplazamiento entre filas

## Objetivos

- Entender qué hace `LAG()` y `LEAD()` dentro de una ventana
- Calcular la diferencia entre una fila y la anterior/siguiente
- Usar el argumento de valor por defecto para evitar NULLs en bordes

## 1. ¿Qué son LAG y LEAD?

`LAG(columna, offset, default)` accede al valor de la fila **anterior**
dentro de la partición. `LEAD()` accede al valor de la fila **siguiente**.

```sql
-- Muestra el salario de la fila anterior en el mismo departamento
SELECT
    first_name,
    salary,
    LAG(salary, 1, 0) OVER (
        PARTITION BY department_id
        ORDER BY salary DESC
    ) AS prev_salary
FROM employees;
```

> Ver diagrama: [01-lead-lag-diagrama.svg](../0-assets/01-lead-lag-diagrama.svg)

## 2. Calcular diferencias entre filas

El patrón más común: restar el valor actual menos el anterior.

```sql
SELECT
    sale_date,
    amount,
    LAG(amount, 1, 0) OVER (ORDER BY sale_date) AS prev_amount,
    amount - LAG(amount, 1, 0) OVER (ORDER BY sale_date) AS delta
FROM daily_sales
ORDER BY sale_date;
```

## 3. Valor por defecto en bordes

La primera fila no tiene fila anterior → `LAG` devuelve `NULL` por defecto.
El tercer argumento evita el NULL:

```sql
-- Sin defecto: primer registro → prev_salary = NULL
LAG(salary)       OVER (ORDER BY hire_date)

-- Con defecto 0: primer registro → prev_salary = 0
LAG(salary, 1, 0) OVER (ORDER BY hire_date)
```

## 4. LEAD — mirar hacia adelante

```sql
-- Siguiente salario en orden de contratación
SELECT
    first_name,
    hire_date,
    salary,
    LEAD(salary, 1, NULL) OVER (ORDER BY hire_date) AS next_salary
FROM employees;
```

## Checklist

- ¿Sabes cuándo usar LAG vs LEAD?
- ¿Qué ocurre en la primera/última fila sin valor por defecto?
- ¿Cómo calculas la diferencia porcentual entre filas?
- ¿Puedes combinar LAG con PARTITION BY?

## Referencias

- https://www.postgresql.org/docs/16/functions-window.html
- https://mode.com/sql-tutorial/sql-window-functions/
