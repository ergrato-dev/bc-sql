# Ejercicio 01 — INNER JOIN: Combinando tablas

## Objetivos

- Escribir consultas INNER JOIN entre dos tablas
- Usar aliases de tabla para mayor claridad
- Encadenar tres tablas con múltiples JOINs

---

## Paso 1: INNER JOIN básico

Un `INNER JOIN` devuelve solo las filas que tienen coincidencia en ambas tablas.

```sql
-- Empleados con su departamento
SELECT
    e.first_name,
    e.last_name,
    d.name AS department
FROM employees e
INNER JOIN departments d ON e.department_id = d.id;
```

**Abre `starter/ejercicio.sql`** y descomenta la sección del Paso 1.

---

## Paso 2: Agregar columnas de ambas tablas

```sql
-- Empleados con sueldo y presupuesto del departamento
SELECT
    e.first_name,
    e.salary,
    d.name        AS department,
    d.budget
FROM employees e
INNER JOIN departments d ON e.department_id = d.id
ORDER BY e.salary DESC;
```

**Descomenta el Paso 2.**

---

## Paso 3: JOIN con filtro WHERE

```sql
-- Solo empleados activos del departamento de Ingeniería
SELECT
    e.first_name,
    e.last_name,
    e.level
FROM employees e
INNER JOIN departments d ON e.department_id = d.id
WHERE d.name    = 'Engineering'
  AND e.is_active = 1;
```

**Descomenta el Paso 3.**

---

## Paso 4: JOIN de tres tablas

Encadena dos INNER JOINs para cruzar `employees` → `departments` → `locations`.

```sql
SELECT
    e.first_name,
    d.name    AS department,
    l.name    AS location,
    l.country
FROM employees e
INNER JOIN departments d ON e.department_id = d.id
INNER JOIN locations   l ON d.location_id   = l.id
ORDER BY l.country, d.name;
```

**Descomenta el Paso 4.**

---

## Verificación

- ¿El Paso 1 devuelve filas solo para empleados con departamento asignado?
- ¿El Paso 4 muestra el país de cada empleado?
