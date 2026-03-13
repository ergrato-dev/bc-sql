# Ejercicio 01 — BETWEEN e IN

## Objetivos

- Filtrar rangos numéricos con `BETWEEN`
- Filtrar listas de valores con `IN` y `NOT IN`

## Prerequisito

Ejecuta `starter/setup.sql` para cargar el esquema con datos.

---

## Paso 1: BETWEEN rango numérico

Recupera empleados con salario entre 60 000 y 75 000 (ambos inclusive):

```sql
SELECT first_name, salary
FROM   employees
WHERE  salary BETWEEN 60000 AND 75000;
```

**Abre `starter/ejercicio.sql`** y descomenta la sección **PASO 1**.

---

## Paso 2: NOT BETWEEN

Empleados fuera de ese rango salarial:

```sql
SELECT first_name, salary
FROM   employees
WHERE  salary NOT BETWEEN 60000 AND 75000;
```

**Descomenta la sección PASO 2**.

---

## Paso 3: IN — lista de departamentos

Empleados que pertenecen a los departamentos 1 o 3:

```sql
SELECT first_name, department_id
FROM   employees
WHERE  department_id IN (1, 3);
```

**Descomenta la sección PASO 3**.

---

## Paso 4: NOT IN

Empleados que NO pertenecen al departamento 2:

```sql
SELECT first_name, department_id
FROM   employees
WHERE  department_id NOT IN (2);
```

**Descomenta la sección PASO 4** y verifica que el resultado coincide con PASO 3 usando un dominio diferente.
