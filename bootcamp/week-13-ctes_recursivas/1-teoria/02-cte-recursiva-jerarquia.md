# Jerarquías con WITH RECURSIVE

## Objetivos

1. Identificar una tabla auto-referencial (columna `parent_id`)
2. Recorrer un árbol jerárquico de cualquier profundidad
3. Calcular el nivel de profundidad y el path completo

📊 Ver diagrama [0-assets/02-jerarquia-org.svg](../0-assets/02-jerarquia-org.svg)

---

## 1. Tabla auto-referencial

Una tabla auto-referencial tiene una columna que apunta a otra fila
de la misma tabla (relación padre → hijos):

```sql
CREATE TABLE employees (
    employee_id  SERIAL PRIMARY KEY,
    first_name   TEXT   NOT NULL,
    manager_id   INT    REFERENCES employees (employee_id)
    -- manager_id NULL significa que es el nodo raíz
);
```

---

## 2. Recorrer la jerarquía

```sql
WITH RECURSIVE org_chart AS (
    -- Caso base: empleados sin manager (CEO / raíz)
    SELECT
        employee_id,
        first_name,
        manager_id,
        1                    AS depth,
        first_name           AS path
    FROM employees
    WHERE manager_id IS NULL

    UNION ALL

    -- Caso recursivo: empleados cuyo manager ya está en el CTE
    SELECT
        e.employee_id,
        e.first_name,
        e.manager_id,
        oc.depth + 1,
        oc.path || ' > ' || e.first_name
    FROM employees e
    INNER JOIN org_chart oc ON e.manager_id = oc.employee_id
)
SELECT
    depth,
    REPEAT('  ', depth - 1) || first_name AS indented_name,
    path
FROM org_chart
ORDER BY path;
```

---

## 3. Columnas útiles en jerarquías

| Columna | Fórmula | Descripción |
|---------|---------|-------------|
| `depth` | `1` en base, `depth + 1` en recursivo | Nivel en el árbol |
| `path` | concatenar nombres con ` > ` | Ruta completa desde la raíz |
| `is_leaf` | `NOT EXISTS (SELECT 1 FROM t WHERE parent_id = id)` | ¿Tiene hijos? |

---

## Checklist

- [ ] ¿El caso base usa `WHERE parent_id IS NULL` (o la raíz)?
- [ ] ¿El `JOIN` en la parte recursiva conecta `parent_id = oc.id`?
- [ ] ¿La columna `depth` se incrementa en cada paso?
- [ ] ¿El path se construye concatenando con `||`?

## Referencias

- https://www.postgresql.org/docs/current/queries-with.html#QUERIES-WITH-RECURSIVE
- https://use-the-index-luke.com/sql/where-clause/obfuscation/subqueries
