# Ejercicio 01 — CROSS JOIN para generar combinaciones

## Objetivos

- Escribir un CROSS JOIN para generar el producto cartesiano
- Calcular el número esperado de filas resultantes
- Filtrar el resultado con WHERE

---

## Paso 1: CROSS JOIN básico

El `CROSS JOIN` combina cada fila de una tabla con cada fila de la otra.
No requiere condición `ON`.

```sql
-- Todas las combinaciones de departamento × nivel
SELECT
    d.name   AS department,
    l.name   AS level
FROM departments d
CROSS JOIN job_levels l
ORDER BY d.name, l.rank;
```

Con 4 departamentos y 3 niveles → **12 filas**.

**Abre `starter/ejercicio.sql`** y descomenta el Paso 1.

---

## Paso 2: Verificar el total de filas

```sql
-- Cuenta el total de combinaciones
SELECT COUNT(*) AS total_combinations
FROM departments d
CROSS JOIN job_levels l;
```

**Descomenta el Paso 2.**

---

## Paso 3: Filtrar combinaciones con WHERE

```sql
-- Solo combinaciones del departamento Engineering
SELECT
    d.name  AS department,
    l.name  AS level
FROM departments  d
CROSS JOIN job_levels l
WHERE d.name = 'Engineering'
ORDER BY l.rank;
```

**Descomenta el Paso 3.**

---

## Paso 4: CROSS JOIN con columna calculada

```sql
-- Grilla de salarios base: dept × nivel con sueldo estimado
SELECT
    d.name          AS department,
    l.name          AS level,
    l.base_salary   AS base_salary
FROM departments  d
CROSS JOIN job_levels l
ORDER BY d.name, l.rank;
```

**Descomenta el Paso 4.**

---

## Verificación

- ¿El Paso 1 produce exactamente 12 filas?
- ¿El Paso 3 produce 3 filas (solo Engineering)?
