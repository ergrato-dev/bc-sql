# CASE WHEN: expresiones condicionales

## Objetivos

1. Escribir expresiones `CASE WHEN` simples y buscadas
2. Clasificar filas en categorías con `CASE WHEN`
3. Combinar `CASE WHEN` con funciones de agregación

📊 Ver diagrama [0-assets/02-case-when-flujo.svg](../0-assets/02-case-when-flujo.svg)

---

## 1. Sintaxis básica

`CASE WHEN` evalúa condiciones en orden y retorna el primer `THEN` que
sea verdadero. Si ninguna condición se cumple, retorna `ELSE` (o `NULL`).

```sql
SELECT
    first_name,
    salary,
    CASE
        WHEN salary >= 80000 THEN 'Senior'
        WHEN salary >= 50000 THEN 'Mid'
        ELSE                      'Junior'
    END AS salary_band
FROM employees;
```

---

## 2. CASE simple (comparación de igualdad)

Cuando todas las condiciones comparan la misma columna con distintos valores:

```sql
SELECT
    first_name,
    CASE department_id
        WHEN 1 THEN 'Engineering'
        WHEN 2 THEN 'Marketing'
        WHEN 3 THEN 'HR'
        ELSE        'Other'
    END AS dept_label
FROM employees;
```

---

## 3. CASE WHEN con agregación condicional

Cuenta o suma solo las filas que cumplen una condición:

```sql
SELECT
    department_id,
    COUNT(*)                              AS total,
    COUNT(CASE WHEN salary > 60000 THEN 1 END) AS high_earners,
    COUNT(CASE WHEN is_active = 0 THEN 1 END)  AS inactive
FROM employees
GROUP BY department_id;
```

---

## 4. CASE WHEN dentro de un CTE

```sql
WITH clasificados AS (
    SELECT
        first_name,
        salary,
        CASE
            WHEN salary >= 70000 THEN 'Alto'
            WHEN salary >= 40000 THEN 'Medio'
            ELSE                      'Bajo'
        END AS banda_salarial
    FROM employees
)
SELECT
    banda_salarial,
    COUNT(*) AS total
FROM clasificados
GROUP BY banda_salarial
ORDER BY total DESC;
```

---

## Checklist

- [ ] ¿El `CASE` termina con `END`?
- [ ] ¿Las condiciones están en orden correcto (más restrictiva primero)?
- [ ] ¿Tengo `ELSE` para manejar casos no contemplados?
- [ ] ¿Puedo usar `CASE WHEN` dentro de `COUNT()` o `SUM()`?

## Referencias

- https://www.sqlite.org/lang_expr.html#case_expressions
- https://www.postgresql.org/docs/current/functions-conditional.html
