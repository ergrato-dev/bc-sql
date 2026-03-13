# Ejercicio 02 — GROUP BY y HAVING

## Objetivos

- Calcular subtotales por grupo con `GROUP BY`
- Filtrar grupos con `HAVING`

## Prerequisito

Ejecuta `starter/setup.sql` para cargar el esquema con datos.

---

## Paso 1: GROUP BY básico

Cuenta cuántos empleados hay en cada departamento:

```sql
SELECT
    department_id,
    COUNT(*) AS total
FROM   employees
GROUP BY department_id
ORDER BY total DESC;
```

**Abre `starter/ejercicio.sql`** y descomenta la sección **PASO 1**.

---

## Paso 2: GROUP BY con múltiples funciones

Promedio y masa salarial por departamento:

```sql
SELECT
    department_id,
    COUNT(*)            AS total,
    ROUND(AVG(salary), 2) AS promedio,
    SUM(salary)         AS masa_salarial
FROM   employees
GROUP BY department_id;
```

**Descomenta la sección PASO 2**.

---

## Paso 3: HAVING — filtrar grupos

Solo departamentos con más de 1 empleado:

```sql
SELECT department_id, COUNT(*) AS total
FROM   employees
GROUP BY department_id
HAVING COUNT(*) > 1;
```

**Descomenta la sección PASO 3**.

---

## Paso 4: WHERE + GROUP BY + HAVING

Departamentos con promedio salarial > 65 000, considerando solo empleados con salario > 55 000:

```sql
SELECT
    department_id,
    ROUND(AVG(salary), 2) AS promedio
FROM   employees
WHERE  salary > 55000
GROUP BY department_id
HAVING AVG(salary) > 65000
ORDER BY promedio DESC;
```

**Descomenta la sección PASO 4**.
