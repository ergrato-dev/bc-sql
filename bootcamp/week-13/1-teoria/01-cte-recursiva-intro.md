# CTE recursiva: estructura y funcionamiento

## Objetivos

1. Distinguir el caso base del caso recursivo
2. Entender cómo `UNION ALL` une ambas partes
3. Escribir el primer CTE recursivo funcional

📊 Ver diagrama [0-assets/01-cte-recursiva-estructura.svg](../0-assets/01-cte-recursiva-estructura.svg)

---

## 1. Estructura general

Un CTE recursivo tiene dos partes unidas con `UNION ALL`:

```sql
WITH RECURSIVE nombre_cte AS (
    -- Caso base: la semilla inicial (no referencia al CTE)
    SELECT columna_inicial AS col
    
    UNION ALL
    
    -- Caso recursivo: referencia al mismo CTE
    SELECT col + 1
    FROM nombre_cte
    WHERE col < 5          -- condición de parada
)
SELECT col FROM nombre_cte;
```

---

## 2. Cómo funciona paso a paso

1. Se ejecuta el **caso base** → genera primera fila
2. Se ejecuta el **caso recursivo** usando la fila anterior
3. Se repite hasta que el `WHERE` no produce más filas
4. Se combinan todos los resultados con `UNION ALL`

```sql
WITH RECURSIVE conteo AS (
    SELECT 1 AS n              -- caso base: n = 1
    UNION ALL
    SELECT n + 1               -- caso recursivo: incrementa
    FROM conteo
    WHERE n < 5                -- parar cuando n llega a 5
)
SELECT n FROM conteo;
-- Resultado: 1, 2, 3, 4, 5
```

---

## 3. Reglas de seguridad

- **Siempre** incluir una condición de parada en el caso recursivo
- Sin condición de parada → recursión infinita (error en PostgreSQL)
- PostgreSQL limita la recursión a 100 niveles por defecto (`max_recursion_depth`)

```sql
-- Límite explícito de profundidad
WITH RECURSIVE jerarquia AS (
    SELECT id, name, parent_id, 1 AS depth
    FROM categories
    WHERE parent_id IS NULL
    UNION ALL
    SELECT c.id, c.name, c.parent_id, j.depth + 1
    FROM categories c
    INNER JOIN jerarquia j ON c.parent_id = j.id
    WHERE j.depth < 10          -- máximo 10 niveles
)
SELECT id, name, depth FROM jerarquia ORDER BY depth, name;
```

---

## Checklist

- [ ] ¿El caso base no referencia al propio CTE?
- [ ] ¿Las dos partes están unidas por `UNION ALL`?
- [ ] ¿El caso recursivo tiene condición de parada (`WHERE`)?
- [ ] ¿El nombre del CTE se repite en la parte recursiva?

## Referencias

- https://www.postgresql.org/docs/current/queries-with.html#QUERIES-WITH-RECURSIVE
- https://www.sqlite.org/lang_with.html
