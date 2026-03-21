# CREATE VIEW — Vistas en PostgreSQL

## Objetivos

- Crear vistas para encapsular consultas complejas con window functions
- Consultar una vista como si fuera una tabla
- Entender las limitaciones de las vistas ordinarias

## 1. ¿Qué es una vista?

Una vista es una **consulta guardada** con nombre. No almacena datos;
ejecuta la query cada vez que se consulta.

```sql
-- Crea una vista con los rankings por departamento
CREATE VIEW v_dept_salary_rank AS
SELECT
    e.employee_id,
    e.first_name,
    e.salary,
    d.name AS department_name,
    DENSE_RANK() OVER (
        PARTITION BY e.department_id
        ORDER BY e.salary DESC
    ) AS dept_rank
FROM employees e
INNER JOIN departments d ON d.id = e.department_id;
```

## 2. Consultar una vista

Una vez creada, se usa como una tabla ordinaria:

```sql
-- Los top-2 de cada departamento usando la vista
SELECT *
FROM v_dept_salary_rank
WHERE dept_rank <= 2
ORDER BY department_name, dept_rank;
```

## 3. Reemplazar una vista

```sql
-- Actualiza la vista sin borrarla primero
CREATE OR REPLACE VIEW v_dept_salary_rank AS
SELECT
    e.employee_id,
    e.first_name,
    e.last_name,
    e.salary,
    d.name AS department_name,
    DENSE_RANK() OVER (
        PARTITION BY e.department_id
        ORDER BY e.salary DESC
    ) AS dept_rank
FROM employees e
INNER JOIN departments d ON d.id = e.department_id;
```

## 4. Eliminar una vista

```sql
DROP VIEW IF EXISTS v_dept_salary_rank;
```

## Checklist

- ¿Cuándo conviene crear una vista en lugar de una CTE?
- ¿Puedes insertar datos en una vista?
- ¿Qué hace `CREATE OR REPLACE VIEW`?
- ¿Diferencia entre vista ordinaria y vista materializada?

## Referencias

- https://www.postgresql.org/docs/16/sql-createview.html
- https://www.postgresql.org/docs/16/tutorial-views.html
