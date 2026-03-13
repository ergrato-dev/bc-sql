# Ejercicio 01 — Índices y EXPLAIN

## Objetivo

Crear índices y verificar con `EXPLAIN` / `EXPLAIN ANALYZE` que
PostgreSQL los usa en lugar de hacer sequential scan.

## Cómo ejecutar

```bash
docker compose -f _scripts/docker-compose.yml exec -T postgres \
  psql -U bootcamp -d bootcamp_db < starter/setup.sql
docker compose -f _scripts/docker-compose.yml exec postgres \
  psql -U bootcamp -d bootcamp_db -f /dev/stdin < starter/ejercicio.sql
```

## Esquema disponible

Tablas: `departments`, `employees`

---

## Paso 1: EXPLAIN sin índice

Ver el plan de ejecución antes de crear el índice:

```sql
EXPLAIN
SELECT * FROM employees WHERE department_id = 2;
-- Resultado esperado: Seq Scan on employees
```

**Abre `starter/ejercicio.sql`** y descomenta la sección **PASO 1**.

---

## Paso 2: Crear un índice y repetir EXPLAIN

```sql
CREATE INDEX idx_employees_department_id
    ON employees (department_id);

EXPLAIN
SELECT * FROM employees WHERE department_id = 2;
-- Resultado esperado: Index Scan o Bitmap Index Scan
```

**Descomenta la sección PASO 2.**

---

## Paso 3: Índice en columna de email (búsqueda exacta)

```sql
CREATE UNIQUE INDEX idx_employees_email
    ON employees (email);

EXPLAIN ANALYZE
SELECT * FROM employees WHERE email = 'ana.garcia@empresa.com';
```

**Descomenta la sección PASO 3.**

---

## Paso 4: Ver los índices creados

```sql
SELECT
    indexname,
    indexdef
FROM pg_indexes
WHERE tablename = 'employees';
```

**Descomenta la sección PASO 4.**
