# Ejercicio 01 — DDL + DML Integrado

## Objetivos

- Crear un esquema completo con tres tablas relacionadas
- Insertar datos respetando todos los constraints
- Verificar la estructura creada con `PRAGMA table_info`

## Prerequisito

Ejecuta `starter/setup.sql` para limpiar el entorno.

---

## Paso 1: Activar FK y crear la tabla locations

```sql
PRAGMA foreign_keys = ON;

CREATE TABLE locations (
    id      INTEGER PRIMARY KEY,
    name    TEXT    NOT NULL UNIQUE,
    country TEXT    NOT NULL DEFAULT 'Colombia'
);
```

**Abre `starter/ejercicio.sql`** y descomenta la sección **PASO 1**.

---

## Paso 2: Crear departments con FK a locations

```sql
CREATE TABLE departments (
    id          INTEGER PRIMARY KEY,
    name        TEXT    NOT NULL UNIQUE,
    budget      REAL    CHECK (budget > 0),
    location_id INTEGER NOT NULL
        REFERENCES locations(id) ON DELETE RESTRICT
);
```

**Descomenta la sección PASO 2**.

---

## Paso 3: Crear employees con constraints completos

```sql
CREATE TABLE employees (
    id            INTEGER PRIMARY KEY,
    first_name    TEXT    NOT NULL,
    last_name     TEXT    NOT NULL,
    email         TEXT    UNIQUE,
    salary        REAL    NOT NULL CHECK (salary > 0),
    level         TEXT    CHECK (level IN ('junior', 'mid', 'senior')),
    is_active     INTEGER NOT NULL DEFAULT 1,
    department_id INTEGER NOT NULL
        REFERENCES departments(id) ON DELETE RESTRICT
);
```

**Descomenta la sección PASO 3**.

---

## Paso 4: Insertar datos y verificar

Inserta los registros de prueba, luego verifica con `PRAGMA table_info`.

**Descomenta la sección PASO 4**.
