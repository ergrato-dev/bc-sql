# Ejercicio 02 — LEFT JOIN: Filas sin coincidencia

## Objetivos

- Usar LEFT JOIN para incluir filas sin coincidencia
- Detectar "huérfanos" con el patrón `WHERE col IS NULL`
- Combinar LEFT JOIN con COUNT para conteo correcto

---

## Paso 1: LEFT JOIN básico

A diferencia del INNER JOIN, el `LEFT JOIN` devuelve **todas** las filas de
la tabla izquierda aunque no tengan coincidencia en la derecha.

```sql
-- Todos los departamentos, con o sin empleados
SELECT
    d.name        AS department,
    e.first_name  AS employee
FROM departments d
LEFT JOIN employees e ON e.department_id = d.id;
```

Los departamentos sin empleados aparecerán con `NULL` en `employee`.

**Abre `starter/ejercicio.sql`** y descomenta el Paso 1.

---

## Paso 2: Detectar "departamentos huérfanos"

Agrega `WHERE e.id IS NULL` para ver solo los departamentos sin empleados.

```sql
SELECT
    d.name AS department_sin_empleados
FROM departments d
LEFT JOIN employees e ON e.department_id = d.id
WHERE e.id IS NULL;
```

**Descomenta el Paso 2.**

---

## Paso 3: Contar empleados por departamento (incluye depts vacíos)

Con `COUNT(e.id)` (no `COUNT(*)`) los departamentos vacíos muestran `0`.

```sql
SELECT
    d.name          AS department,
    COUNT(e.id)     AS total_employees
FROM departments d
LEFT JOIN employees e ON e.department_id = d.id
GROUP BY d.name
ORDER BY total_employees DESC;
```

**Descomenta el Paso 3.**

---

## Paso 4: LEFT JOIN + tres tablas + condición

```sql
-- Departamentos con su ubicación y cantidad de empleados activos
SELECT
    d.name          AS department,
    l.name          AS location,
    COUNT(e.id)     AS active_employees
FROM departments  d
LEFT JOIN locations   l ON d.location_id   = l.id
LEFT JOIN employees   e ON e.department_id = d.id
                        AND e.is_active    = 1
GROUP BY d.name, l.name
ORDER BY active_employees DESC;
```

> Nota: el filtro `AND e.is_active = 1` va en la cláusula `ON`, no en `WHERE`,
> para no perder los departamentos vacíos.

**Descomenta el Paso 4.**

---

## Paso 5: No repetir el presupuesto al sumar

El JOIN repite un departamento por cada empleado. Su presupuesto pertenece
al departamento, no al empleado: sumarlo después del JOIN lo multiplica.

```sql
-- Consulta intencionalmente incorrecta para el presupuesto total
SELECT SUM(d.budget) AS repeated_budget
FROM departments d
LEFT JOIN employees e ON e.department_id = d.id;

-- Una fila por departamento: no hace falta unir empleados
SELECT SUM(budget) AS total_budget
FROM departments;
```

Con estos datos obtienes **480000** frente a **300000**. HR sigue incluido
una vez aunque no tenga empleados. `SUM(DISTINCT d.budget)` no es una
solución general: dos departamentos pueden tener el mismo presupuesto.

**Descomenta el Paso 5** y compara ambos resultados.

---

## Verificación

- ¿El Paso 1 muestra el departamento HR con `NULL` en employee?
- ¿El Paso 3 muestra `0` para HR?
- ¿El Paso 5 explica por qué sumar presupuestos tras el JOIN los repite?
