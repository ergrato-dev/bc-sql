# Ejercicio 01 — JOIN LATERAL básico

## Tema

Practicar la sintaxis de `JOIN LATERAL` para correlacionar
filas de una tabla con una subquery que depende de esa fila.

## Cómo ejecutar

1. Levanta el contenedor:
   ```bash
   docker compose -f scripts/docker-compose.yml up -d
   ```
2. Carga el esquema:
   ```bash
   docker compose -f scripts/docker-compose.yml exec -T postgres \
     psql -U bootcamp -d bootcamp_db < bootcamp/week-20-lateral_joins_y_funciones_en_from/2-practicas/ejercicio-01/starter/setup.sql
   ```
3. Conéctate:
   ```bash
   docker compose -f scripts/docker-compose.yml exec postgres \
     psql -U bootcamp -d bootcamp_db
   ```
4. Abre `starter/ejercicio.sql` y sigue los pasos.

---

## Esquema de trabajo

Tablas: `departments`, `employees`, `sales`.

### Paso 1: La venta más reciente de cada empleado

Usa `JOIN LATERAL` para obtener la venta más reciente
(por `sale_date`) de cada empleado.

```sql
SELECT
    e.id,
    e.name,
    last_sale.product_name,
    last_sale.amount,
    last_sale.sale_date
FROM employees e
JOIN LATERAL (
    SELECT product_name, amount, sale_date
    FROM sales
    WHERE employee_id = e.id
    ORDER BY sale_date DESC
    LIMIT 1
) AS last_sale ON TRUE
ORDER BY e.id;
```

**Abre `starter/ejercicio.sql`** y descomenta la sección "PASO 1".

---

### Paso 2: Empleados SIN ventas con LEFT JOIN LATERAL

Incluye empleados sin ninguna venta usando `LEFT JOIN LATERAL`.
Observa que `last_sale.*` será `NULL` para esos empleados.

```sql
SELECT
    e.id,
    e.name,
    last_sale.product_name,
    last_sale.amount
FROM employees e
LEFT JOIN LATERAL (
    SELECT product_name, amount
    FROM sales
    WHERE employee_id = e.id
    ORDER BY amount DESC
    LIMIT 1
) AS last_sale ON TRUE
ORDER BY e.id;
```

**Descomenta la sección "PASO 2".**

---

### Paso 3: Total y promedio de ventas por empleado con LATERAL

Obtén el total, promedio y número de ventas de cada empleado
en una sola subquery lateral con múltiples columnas de agregación.

```sql
SELECT
    e.id,
    e.name,
    stats.total_sales,
    stats.avg_amount,
    stats.num_sales
FROM employees e
CROSS JOIN LATERAL (
    SELECT
        COUNT(*)            AS num_sales,
        COALESCE(SUM(amount), 0)   AS total_sales,
        COALESCE(AVG(amount), 0)   AS avg_amount
    FROM sales
    WHERE employee_id = e.id
) AS stats
ORDER BY stats.total_sales DESC;
```

**Descomenta la sección "PASO 3".**

---

### Paso 4: Subquery lateral vs subquery correlacionada en SELECT

Compara la legibilidad de obtener múltiples estadísticas
en `SELECT` (múltiples subqueries) versus una sola `LATERAL`.

```sql
-- Sin LATERAL — múltiples subqueries en SELECT
SELECT
    e.name,
    (SELECT COUNT(*) FROM sales WHERE employee_id = e.id) AS num_sales,
    (SELECT COALESCE(SUM(amount), 0) FROM sales
     WHERE employee_id = e.id)                            AS total_sales
FROM employees e;

-- Con LATERAL — una sola subquery
SELECT e.name, s.num_sales, s.total_sales
FROM employees e
CROSS JOIN LATERAL (
    SELECT COUNT(*) AS num_sales,
           COALESCE(SUM(amount), 0) AS total_sales
    FROM sales WHERE employee_id = e.id
) AS s;
```

**Descomenta la sección "PASO 4".**
