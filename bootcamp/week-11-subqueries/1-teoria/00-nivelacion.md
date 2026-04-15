# Nivelación — Prerequisitos para Semana 11

> **¿Para quién es este archivo?**
> Si comienzas el bootcamp desde la semana 11 (Etapa 1), este resumen
> cubre los conceptos esenciales de las semanas 4–10 que necesitas
> dominar antes de trabajar con subqueries.

---

## 1. SELECT básico (Semana 04)

```sql
-- Seleccionar columnas específicas con alias, ordenar y limitar
SELECT
    first_name,
    salary,
    salary * 1.1 AS salary_with_bonus
FROM employees
WHERE is_active = 1
ORDER BY salary DESC
LIMIT 5;
```

Cláusulas clave: `SELECT`, `FROM`, `WHERE`, `ORDER BY`, `LIMIT`, `OFFSET`.

---

## 2. Operadores y filtros (Semana 05)

```sql
-- BETWEEN, IN, LIKE y operadores lógicos combinados
SELECT first_name, salary, level
FROM employees
WHERE salary BETWEEN 50000 AND 80000
  AND level IN ('mid', 'sr')
  AND email LIKE '%@example.com';
```

`NOT IN`, `NOT LIKE`, `AND`, `OR`, `NOT` también son parte del conjunto.

---

## 3. Funciones de agregación (Semana 06)

```sql
-- Resumen por departamento con filtro de grupo (HAVING)
SELECT
    department_id,
    COUNT(*)          AS total,
    ROUND(AVG(salary), 2) AS avg_salary,
    MAX(salary)       AS max_salary
FROM employees
WHERE is_active = 1
GROUP BY department_id
HAVING COUNT(*) > 2;
```

`COUNT`, `SUM`, `AVG`, `MIN`, `MAX` ignoran `NULL` (excepto `COUNT(*)`).
`WHERE` filtra filas antes de agrupar; `HAVING` filtra grupos después.

---

## 4. NULL y COALESCE (Semana 07)

```sql
-- Detectar y reemplazar NULLs
SELECT
    first_name,
    COALESCE(department_id, 0)  AS dept,
    NULLIF(salary, 0)           AS salary_clean
FROM employees
WHERE email IS NOT NULL;
```

`IS NULL` / `IS NOT NULL` para filtrar. `COALESCE` devuelve el primer
valor no nulo. `NULLIF(a, b)` devuelve `NULL` si `a = b`.

---

## 5. INNER JOIN y LEFT JOIN (Semana 09)

```sql
-- INNER JOIN: solo filas con coincidencia en ambos lados
SELECT e.first_name, d.name AS department
FROM employees e
INNER JOIN departments d ON e.department_id = d.id;

-- LEFT JOIN: todos los empleados, departamento NULL si no tiene
SELECT e.first_name, d.name AS department
FROM employees e
LEFT JOIN departments d ON e.department_id = d.id;
```

Regla rápida: `INNER JOIN` excluye huérfanos; `LEFT JOIN` los conserva.

---

## 6. SELF JOIN — jerarquías (Semana 10)

```sql
-- Empleado junto a su manager (auto-referencia)
SELECT
    e.first_name  AS empleado,
    m.first_name  AS manager
FROM employees e
LEFT JOIN employees m ON e.manager_id = m.id;
```

Un `SELF JOIN` une la tabla consigo misma usando alias distintos.

---

## Checklist de autoevaluación

Antes de continuar con la semana 11, comprueba que puedes responder:

- [ ] ¿Puedes filtrar filas con `WHERE` usando `IN`, `BETWEEN` y `LIKE`?
- [ ] ¿Sabes cuándo usar `HAVING` en lugar de `WHERE`?
- [ ] ¿Puedes combinar dos tablas con `INNER JOIN` y con `LEFT JOIN`?
- [ ] ¿Entiendes qué devuelve `COALESCE` cuando el valor es `NULL`?

Si alguna respuesta es "no", revisa la semana correspondiente antes
de avanzar.
