# LEFT JOIN: Mantener la Tabla Izquierda

## Objetivos

- Conservar todas las filas de la tabla izquierda con `LEFT JOIN`
- Identificar filas sin relación usando el patrón `IS NULL` en la tabla derecha
- Elegir entre `INNER JOIN` y `LEFT JOIN` según el caso de uso

## Recurso visual

![Diagrama tipos de JOIN](../0-assets/01-tipos-de-join.svg)

---

## 1. Sintaxis y comportamiento

LEFT JOIN devuelve **todas las filas de la tabla izquierda** y, para las
que no tienen coincidencia en la derecha, rellena con NULL:

```sql
SELECT
    d.name        AS department,
    e.first_name,
    e.salary
FROM       departments  d
LEFT JOIN  employees    e ON e.department_id = d.id
ORDER BY d.name;
```

Un departamento sin empleados aparecerá con `first_name = NULL`.

## 2. Detectar filas sin relación (patrón "huérfanos")

```sql
-- Departamentos que NO tienen empleados:
SELECT d.name AS department_sin_empleados
FROM       departments d
LEFT JOIN  employees   e ON e.department_id = d.id
WHERE e.id IS NULL;
```

El truco: filtrar por `IS NULL` en una columna NOT NULL de la tabla derecha.

## 3. INNER JOIN vs LEFT JOIN

| INNER JOIN | LEFT JOIN |
|------------|-----------|
| Solo filas con coincidencia | Todas las filas izquierda + coincidencias |
| Usar cuando la relación siempre existe | Usar cuando puede no existir |
| `d` sin empleados: NO aparece | `d` sin empleados: aparece con NULLs |

## 4. Agregar con LEFT JOIN

Para no contar NULLs, usa `COUNT(columna)` en lugar de `COUNT(*)`:

```sql
SELECT
    d.name,
    COUNT(e.id) AS total_empleados   -- no cuenta NULLs
FROM       departments d
LEFT JOIN  employees   e ON e.department_id = d.id
GROUP BY d.name;
```

---

## ✅ Checklist

- [ ] ¿Qué columnas de la tabla derecha serán NULL cuando no hay coincidencia?
- [ ] ¿Por qué `COUNT(e.id)` es mejor que `COUNT(*)` con LEFT JOIN?
- [ ] ¿En qué columna filtro con IS NULL para encontrar huérfanos?
- [ ] Si cambio `LEFT JOIN` por `INNER JOIN`, ¿qué filas desaparecen?

## Referencias

- https://www.sqlite.org/lang_select.html#joinclause
- https://www.w3schools.com/sql/sql_join_left.asp
