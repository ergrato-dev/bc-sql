# FIRST_VALUE y LAST_VALUE

## Objetivos

- Obtener el primer y último valor de una partición ordenada
- Entender por qué `LAST_VALUE` requiere un frame clause explícito
- Aplicar ambas funciones en reportes de comparación

## 1. FIRST_VALUE — el valor del inicio de la ventana

Devuelve el valor de la **primera fila** dentro de la partición según
el ORDER BY definido:

```sql
-- El salario más alto del departamento en cada fila
SELECT
    first_name,
    department_id,
    salary,
    FIRST_VALUE(salary) OVER (
        PARTITION BY department_id
        ORDER BY salary DESC
    ) AS dept_max_salary
FROM employees;
```

> Ver diagrama: [02-first-last-frame.svg](../0-assets/02-first-last-frame.svg)

## 2. LAST_VALUE — trampa del frame por defecto

El frame por defecto es `ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW`,
por eso `LAST_VALUE` devuelve el valor de la fila actual, no el último de
la partición. Hay que extender el frame:

```sql
-- ❌ Incorrecto — devuelve el valor de la fila actual
LAST_VALUE(salary) OVER (
    PARTITION BY department_id
    ORDER BY salary DESC
)

-- ✅ Correcto — extiende el frame hasta el extremo de la partición
LAST_VALUE(salary) OVER (
    PARTITION BY department_id
    ORDER BY salary DESC
    ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
)
```

## 3. Comparar con el máximo y mínimo

```sql
SELECT
    first_name,
    salary,
    FIRST_VALUE(salary) OVER w AS dept_max,
    LAST_VALUE(salary)  OVER w AS dept_min
FROM employees
WINDOW w AS (
    PARTITION BY department_id
    ORDER BY salary DESC
    ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
);
```

## 4. Alias de ventana con WINDOW

El alias `WINDOW w AS (...)` evita repetir la misma definición
`OVER (...)` en cada función:

```sql
SELECT
    first_name,
    FIRST_VALUE(first_name) OVER w AS first_hired,
    LAST_VALUE(first_name)  OVER w AS last_hired
FROM employees
WINDOW w AS (
    ORDER BY hire_date
    ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
);
```

## Checklist

- ¿Por qué LAST_VALUE parece "roto" sin frame clause?
- ¿Cuándo usarías FIRST_VALUE en lugar de un simple MAX()?
- ¿Qué significa `ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING`?
- ¿Cómo simplifica `WINDOW w AS (...)` una consulta con 3 window functions?

## Referencias

- https://www.postgresql.org/docs/16/sql-expressions.html#SYNTAX-WINDOW-FUNCTIONS
- https://www.postgresql.org/docs/16/functions-window.html
