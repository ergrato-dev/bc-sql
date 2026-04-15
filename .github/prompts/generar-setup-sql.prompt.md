---
mode: agent
description: Genera un setup.sql con datos de prueba realistas y volumen apropiado para la semana indicada.
---

Genera un archivo `setup.sql` con datos de prueba para el bootcamp bc-sql.

## Parámetros

- **Semana**: [COMPLETAR — ej. 06]
- **Motor**: [COMPLETAR — SQLite | PostgreSQL 16]
- **Tablas necesarias**: [COMPLETAR — ej. employees, departments, locations]
- **Propósito**: [COMPLETAR — ej. practicar GROUP BY y HAVING con distribuciones desiguales]
- **Volumen de datos**: [COMPLETAR o dejar en blanco para usar el recomendado]

## Esquema base HR del bootcamp

El bootcamp usa un esquema evolutivo de Recursos Humanos:

```
locations   (id, name, country, region)
    ↓ 1:N
departments (id, name, budget, location_id, is_active)
    ↓ 1:N
employees   (id, first_name, last_name, email, salary, level, is_active,
             department_id, manager_id?)
```

Amplía o adapta este esquema según el tema de la semana.

## Volumen recomendado por etapa

| Semanas | Rows employees | Rows departments | Notas |
|---|---|---|---|
| 1–5 | 8–10 | 3–4 | Alumno puede trazar a mano |
| 6–12 | 25–35 | 6–8 | Distribuciones desiguales visibles |
| 13–16 | 50–100 (generate_series) | 8–10 | Empates para window functions |
| 17–24 | 500–5000 (generate_series) | según tema | Volumen real para EXPLAIN |

## Reglas de calidad de datos

- Distribuciones **desiguales**: algunos departamentos con muchos empleados,
  otros con pocos (evitar que todos tengan el mismo COUNT)
- Incluir **casos edge**: al menos 1 empleado sin departamento (`NULL`),
  1 departamento sin empleados, algunos salarios en empate
- Rangos de salario realistas: `jr` 35k–55k, `mid` 55k–80k, `sr` 75k–110k
- Nombres realistas (no `foo`, `bar`, `test1`): mezclar nombres anglosajones
  y latinoamericanos (Alice, Carlos, María, Bob, Sofía, David…)
- Emails en formato `nombre@example.com`

## Semanas 13–24 con generate_series (PostgreSQL)

```sql
-- Patrón para inserción masiva en PostgreSQL
INSERT INTO employees (first_name, last_name, salary, department_id, level, is_active)
SELECT
    'Emp' || g,
    'Apellido' || g,
    CASE (g % 3)
        WHEN 0 THEN (35000 + (g % 20) * 1000)  -- jr
        WHEN 1 THEN (55000 + (g % 25) * 1000)  -- mid
        ELSE        (75000 + (g % 35) * 1000)  -- sr
    END,
    (g % 8) + 1,   -- distribuir entre 8 departamentos
    CASE (g % 3) WHEN 0 THEN 'jr' WHEN 1 THEN 'mid' ELSE 'sr' END,
    (g % 10 != 0)  -- 10% inactivos
FROM generate_series(1, 100) AS g;
```

## Estructura del archivo generado

```sql
-- ============================================
-- Semana XX: Tema
-- Setup — [Ejercicio YY | Proyecto]
-- Motor: SQLite | PostgreSQL 16
-- ============================================

-- Limpiar estado previo (respetar orden por FK)
DROP TABLE IF EXISTS employees;
DROP TABLE IF EXISTS departments;
DROP TABLE IF EXISTS locations;

-- [Activar FK en SQLite si hay relaciones]
PRAGMA foreign_keys = ON;

-- Crear tablas
...

-- Datos de prueba
...
```
