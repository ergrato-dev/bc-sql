# Ejercicio 02 — Constraints y PRAGMA

## Objetivos

- Crear tablas con constraints completos
- Activar `PRAGMA foreign_keys = ON` para integridad referencial
- Usar `PRAGMA table_info()` para inspeccionar columnas y constraints
- Aplicar `NULLIF` para operaciones seguras

## Prerequisito

Ejecuta `starter/setup.sql` para cargar el esquema.

---

## Paso 1: Verificar constraints con PRAGMA table_info

```sql
PRAGMA table_info(employees);
```

Muestra las columnas, sus tipos y si son NOT NULL.
**Abre `starter/ejercicio.sql`** y descomenta la sección **PASO 1**.

---

## Paso 2: Insertar datos válidos

Inserta un empleado respetando todos los constraints:

```sql
INSERT INTO employees
    (id, first_name, last_name, salary, level, department_id)
VALUES
    (10, 'Hugo', 'Reyes', 62000.00, 'mid', 2);
```

**Descomenta la sección PASO 2**.

---

## Paso 3: NULLIF para división segura

Calcula el bono por unidad de salario, evitando divisiones por cero:

```sql
SELECT
    first_name,
    salary,
    COALESCE(bonus, 0)                           AS bonus,
    COALESCE(bonus, 0) / NULLIF(salary, 0) * 100 AS bonus_pct
FROM employees;
```

**Descomenta la sección PASO 3**.

---

## Paso 4: Verificar integridad referencial

Intenta obtener IDs de departamentos que **no existen** en employees:

```sql
SELECT DISTINCT department_id
FROM   employees
WHERE  department_id NOT IN (SELECT id FROM departments);
```

Debe devolver 0 filas gracias a la FOREIGN KEY.
**Descomenta la sección PASO 4**.
