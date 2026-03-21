# ROW_NUMBER, RANK y DENSE_RANK

## Objetivos

1. Describir cómo cada función maneja los empates (ties)
2. Elegir la función correcta según el caso de uso
3. Aplicar las tres funciones en la misma consulta para comparar

📊 Ver diagrama [0-assets/02-rank-comparacion.svg](../0-assets/02-rank-comparacion.svg)

---

## 1. Diferencias clave

| Función | Empates | Siguiente valor |
|---------|---------|-----------------|
| `ROW_NUMBER()` | Número único siempre | Sin saltos |
| `RANK()` | Mismo rango | Salta posiciones |
| `DENSE_RANK()` | Mismo rango | Sin saltos |

---

## 2. Comparación con datos reales

```sql
SELECT
    first_name,
    salary,
    ROW_NUMBER() OVER (ORDER BY salary DESC) AS row_num,
    RANK()       OVER (ORDER BY salary DESC) AS rnk,
    DENSE_RANK() OVER (ORDER BY salary DESC) AS dense_rnk
FROM employees
ORDER BY salary DESC;
```

Con dos empleados que ganan 76 000:

| first_name | salary | row_num | rnk | dense_rnk |
|------------|--------|---------|-----|-----------|
| Ana        | 90000  | 1       | 1   | 1         |
| Carlos     | 76000  | 2       | 2   | 2         |
| Lucía      | 76000  | 3       | 2   | 2         |
| Miguel     | 65000  | 4       | 4   | 3         |

---

## 3. Cuándo usar cada una

- **`ROW_NUMBER()`** → Cuando necesitas un identificador único por fila
  (paginación, eliminar duplicados)
- **`RANK()`** → Rankings oficiales donde los empates comparten posición
  y el siguiente puesto refleja salto (Olimpiadas: 1°, 2°, 2°, 4°)
- **`DENSE_RANK()`** → Rankings donde los empates comparten posición
  sin saltos (percentiles, cuartiles)

---

## 4. PARTITION BY con ranking

```sql
-- Top empleado por salario en cada departamento
SELECT
    first_name,
    department_id,
    salary,
    RANK() OVER (
        PARTITION BY department_id
        ORDER BY salary DESC
    ) AS dept_rank
FROM employees;
```

---

## Checklist

- [ ] ¿`ROW_NUMBER()` siempre produce valores únicos aunque haya empates?
- [ ] ¿`RANK()` salta posiciones después de un empate?
- [ ] ¿`DENSE_RANK()` no salta posiciones?
- [ ] ¿Puedo usar las tres funciones en la misma consulta?

## Referencias

- https://www.postgresql.org/docs/current/functions-window.html
- https://mode.com/sql-tutorial/sql-window-functions/
