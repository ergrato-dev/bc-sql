# Ejercicio 01 — Explorar una Base de Datos Existente

En este ejercicio vas a conectarte a una base de datos SQLite ya creada y
explorarás su estructura antes de escribir cualquier consulta.

---

### Paso 1: Cargar el esquema de prueba

Abre tu terminal y ejecuta:

```bash
sqlite3 exercise.db < starter/setup.sql
```

Luego entra al modo interactivo:

```bash
sqlite3 exercise.db
```

---

### Paso 2: Ver las tablas disponibles

SQLite tiene comandos especiales (llamados *dot commands*) para explorar la BD.

```sql
-- Listar todas las tablas
.tables
```

**Abre `starter/ejercicio.sql`** y descomenta la sección **PASO 2**.

---

### Paso 3: Ver la estructura de una tabla

```sql
-- Ver columnas, tipos de datos y constraints de la tabla products
PRAGMA table_info(products);
```

**Descomenta la sección PASO 3** en `starter/ejercicio.sql`.

---

### Paso 4: Ver todos los registros de una tabla

```sql
-- Ver todos los productos
SELECT id, name, price, category
FROM   products;
```

**Descomenta la sección PASO 4** en `starter/ejercicio.sql`.

---

### Paso 5: Contar registros

```sql
-- Cuántos productos hay en total?
SELECT COUNT(*) AS total_products
FROM   products;
```

**Descomenta la sección PASO 5** en `starter/ejercicio.sql`.
