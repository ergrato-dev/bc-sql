# CROSS JOIN — Producto Cartesiano

## Objetivo

Al terminar esta sección, podrás:

- Explicar qué es el producto cartesiano en SQL
- Escribir un CROSS JOIN sin cláusula ON
- Identificar casos de uso reales y el riesgo de rendimiento

## Diagrama

→ [Visualización CROSS JOIN](../0-assets/01-cross-join-visual.svg)

---

## 1. ¿Qué produce un CROSS JOIN?

Combina **cada fila** de la tabla A con **cada fila** de la tabla B.
No requiere cláusula `ON` — no hay condición de coincidencia.

El resultado siempre tiene `filas_A × filas_B` registros.

```sql
SELECT
    a.col,
    b.col
FROM table_a a
CROSS JOIN table_b b;
```

---

## 2. Ejemplo: grilla de departamentos y niveles

```sql
-- Genera todas las combinaciones dept × seniority
SELECT
    d.name  AS department,
    l.name  AS level
FROM departments d
CROSS JOIN job_levels l
ORDER BY d.name, l.rank;
```

Con 4 departamentos y 3 niveles → **12 combinaciones**.

---

## 3. Cuándo usarlo

| Caso de uso | Ejemplo |
|-------------|---------|
| Generar combinaciones | Turnos × días de la semana |
| Grillas de precios | Productos × descuentos posibles |
| Sets de prueba | Datos sintéticos para testing |

---

## 4. Advertencia de rendimiento

El número de filas crece exponencialmente:

- 100 × 100 = **10 000 filas**
- 1 000 × 1 000 = **1 000 000 filas**

Siempre usar `WHERE` o `LIMIT` cuando el resultado no necesita ser completo.

---

## Checklist

- [ ] ¿Sabes cuántas filas produce `A CROSS JOIN B`?
- [ ] ¿Puedes escribir un CROSS JOIN sin cláusula ON?
- [ ] ¿Identificas un caso de uso válido en tu dominio?
- [ ] ¿Entiendes el riesgo con tablas grandes?

## Referencias

- https://www.sqlite.org/lang_select.html#join_clause
- https://www.w3schools.com/sql/sql_join_cross.asp
