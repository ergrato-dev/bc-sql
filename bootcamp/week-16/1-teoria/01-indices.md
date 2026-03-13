# Índices — cómo funcionan y cuándo usarlos

## Objetivos

- Entender qué problema resuelve un índice en una tabla grande
- Crear índices con `CREATE INDEX` en PostgreSQL
- Verificar si una consulta usa el índice con `EXPLAIN`

## 1. ¿Qué es un índice?

Sin índice, PostgreSQL recorre **todas las filas** de la tabla (sequential
scan) para encontrar las que coinciden con el WHERE. Con un índice en la
columna del WHERE, usa una estructura B-tree que salta directo a las filas.

```sql
-- Sin índice → Sequential Scan (lento en tablas grandes)
SELECT * FROM employees WHERE email = 'ana@empresa.com';

-- Con índice → Index Scan (muy rápido)
CREATE INDEX idx_employees_email ON employees (email);
SELECT * FROM employees WHERE email = 'ana@empresa.com';
```

> Ver diagrama: [01-btree-index.svg](../0-assets/01-btree-index.svg)

## 2. Crear un índice

```sql
-- Índice simple en una columna
CREATE INDEX idx_employees_department_id
    ON employees (department_id);

-- Índice único — garantiza unicidad + velocidad de búsqueda
CREATE UNIQUE INDEX idx_employees_email
    ON employees (email);

-- Índice compuesto — para WHERE con dos columnas frecuentes
CREATE INDEX idx_employees_dept_salary
    ON employees (department_id, salary DESC);
```

## 3. Verificar con EXPLAIN

`EXPLAIN` muestra el plan de ejecución sin ejecutar la query:

```sql
EXPLAIN
SELECT * FROM employees WHERE department_id = 2;
-- Busca "Index Scan" en lugar de "Seq Scan"
```

`EXPLAIN ANALYZE` ejecuta la query y muestra tiempos reales:

```sql
EXPLAIN ANALYZE
SELECT * FROM employees WHERE department_id = 2;
```

## 4. Cuándo NO indexar

- Tablas pequeñas (< 1 000 filas): el scan secuencial es igual de rápido
- Columnas con muy poca variedad de valores (`is_active` solo tiene TRUE/FALSE)
- Columnas rara vez usadas en WHERE o JOIN
- Tablas con muchos INSERT/UPDATE (el índice se actualiza en cada operación)

## Checklist

- ¿Qué diferencia hay entre Seq Scan e Index Scan en EXPLAIN?
- ¿Cuándo conviene un índice compuesto frente a uno simple?
- ¿Por qué un índice en `is_active` suele ser inútil?
- ¿Qué es un UNIQUE INDEX y qué ventaja da?

## Referencias

- https://www.postgresql.org/docs/16/indexes.html
- https://use-the-index-luke.com/sql/anatomy
