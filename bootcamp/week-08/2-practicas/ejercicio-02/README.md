# Ejercicio 02 — Reportes con Filtros y Agregación

## Objetivos

- Combinar `WHERE`, `GROUP BY`, `HAVING` y `ORDER BY` en una sola query
- Usar `COALESCE` e `IS NULL` en consultas de reporte
- Escribir 5 consultas analíticas distintas sobre el mismo esquema

## Prerequisito

Ejecuta `starter/setup.sql` para cargar el esquema con datos.

---

## Paso 1: Reporte de totales por departamento

```sql
SELECT
    department_id,
    COUNT(*)               AS total,
    ROUND(AVG(salary), 2)  AS promedio_salarial
FROM   employees
WHERE  is_active = 1
GROUP BY department_id
ORDER BY promedio_salarial DESC;
```

**Abre `starter/ejercicio.sql`** y descomenta la sección **PASO 1**.

---

## Paso 2: Empleados sin email (IS NULL)

```sql
SELECT first_name, last_name, COALESCE(email, 'N/A') AS email_display
FROM   employees
WHERE  email IS NULL;
```

**Descomenta la sección PASO 2**.

---

## Paso 3: Top 3 de salarios activos

```sql
SELECT first_name, last_name, salary
FROM   employees
WHERE  is_active = 1
ORDER BY salary DESC
LIMIT 3;
```

**Descomenta la sección PASO 3**.

---

## Paso 4: Departamentos con más de 1 empleado activo

```sql
SELECT department_id, COUNT(*) AS activos
FROM   employees
WHERE  is_active = 1
GROUP BY department_id
HAVING activos > 1;
```

**Descomenta la sección PASO 4**.

---

## Paso 5: Búsqueda por rango y nivel

```sql
SELECT first_name, salary, level
FROM   employees
WHERE  salary BETWEEN 60000 AND 80000
  AND  level IN ('mid', 'senior')
ORDER BY level, salary DESC;
```

**Descomenta la sección PASO 5**.
