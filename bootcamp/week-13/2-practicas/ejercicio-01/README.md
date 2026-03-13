# Ejercicio 01 — Árbol jerárquico de empleados

## Objetivo

Practicar CTEs recursivas para recorrer una jerarquía de empleados
(org chart), calcular el nivel de profundidad y construir el path completo.

## Cómo ejecutar

```bash
docker compose -f _scripts/docker-compose.yml exec -T postgres \
  psql -U bootcamp -d bootcamp_db < starter/setup.sql
docker compose -f _scripts/docker-compose.yml exec postgres \
  psql -U bootcamp -d bootcamp_db -f /dev/stdin < starter/ejercicio.sql
```

## Esquema disponible

Tabla `employees` con columna `manager_id` auto-referencial.

---

## Paso 1: Consulta simple sin recursión

Antes de usar recursión, valida los datos con un conteo de niveles:

```sql
SELECT
    e.employee_id,
    e.first_name,
    m.first_name AS manager_name
FROM employees e
LEFT JOIN employees m ON e.manager_id = m.employee_id
ORDER BY e.manager_id NULLS FIRST;
```

**Abre `starter/ejercicio.sql`** y descomenta la sección **PASO 1**.

---

## Paso 2: CTE recursiva básica — profundidad y path

```sql
WITH RECURSIVE org_chart AS (
    SELECT
        employee_id,
        first_name,
        manager_id,
        1            AS depth,
        first_name   AS path
    FROM employees
    WHERE manager_id IS NULL
    UNION ALL
    SELECT
        e.employee_id,
        e.first_name,
        e.manager_id,
        oc.depth + 1,
        oc.path || ' > ' || e.first_name
    FROM employees e
    INNER JOIN org_chart oc ON e.manager_id = oc.employee_id
)
SELECT depth, REPEAT('  ', depth - 1) || first_name AS indented_name, path
FROM org_chart
ORDER BY path;
```

**Descomenta la sección PASO 2.**

---

## Paso 3: Filtrar por nivel de profundidad

```sql
WITH RECURSIVE org_chart AS (
    SELECT employee_id, first_name, manager_id, 1 AS depth, first_name AS path
    FROM employees
    WHERE manager_id IS NULL
    UNION ALL
    SELECT e.employee_id, e.first_name, e.manager_id, oc.depth + 1, oc.path || ' > ' || e.first_name
    FROM employees e
    INNER JOIN org_chart oc ON e.manager_id = oc.employee_id
)
SELECT first_name, depth, path
FROM org_chart
WHERE depth = 3
ORDER BY path;
```

**Descomenta la sección PASO 3.**

---

## Paso 4: Subordinados de un empleado específico

```sql
WITH RECURSIVE subordinados AS (
    SELECT employee_id, first_name, manager_id, 0 AS depth
    FROM employees
    WHERE first_name = 'Ana'
    UNION ALL
    SELECT e.employee_id, e.first_name, e.manager_id, s.depth + 1
    FROM employees e
    INNER JOIN subordinados s ON e.manager_id = s.employee_id
)
SELECT first_name, depth
FROM subordinados
ORDER BY depth, first_name;
```

**Descomenta la sección PASO 4.**
