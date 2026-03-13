# Ejercicio 01 — Subquery escalar + IN / NOT IN

## Objetivos

- Comparar salarios contra un valor calculado con subquery
- Filtrar con `IN` usando una lista de IDs de subquery
- Entender la trampa de `NOT IN` con valores NULL

---

## Paso 1: Subquery escalar en WHERE

Filtrar empleados cuyo sueldo supera el promedio general.

```sql
-- Empleados con sueldo mayor al promedio de la empresa
SELECT
    first_name,
    salary
FROM employees
WHERE salary > (SELECT AVG(salary) FROM employees)
ORDER BY salary DESC;
```

**Abre `starter/ejercicio.sql`** y descomenta el Paso 1.

---

## Paso 2: Subquery escalar en SELECT

Mostrar el sueldo de cada empleado junto al promedio global.

```sql
SELECT
    first_name,
    salary,
    ROUND((SELECT AVG(salary) FROM employees), 2) AS company_avg
FROM employees
ORDER BY salary DESC;
```

**Descomenta el Paso 2.**

---

## Paso 3: Filtrar con IN

Obtener empleados que pertenecen a departamentos activos.

```sql
-- IN: departamentos donde is_active = 1
SELECT
    first_name,
    department_id
FROM employees
WHERE department_id IN (
    SELECT id
    FROM departments
    WHERE is_active = 1
);
```

**Descomenta el Paso 3.**

---

## Paso 4: NOT IN con protección NULL

Empleados que **no** pertenecen a departamentos de alto presupuesto.
Siempre filtrar NULL en la subquery.

```sql
-- NOT IN seguro: excluye NULLs de la subquery
SELECT first_name
FROM employees
WHERE department_id NOT IN (
    SELECT id
    FROM departments
    WHERE budget > 100000
      AND id IS NOT NULL
);
```

**Descomenta el Paso 4.**

---

## Verificación

- ¿El Paso 1 excluye al CEO y a Carol (sueldo < promedio)?
- ¿El Paso 3 excluye empleados del departamento inactivo?
