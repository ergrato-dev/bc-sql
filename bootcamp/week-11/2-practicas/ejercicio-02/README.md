# Ejercicio 02 — EXISTS y Tabla Derivada en FROM

## Objetivos

- Usar `EXISTS` y `NOT EXISTS` con subquery correlacionada
- Construir una tabla derivada en `FROM` con alias
- Combinar tabla derivada con tabla real via JOIN

---

## Paso 1: EXISTS — departamentos con empleados activos

`EXISTS` verifica si la subquery retorna al menos una fila.

```sql
SELECT name
FROM departments d
WHERE EXISTS (
    SELECT 1
    FROM employees e
    WHERE e.department_id = d.id
);
```

**Abre `starter/ejercicio.sql`** y descomenta el Paso 1.

---

## Paso 2: NOT EXISTS — departamentos sin empleados

```sql
SELECT name AS department_sin_empleados
FROM departments d
WHERE NOT EXISTS (
    SELECT 1
    FROM employees e
    WHERE e.department_id = d.id
);
```

**Descomenta el Paso 2.**

---

## Paso 3: Tabla derivada en FROM

La subquery en `FROM` actúa como tabla temporal con alias obligatorio.

```sql
-- Promedio salarial por departamento, filtrando los que superan 65 000
SELECT
    dept_stats.department,
    dept_stats.avg_salary
FROM (
    SELECT
        d.name        AS department,
        AVG(e.salary) AS avg_salary
    FROM employees   e
    INNER JOIN departments d ON e.department_id = d.id
    GROUP BY d.name
) AS dept_stats
WHERE dept_stats.avg_salary > 65000
ORDER BY dept_stats.avg_salary DESC;
```

**Descomenta el Paso 3.**

---

## Paso 4: JOIN de tabla real con tabla derivada

```sql
-- Empleados junto al promedio salarial de su departamento
SELECT
    e.first_name,
    e.salary,
    dept_avg.avg_salary AS dept_avg_salary
FROM employees e
INNER JOIN (
    SELECT
        department_id,
        AVG(salary) AS avg_salary
    FROM employees
    GROUP BY department_id
) AS dept_avg ON e.department_id = dept_avg.department_id
ORDER BY e.salary DESC;
```

**Descomenta el Paso 4.**

---

## Verificación

- ¿El Paso 1 incluye solo departamentos con al menos un empleado?
- ¿El Paso 3 muestra solo departamentos con avg_salary > 65 000?
