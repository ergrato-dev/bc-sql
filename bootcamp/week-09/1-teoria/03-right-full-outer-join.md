# RIGHT JOIN y FULL OUTER JOIN

## Objetivos

- Entender RIGHT JOIN como espejo de LEFT JOIN
- Conocer FULL OUTER JOIN y su equivalente en SQLite antiguo
- Distinguir cuándo cada tipo de join es apropiado

## Recurso visual

![Diagrama tipos de JOIN](../0-assets/01-tipos-de-join.svg)

---

## 1. RIGHT JOIN

Conserva todas las filas de la **tabla derecha** (lo opuesto a LEFT JOIN):

```sql
-- Todos los departamentos, con o sin empleados
SELECT
    e.first_name,
    d.name AS department
FROM      employees    e
RIGHT JOIN departments d ON e.department_id = d.id;
```

> RIGHT JOIN está disponible en SQLite ≥ 3.39.0 (julio 2022).
> Para versiones anteriores, invierte las tablas y usa LEFT JOIN.

## 2. LEFT JOIN como alternativa a RIGHT JOIN

Un RIGHT JOIN siempre puede reescribirse como LEFT JOIN invirtiendo tablas:

```sql
-- Equivalentes
SELECT e.first_name, d.name
FROM employees e RIGHT JOIN departments d ON e.department_id = d.id;

-- ✅ Preferido — funciona en todas las versiones
SELECT e.first_name, d.name
FROM departments d LEFT JOIN employees e ON e.department_id = d.id;
```

## 3. FULL OUTER JOIN

Devuelve **todas las filas de ambas tablas**, rellenando NULLs donde no
hay coincidencia:

```sql
SELECT e.first_name, d.name
FROM employees e FULL OUTER JOIN departments d ON e.department_id = d.id;
```

> FULL OUTER JOIN también requiere SQLite ≥ 3.39.0.

## 4. Emular FULL OUTER JOIN con UNION

Para compatibilidad, combina LEFT JOIN + RIGHT JOIN (o dos LEFT JOINs):

```sql
SELECT e.first_name, d.name
FROM employees e LEFT JOIN departments d ON e.department_id = d.id
UNION
SELECT e.first_name, d.name
FROM departments d LEFT JOIN employees e ON e.department_id = d.id;
```

---

## ✅ Checklist

- [ ] ¿Puedes reescribir cualquier RIGHT JOIN como LEFT JOIN?
- [ ] ¿Qué versión de SQLite tienes? (`SELECT sqlite_version();`)
- [ ] ¿Cuándo tiene sentido usar FULL OUTER JOIN?
- [ ] ¿Qué devuelve FULL OUTER JOIN cuando no hay coincidencia en ninguna tabla?

## Referencias

- https://www.sqlite.org/lang_select.html#joinclause
- https://www.w3schools.com/sql/sql_join_right.asp
