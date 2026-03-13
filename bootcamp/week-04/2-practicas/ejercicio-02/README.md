# Ejercicio 02 — ORDER BY, LIMIT y OFFSET

## Objetivos

- Ordenar resultados de forma ascendente y descendente
- Obtener los Top-N usando `LIMIT`
- Implementar paginación con `LIMIT` y `OFFSET`

## Prerequisito

Ejecuta `starter/setup.sql` para cargar el esquema con datos.

---

## Paso 1: ORDER BY simple

Ordena empleados por salario de mayor a menor:

```sql
SELECT first_name, salary
FROM   employees
ORDER BY salary DESC;
```

**Abre `starter/ejercicio.sql`** y descomenta la sección **PASO 1**.

---

## Paso 2: ORDER BY con múltiples columnas

Ordena por departamento (ASC) y luego por apellido (ASC):

```sql
SELECT first_name, last_name, department_id
FROM   employees
ORDER BY department_id ASC,
         last_name     ASC;
```

**Descomenta la sección PASO 2**.

---

## Paso 3: Top-3 salarios más altos

```sql
SELECT first_name, salary
FROM   employees
ORDER BY salary DESC
LIMIT 3;
```

**Descomenta la sección PASO 3**.

---

## Paso 4: Paginación — páginas de 2 empleados

```sql
-- Página 1
SELECT first_name, salary FROM employees ORDER BY salary DESC LIMIT 2 OFFSET 0;

-- Página 2
SELECT first_name, salary FROM employees ORDER BY salary DESC LIMIT 2 OFFSET 2;

-- Página 3
SELECT first_name, salary FROM employees ORDER BY salary DESC LIMIT 2 OFFSET 4;
```

**Descomenta la sección PASO 4** y observa los resultados de las tres páginas.
