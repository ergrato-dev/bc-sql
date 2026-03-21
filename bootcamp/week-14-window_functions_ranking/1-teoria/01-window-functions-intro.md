# Funciones de ventana: la cláusula OVER()

## Objetivos

1. Distinguir una window function de una función de agregación
2. Escribir la cláusula `OVER()` con `PARTITION BY` y `ORDER BY`
3. Usar `ROW_NUMBER()` para numerar filas dentro de una partición

📊 Ver diagrama [0-assets/01-window-partition.svg](../0-assets/01-window-partition.svg)

---

## 1. ¿Qué es una window function?

Una window function calcula un valor para cada fila usando un conjunto
de filas relacionadas (la **ventana**), **sin colapsar** las filas en
el resultado (a diferencia de `GROUP BY`).

```sql
-- GROUP BY: colapsa las filas (1 fila por departamento)
SELECT department_id, AVG(salary) AS avg_sal
FROM employees
GROUP BY department_id;

-- Window function: mantiene todas las filas
SELECT
    first_name,
    department_id,
    salary,
    AVG(salary) OVER (PARTITION BY department_id) AS dept_avg
FROM employees;
```

---

## 2. Sintaxis de OVER()

```sql
funcion_ventana() OVER (
    PARTITION BY columna_agrupacion   -- divide en grupos
    ORDER BY     columna_orden        -- orden dentro del grupo
)
```

---

## 3. ROW_NUMBER() básico

Asigna un número secuencial único a cada fila dentro de la partición:

```sql
SELECT
    first_name,
    department_id,
    salary,
    ROW_NUMBER() OVER (
        PARTITION BY department_id
        ORDER BY salary DESC
    ) AS row_num
FROM employees;
-- row_num reinicia en 1 para cada departamento
```

---

## 4. Sin PARTITION BY — ventana global

Si se omite `PARTITION BY`, la ventana es toda la tabla:

```sql
SELECT
    first_name,
    salary,
    ROW_NUMBER() OVER (ORDER BY salary DESC) AS ranking_global
FROM employees;
```

---

## Checklist

- [ ] ¿Entiendo por qué window functions no colapsan filas?
- [ ] ¿`PARTITION BY` divide los grupos igual que `GROUP BY`?
- [ ] ¿`ROW_NUMBER()` sin `PARTITION BY` numera toda la tabla?
- [ ] ¿El `ORDER BY` dentro de `OVER()` es independiente del `ORDER BY` final?

## Referencias

- https://www.postgresql.org/docs/current/tutorial-window.html
- https://www.postgresql.org/docs/current/functions-window.html
