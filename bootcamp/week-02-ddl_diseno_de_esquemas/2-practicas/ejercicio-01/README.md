# Ejercicio 01 — Crear un Esquema desde Cero

En este ejercicio crearás las tablas de un sistema de empleados aplicando
tipos de datos y constraints correctamente.

---

### Paso 1: Preparar entorno limpio

```bash
sqlite3 exercise.db < starter/setup.sql
sqlite3 exercise.db
```

---

### Paso 2: Crear la tabla departments

```sql
CREATE TABLE IF NOT EXISTS departments (
    id   INTEGER PRIMARY KEY,
    name TEXT    NOT NULL UNIQUE
);
```

**Abre `starter/ejercicio.sql`** y descomenta la sección **PASO 2**.

---

### Paso 3: Crear la tabla employees con FK y constraints

```sql
CREATE TABLE IF NOT EXISTS employees (
    id            INTEGER PRIMARY KEY,
    first_name    TEXT    NOT NULL,
    last_name     TEXT    NOT NULL,
    email         TEXT    NOT NULL UNIQUE,
    salary        REAL    NOT NULL DEFAULT 0.00 CHECK (salary >= 0),
    department_id INTEGER,
    FOREIGN KEY (department_id) REFERENCES departments(id)
);
```

**Descomenta la sección PASO 3**.

---

### Paso 4: Crear la tabla projects con CHECK

```sql
CREATE TABLE IF NOT EXISTS projects (
    id         INTEGER PRIMARY KEY,
    name       TEXT    NOT NULL,
    budget     REAL    NOT NULL CHECK (budget > 0),
    status     TEXT    NOT NULL DEFAULT 'active'
                       CHECK (status IN ('active', 'paused', 'closed'))
);
```

**Descomenta la sección PASO 4**.

---

### Paso 5: Verificar la estructura con PRAGMA

```sql
PRAGMA table_info(employees);
```

**Descomenta la sección PASO 5**.
