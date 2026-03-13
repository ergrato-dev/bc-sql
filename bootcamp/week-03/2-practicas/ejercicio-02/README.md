# Ejercicio 02 — UPDATE y DELETE: Modificar y eliminar datos

## Objetivos

- Actualizar columnas específicas con `UPDATE … SET … WHERE`
- Borrar filas individuales con `DELETE FROM … WHERE`
- Aplicar el patrón seguro: verificar con `SELECT` antes de modificar

## Prerequisito

Ejecuta `starter/setup.sql` para cargar el esquema con datos de prueba.

---

## Paso 1: Actualizar el salario de un empleado

Siempre incluye `WHERE` con la clave primaria para afectar solo la fila deseada:

```sql
UPDATE employees
SET    salary = 70000.00
WHERE  id = 2;
```

**Abre `starter/ejercicio.sql`** y descomenta la sección **PASO 1**.

---

## Paso 2: Actualizar múltiples columnas a la vez

`SET` acepta varios pares `columna = valor` separados por coma:

```sql
UPDATE employees
SET    salary    = 62000.00,
       last_name = 'Clark'
WHERE  id = 3;
```

**Descomenta la sección PASO 2**.

---

## Paso 3: Actualizar varias filas con una condición

Modificar todas las filas que cumplan un criterio (e.g., subir salario del depto 1):

```sql
UPDATE employees
SET    salary = salary * 1.10
WHERE  department_id = 1;
```

**Descomenta la sección PASO 3** y verifica el resultado con `SELECT`.

---

## Paso 4: DELETE seguro — verificar antes de borrar

Primero confirma qué filas se eliminarán con `SELECT`:

```sql
SELECT id, first_name, email FROM employees WHERE department_id = 3;
```

Luego borra con el mismo `WHERE`:

```sql
DELETE FROM employees WHERE department_id = 3;
```

**Descomenta la sección PASO 4**.

---

## Paso 5: Verificar el estado final

```sql
SELECT * FROM employees ORDER BY id;
```

**Descomenta la sección PASO 5** y confirma que los cambios son correctos.
