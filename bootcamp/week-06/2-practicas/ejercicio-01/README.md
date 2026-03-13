# Ejercicio 01 — Funciones de Agregación

## Objetivos

- Calcular totales con `COUNT`, `SUM`, `AVG`, `MIN`, `MAX`
- Filtrar filas antes de agregar con `WHERE`

## Prerequisito

Ejecuta `starter/setup.sql` para cargar el esquema con datos.

---

## Paso 1: COUNT y total de empleados

```sql
SELECT COUNT(*) AS total_empleados
FROM   employees;
```

**Abre `starter/ejercicio.sql`** y descomenta la sección **PASO 1**.

---

## Paso 2: SUM y AVG del salario

```sql
SELECT
    SUM(salary) AS masa_salarial,
    AVG(salary) AS salario_promedio
FROM employees;
```

**Descomenta la sección PASO 2**.

---

## Paso 3: MIN y MAX

```sql
SELECT
    MIN(salary) AS salario_minimo,
    MAX(salary) AS salario_maximo
FROM employees;
```

**Descomenta la sección PASO 3**.

---

## Paso 4: Agregación con WHERE

Calcula el salario promedio solo del departamento 1:

```sql
SELECT AVG(salary) AS promedio_engineering
FROM   employees
WHERE  department_id = 1;
```

**Descomenta la sección PASO 4**.
