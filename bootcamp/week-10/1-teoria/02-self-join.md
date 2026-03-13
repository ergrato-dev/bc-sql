# SELF JOIN — Unir una tabla consigo misma

## Objetivo

Al terminar esta sección, podrás:

- Escribir un SELF JOIN con dos aliases distintos para la misma tabla
- Recuperar la relación jefe → empleado en una sola consulta
- Usar LEFT JOIN en el SELF JOIN para incluir el nivel raíz

## Diagrama

→ [Jerarquía con SELF JOIN](../0-assets/02-self-join-jerarquia.svg)

---

## 1. ¿Qué es un SELF JOIN?

Un `SELF JOIN` une **una tabla consigo misma**. SQL la trata como dos tablas
distintas gracias a **aliases diferentes**.

```sql
-- La misma tabla aparece dos veces con roles distintos
FROM employees e        -- rol: "el empleado"
JOIN employees m        -- rol: "el manager"
  ON e.manager_id = m.id
```

---

## 2. Ejemplo: empleado con su jefe directo

```sql
SELECT
    e.first_name               AS employee,
    m.first_name               AS manager
FROM employees e
INNER JOIN employees m ON e.manager_id = m.id;
```

> `INNER JOIN` excluye filas donde `manager_id` es NULL (el CEO).

---

## 3. Incluir al CEO con LEFT JOIN

El director general no tiene jefe: su `manager_id` es `NULL`.
Con `LEFT JOIN` aparece en el resultado con `NULL` en la columna manager.

```sql
SELECT
    e.first_name                   AS employee,
    COALESCE(m.first_name, 'CEO')  AS manager
FROM employees  e
LEFT JOIN employees m ON e.manager_id = m.id;
```

---

## 4. Regla obligatoria: aliases siempre distintos

```sql
-- ❌ Incorrecto — SQL no distingue de qué instancia es cada columna
SELECT first_name FROM employees JOIN employees ON manager_id = id;

-- ✅ Correcto — aliases claros con roles semánticos
SELECT e.first_name, m.first_name
FROM employees e
JOIN employees m ON e.manager_id = m.id;
```

---

## Checklist

- [ ] ¿Usas siempre dos aliases distintos en un SELF JOIN?
- [ ] ¿Sabes cuándo usar INNER vs LEFT en el SELF JOIN?
- [ ] ¿Identificas cuál alias es "el hijo" y cuál "el padre"?
- [ ] ¿Lees `e.manager_id = m.id` como "el manager de e es m"?

## Referencias

- https://www.w3schools.com/sql/sql_join_self.asp
- https://learnsql.com/blog/what-is-self-join-sql/
