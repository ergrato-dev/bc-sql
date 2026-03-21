# Ejercicio 01 — SELECT básico con columnas y alias

## Objetivos

- Seleccionar columnas específicas en vez de `SELECT *`
- Crear alias descriptivos con `AS`
- Filtrar filas usando `WHERE` con distintos operadores

## Prerequisito

Ejecuta `starter/setup.sql` para cargar el esquema con datos.

---

## Paso 1: Seleccionar columnas específicas

Evita `SELECT *`. Lista solo las columnas que necesitas:

```sql
SELECT first_name, last_name, email
FROM   employees;
```

**Abre `starter/ejercicio.sql`** y descomenta la sección **PASO 1**.

---

## Paso 2: Usar alias con AS

Renombra columnas o añade columnas calculadas:

```sql
SELECT
    first_name                    AS nombre,
    last_name                     AS apellido,
    salary * 12                   AS salario_anual
FROM employees;
```

**Descomenta la sección PASO 2**.

---

## Paso 3: Filtrar con WHERE

Recupera solo empleados del departamento 1:

```sql
SELECT first_name, salary
FROM   employees
WHERE  department_id = 1;
```

**Descomenta la sección PASO 3**.

---

## Paso 4: Combinar columnas, alias y WHERE

```sql
SELECT
    first_name    AS nombre,
    last_name     AS apellido,
    salary        AS salario
FROM employees
WHERE department_id = 2;
```

**Descomenta la sección PASO 4**.
