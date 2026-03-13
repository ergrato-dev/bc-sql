# Ejercicio 02 — SELF JOIN para relaciones jerárquicas

## Objetivos

- Usar SELF JOIN con dos aliases para la misma tabla
- Obtener el nombre del jefe de cada empleado
- Contar reportes directos por manager

---

## Paso 1: SELF JOIN básico (INNER JOIN)

El INNER JOIN excluye al CEO (su `manager_id` es NULL).

```sql
-- Empleados con el nombre de su jefe directo
SELECT
    e.first_name  AS employee,
    m.first_name  AS manager
FROM employees e
INNER JOIN employees m ON e.manager_id = m.id;
```

**Abre `starter/ejercicio.sql`** y descomenta el Paso 1.

---

## Paso 2: Incluir al CEO con LEFT JOIN

```sql
SELECT
    e.first_name                   AS employee,
    COALESCE(m.first_name, 'CEO')  AS manager
FROM employees  e
LEFT JOIN employees m ON e.manager_id = m.id
ORDER BY manager, employee;
```

**Descomenta el Paso 2.**

---

## Paso 3: Contar reportes directos

```sql
-- Cuántos empleados reportan directamente a cada manager
SELECT
    m.first_name   AS manager,
    COUNT(e.id)    AS direct_reports
FROM employees  m
LEFT JOIN employees e ON e.manager_id = m.id
GROUP BY m.id, m.first_name
HAVING COUNT(e.id) > 0
ORDER BY direct_reports DESC;
```

**Descomenta el Paso 3.**

---

## Paso 4: Dos niveles jerárquicos

```sql
-- Empleado → su jefe → el jefe del jefe
SELECT
    e.first_name   AS employee,
    m.first_name   AS manager,
    gm.first_name  AS grand_manager
FROM employees e
LEFT JOIN employees m  ON e.manager_id = m.id
LEFT JOIN employees gm ON m.manager_id = gm.id
ORDER BY gm.first_name, m.first_name, e.first_name;
```

**Descomenta el Paso 4.**

---

## Verificación

- ¿El Paso 1 excluye al CEO?
- ¿El Paso 2 muestra al CEO con la etiqueta `'CEO'`?
- ¿El Paso 4 muestra tres columnas con nombres de personas?
