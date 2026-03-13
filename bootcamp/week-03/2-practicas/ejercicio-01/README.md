# Ejercicio 01 — INSERT INTO: Poblar el esquema de empleados

## Objetivos

- Insertar filas con todas las columnas listadas explícitamente
- Insertar múltiples filas en un solo `INSERT`
- Verificar los datos insertados con `SELECT`

## Prerequisito

El esquema fue creado en la Semana 02. Ejecuta `starter/setup.sql` para recrearlo limpio.

---

## Paso 1: Insertar un departamento

El comando básico requiere listar columnas y sus valores en el mismo orden:

```sql
INSERT INTO departments (id, name, location)
VALUES (1, 'Engineering', 'Floor 3');
```

**Abre `starter/ejercicio.sql`** y descomenta la sección **PASO 1**.

---

## Paso 2: Insertar múltiples departamentos

Se puede insertar varias filas en una sola sentencia separando los grupos con coma:

```sql
INSERT INTO departments (id, name, location)
VALUES
    (2, 'Marketing', 'Floor 1'),
    (3, 'Finance',   'Floor 2');
```

**Descomenta la sección PASO 2**.

---

## Paso 3: Insertar empleados con clave foránea

Al insertar en `employees`, el valor de `department_id` debe existir en `departments`:

```sql
INSERT INTO employees (id, first_name, last_name, email, salary, department_id)
VALUES (1, 'Alice', 'Johnson', 'alice@company.com', 72000.00, 1);
```

**Descomenta la sección PASO 3**.

---

## Paso 4: Verificar los datos insertados

```sql
SELECT * FROM departments;
SELECT * FROM employees;
```

**Descomenta la sección PASO 4** y compara con los resultados esperados del README.
