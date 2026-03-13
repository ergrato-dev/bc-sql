# Ejercicio 02 — Modificar Tablas Existentes

En este ejercicio practicarás `ALTER TABLE` para agregar columnas, renombrar
columnas y renombrar tablas sobre un esquema ya existente.

---

### Paso 1: Cargar el esquema inicial

```bash
sqlite3 exercise.db < starter/setup.sql
sqlite3 exercise.db
```

---

### Paso 2: Agregar columna a employees

El esquema inicial de `employees` no tiene teléfono. Lo agregamos:

```sql
ALTER TABLE employees
ADD COLUMN phone TEXT;
```

**Abre `starter/ejercicio.sql`** y descomenta la sección **PASO 2**.

---

### Paso 3: Agregar columna con NOT NULL + DEFAULT

```sql
ALTER TABLE employees
ADD COLUMN is_active INTEGER NOT NULL DEFAULT 1;
```

> `NOT NULL` sin `DEFAULT` fallaría porque las filas existentes quedarían sin valor.

**Descomenta la sección PASO 3**.

---

### Paso 4: Renombrar una columna

```sql
ALTER TABLE employees
RENAME COLUMN phone TO phone_number;
```

**Descomenta la sección PASO 4**.

---

### Paso 5: Renombrar la tabla

```sql
ALTER TABLE employees
RENAME TO staff;
```

**Descomenta la sección PASO 5**.

---

### Paso 6: Verificar el resultado final

```sql
PRAGMA table_info(staff);
```

**Descomenta la sección PASO 6**.
