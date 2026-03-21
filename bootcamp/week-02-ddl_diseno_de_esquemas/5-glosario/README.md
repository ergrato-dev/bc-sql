# 📖 Glosario — Semana 02: DDL: Diseño de Esquemas

Términos clave de esta semana, ordenados alfabéticamente.

---

## A

### **ALTER TABLE**

Instrucción DDL para modificar la estructura de una tabla existente sin
perder los datos. En SQLite soporta `ADD COLUMN`, `RENAME COLUMN` y
`RENAME TO`. No soporta `DROP COLUMN` en versiones anteriores a 3.35.

```sql
ALTER TABLE employees
ADD COLUMN phone TEXT;
```

---

## C

### **CHECK**

Constraint que valida una condición lógica antes de insertar o actualizar
una fila. Si la condición es falsa, la operación falla.

```sql
salary REAL NOT NULL CHECK (salary >= 0)
```

### **Constraint**

Regla aplicada a una columna o tabla para garantizar la integridad de los datos.
Las principales son: `PRIMARY KEY`, `FOREIGN KEY`, `NOT NULL`, `DEFAULT`,
`UNIQUE` y `CHECK`.

### **CREATE TABLE**

Instrucción DDL para crear una nueva tabla con sus columnas, tipos de datos
y constraints.

```sql
CREATE TABLE IF NOT EXISTS products (
    id    INTEGER PRIMARY KEY,
    name  TEXT    NOT NULL
);
```

---

## D

### **DDL (Data Definition Language)**

Subconjunto de SQL para definir y modificar la estructura de la base de datos.
Incluye `CREATE`, `ALTER`, `DROP` y `TRUNCATE`.

### **DEFAULT**

Constraint que asigna un valor automático a una columna cuando no se
especifica en el `INSERT`.

```sql
is_active INTEGER NOT NULL DEFAULT 1
```

### **DROP TABLE**

Instrucción DDL que elimina una tabla y todos sus datos permanentemente.
Se recomienda usar `IF EXISTS` para evitar errores.

---

## I

### **Idempotente**

Un script es idempotente si puede ejecutarse múltiples veces sin producir
errores ni resultados diferentes. Usar `IF NOT EXISTS` y `IF EXISTS` hace
los scripts DDL idempotentes.

---

## N

### **NOT NULL**

Constraint que impide insertar o actualizar una fila con valor nulo en esa
columna. Indica que el dato es obligatorio.

---

## U

### **UNIQUE**

Constraint que garantiza que no existan dos filas con el mismo valor en esa
columna. A diferencia de `PRIMARY KEY`, permite múltiples por tabla.
