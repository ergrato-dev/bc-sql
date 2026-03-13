# Ejercicio 02 — Escribir Consultas SELECT Básicas

En este ejercicio practicarás las cláusulas fundamentales de una consulta
`SELECT`: filtrar con `WHERE`, ordenar con `ORDER BY` y limitar resultados con
`LIMIT`.

---

### Paso 1: Cargar el esquema

```bash
sqlite3 exercise.db < starter/setup.sql
sqlite3 exercise.db
```

---

### Paso 2: SELECT con columnas específicas

Evita `SELECT *`. Lista siempre las columnas que necesitas.

```sql
-- Obtener solo nombre y precio de todos los productos
SELECT name, price
FROM   products;
```

**Abre `starter/ejercicio.sql`** y descomenta la sección **PASO 2**.

---

### Paso 3: Filtrar con WHERE

```sql
-- Productos con precio menor o igual a 20
SELECT name, price
FROM   products
WHERE  price <= 20;
```

**Descomenta la sección PASO 3**.

---

### Paso 4: Filtrar por texto con WHERE

```sql
-- Productos cuyo nombre empiece por 'S'
SELECT name, price
FROM   products
WHERE  name LIKE 'S%';
```

**Descomenta la sección PASO 4**.

---

### Paso 5: Ordenar resultados con ORDER BY

```sql
-- Productos ordenados por precio de mayor a menor
SELECT name, price
FROM   products
ORDER BY price DESC;
```

**Descomenta la sección PASO 5**.

---

### Paso 6: Limitar resultados con LIMIT

```sql
-- Los 3 productos más caros
SELECT name, price
FROM   products
ORDER BY price DESC
LIMIT  3;
```

**Descomenta la sección PASO 6**.
