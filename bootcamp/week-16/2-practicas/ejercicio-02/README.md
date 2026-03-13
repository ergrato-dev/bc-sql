# Ejercicio 02 — Funciones de cadena, fecha y numéricas

## Objetivo

Aplicar funciones integradas de PostgreSQL para transformar texto,
manipular fechas y calcular valores numéricos en consultas reales.

## Cómo ejecutar

```bash
docker compose -f _scripts/docker-compose.yml exec -T postgres \
  psql -U bootcamp -d bootcamp_db < starter/setup.sql
docker compose -f _scripts/docker-compose.yml exec postgres \
  psql -U bootcamp -d bootcamp_db -f /dev/stdin < starter/ejercicio.sql
```

## Esquema disponible

Reutiliza el esquema del ejercicio 01 (`employees` + `departments`).

---

## Paso 1: Funciones de cadena

Construye el nombre completo en MAYÚSCULAS y extrae el dominio del email:

```sql
SELECT
    UPPER(first_name) || ' ' || UPPER(last_name) AS full_name_upper,
    SUBSTRING(email FROM POSITION('@' IN email) + 1) AS email_domain,
    LENGTH(first_name) AS name_length
FROM employees
ORDER BY full_name_upper;
```

**Abre `starter/ejercicio.sql`** y descomenta la sección **PASO 1**.

---

## Paso 2: Funciones de fecha

Calcula cuántos años lleva cada empleado en la empresa:

```sql
SELECT
    first_name,
    hire_date,
    TO_CHAR(hire_date, 'DD/MM/YYYY')          AS hire_fmt,
    EXTRACT(YEAR FROM AGE(CURRENT_DATE, hire_date))::INT AS years_in_company
FROM employees
ORDER BY hire_date;
```

**Descomenta la sección PASO 2.**

---

## Paso 3: Funciones numéricas

Calcula el salario mensual y aplica un bono del 10%:

```sql
SELECT
    first_name,
    salary,
    ROUND(salary / 12, 2)          AS monthly_salary,
    ROUND(salary * 1.10, 2)        AS salary_with_bonus,
    ROUND(salary * 1.10 - salary, 2) AS bonus_amount
FROM employees
ORDER BY salary DESC;
```

**Descomenta la sección PASO 3.**

---

## Paso 4: Combinar funciones en un reporte

Genera un reporte completo combinando las tres categorías:

```sql
SELECT
    UPPER(first_name) || ' ' || UPPER(last_name)         AS employee,
    TO_CHAR(hire_date, 'Mon YYYY')                       AS hired,
    EXTRACT(YEAR FROM AGE(CURRENT_DATE, hire_date))::INT AS years,
    ROUND(salary / 12, 2)                                AS monthly
FROM employees
WHERE is_active = TRUE
ORDER BY years DESC, salary DESC;
```

**Descomenta la sección PASO 4.**
