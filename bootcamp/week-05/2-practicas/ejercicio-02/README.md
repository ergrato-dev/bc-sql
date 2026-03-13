# Ejercicio 02 — LIKE y filtros combinados

## Objetivos

- Buscar patrones de texto con `LIKE` usando `%` y `_`
- Combinar `BETWEEN`, `IN` y `LIKE` en una sola consulta

## Prerequisito

Ejecuta `starter/setup.sql` para cargar el esquema con datos.

---

## Paso 1: LIKE con %

Nombres que empiezan con la letra 'A':

```sql
SELECT first_name, email
FROM   employees
WHERE  first_name LIKE 'A%';
```

**Abre `starter/ejercicio.sql`** y descomenta la sección **PASO 1**.

---

## Paso 2: LIKE con % en ambos extremos

Apellidos que contienen la letra 'i':

```sql
SELECT first_name, last_name
FROM   employees
WHERE  last_name LIKE '%i%';
```

**Descomenta la sección PASO 2**.

---

## Paso 3: LIKE con _

Nombres cuya segunda letra es 'r':

```sql
SELECT first_name
FROM   employees
WHERE  first_name LIKE '_r%';
```

**Descomenta la sección PASO 3**.

---

## Paso 4: Filtro combinado — BETWEEN + IN + LIKE

```sql
SELECT first_name, last_name, salary, department_id
FROM   employees
WHERE  department_id IN (1, 2)
  AND  salary BETWEEN 60000 AND 80000
  AND  last_name LIKE '%i%';
```

**Descomenta la sección PASO 4** y analiza cuántos resultados devuelve.
