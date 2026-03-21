# Ejercicio 01 — Manejo de NULL

## Objetivos

- Filtrar filas nulas con `IS NULL` e `IS NOT NULL`
- Susituir NULLs con `COALESCE` e `IFNULL`
- Comprender el peligro de `NOT IN` con NULLs

## Prerequisito

Ejecuta `starter/setup.sql` para cargar el esquema con datos.

---

## Paso 1: IS NULL — empleados sin email

```sql
SELECT id, first_name, email
FROM   employees
WHERE  email IS NULL;
```

**Abre `starter/ejercicio.sql`** y descomenta la sección **PASO 1**.

---

## Paso 2: IS NOT NULL — empleados con email

```sql
SELECT id, first_name, email
FROM   employees
WHERE  email IS NOT NULL;
```

**Descomenta la sección PASO 2**.

---

## Paso 3: COALESCE — reemplazar NULL en bonus

```sql
SELECT
    first_name,
    bonus,
    COALESCE(bonus, 0) AS bonus_efectivo
FROM employees;
```

**Descomenta la sección PASO 3**.

---

## Paso 4: COUNT(*) vs COUNT(columna)

```sql
SELECT
    COUNT(*)      AS total_empleados,
    COUNT(email)  AS con_email,
    COUNT(bonus)  AS con_bonus
FROM employees;
```

**Descomenta la sección PASO 4**.
