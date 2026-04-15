---
applyTo: "**/*.sql"
---

# Convenciones SQL — bc-sql Bootcamp

## Estilo obligatorio

- Keywords SQL siempre en **UPPERCASE**: `SELECT`, `FROM`, `WHERE`, `JOIN`, etc.
- Identificadores (tablas, columnas, alias) en **snake_case en inglés**
- Comentarios y explicaciones en **español**
- Indentación de **4 espacios** (nunca tabs)
- Cada cláusula principal en su **propia línea**
- Strings con **comillas simples** únicamente (`'value'`, nunca `"value"`)
- Longitud máxima de línea: **80 caracteres**

## Tipos de PRIMARY KEY según motor

```sql
-- SQLite (semanas 1–12)
id  INTEGER  PRIMARY KEY

-- PostgreSQL (semanas 13–24)
id  SERIAL   PRIMARY KEY

-- PostgreSQL alto volumen (audit_log, eventos)
id  BIGSERIAL  PRIMARY KEY
```

Nunca usar `INTEGER PRIMARY KEY AUTOINCREMENT` en SQLite.
Nunca usar UUID como PK por defecto.

## Nomenclatura

| Elemento | Patrón | Ejemplo |
|---|---|---|
| Tablas | snake_case plural | `order_items` |
| Columnas | snake_case descriptivo | `created_at`, `is_active` |
| PK | `id` o `<singular>_id` | `employee_id` |
| FK | `<tabla_ref_singular>_id` | `department_id` |
| Índices | `idx_<tabla>_<col>` | `idx_employees_dept` |
| Vistas | `v_<nombre>` | `v_active_employees` |
| Procedimientos | `sp_<nombre>` | `sp_calculate_salary` |
| Funciones | `fn_<nombre>` | `fn_get_full_name` |

## Estructura de archivos setup.sql

```sql
-- ============================================
-- Semana XX: Tema
-- Setup — Ejercicio YY
-- Motor: SQLite | PostgreSQL 16
-- ============================================

-- Limpiar estado previo
DROP TABLE IF EXISTS child_table;
DROP TABLE IF EXISTS parent_table;

-- Crear tablas
CREATE TABLE parent_table ( ... );
CREATE TABLE child_table ( ... );

-- Datos de prueba
INSERT INTO parent_table (...) VALUES (...), (...);
INSERT INTO child_table (...) VALUES (...), (...);
```

## Seguridad

- Nunca construir queries con concatenación de strings (SQL Injection)
- Usar parámetros preparados al integrar con código de aplicación
- Enmascarar datos sensibles: `password_hash` no `password`
- Nunca `SELECT *` en queries de producción

## Proyectos (3-proyecto/) vs Ejercicios (2-practicas/)

- **Ejercicios**: consultas comentadas que el alumno descomenta paso a paso
- **Proyectos**: `-- TODO:` para que el alumno implemente desde cero
