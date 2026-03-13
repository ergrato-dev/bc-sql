# Jerarquías con SELF JOIN

## Objetivo

Al terminar esta sección, podrás:

- Modelar una relación jerárquica con una columna auto-referencial
- Contar los reportes directos de cada manager
- Encadenar dos SELF JOINs para obtener dos niveles de la jerarquía

## Diagrama

→ [Jerarquía con SELF JOIN](../0-assets/02-self-join-jerarquia.svg)

---

## 1. Columna auto-referencial

La clave está en una FK que apunta a la **misma tabla**:

```sql
CREATE TABLE employees (
    id         INTEGER PRIMARY KEY,
    first_name TEXT    NOT NULL,
    manager_id INTEGER REFERENCES employees (id)  -- auto-referencial
);
```

Un empleado sin jefe tiene `manager_id = NULL` (raíz de la jerarquía).

---

## 2. Contar reportes directos por manager

```sql
SELECT
    m.first_name   AS manager,
    COUNT(e.id)    AS direct_reports
FROM employees  m
LEFT JOIN employees e ON e.manager_id = m.id
GROUP BY m.id, m.first_name
HAVING COUNT(e.id) > 0
ORDER BY direct_reports DESC;
```

---

## 3. Dos niveles jerárquicos en una consulta

```sql
-- Empleado → su jefe → el jefe del jefe
SELECT
    e.first_name   AS employee,
    m.first_name   AS manager,
    gm.first_name  AS grand_manager
FROM employees e
LEFT JOIN employees m  ON e.manager_id = m.id
LEFT JOIN employees gm ON m.manager_id = gm.id;
```

Cada nivel adicional requiere un JOIN extra con un nuevo alias.

---

## 4. Limitación

Para jerarquías de profundidad variable (árbol de N niveles) los SELF JOINs
múltiples no escalan. La solución son las **CTEs recursivas** (semana 12).

---

## Checklist

- [ ] ¿Defines `manager_id` como FK hacia la misma tabla?
- [ ] ¿Puedes contar los reportes directos de cada manager?
- [ ] ¿Entiendes por qué el CEO tiene `manager_id = NULL`?
- [ ] ¿Sabes cuándo un SELF JOIN de 2 niveles no es suficiente?

## Referencias

- https://www.sqlite.org/lang_createtable.html
- https://learnsql.com/blog/sql-recursive-cte/
