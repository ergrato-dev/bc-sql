---
mode: agent
description: Genera un ejercicio guiado completo (starter + solution) para una semana del bootcamp.
---

Crea un ejercicio guiado paso a paso para el bootcamp bc-sql.

## Datos del ejercicio

- **Semana**: [COMPLETAR — ej. 09]
- **Número de ejercicio**: [COMPLETAR — ej. 02]
- **Tema**: [COMPLETAR — ej. LEFT JOIN con valores NULL]
- **Motor**: [COMPLETAR — SQLite | PostgreSQL 16]
- **Ruta destino**: `bootcamp/week-<NN>-<slug>/2-practicas/ejercicio-<NN>/`

## Archivos a generar

```
ejercicio-NN/
├── README.md
├── starter/
│   ├── setup.sql
│   └── ejercicio.sql
└── solution/
    ├── setup.sql      (idéntico al starter)
    └── ejercicio.sql  (consultas descomentadas)
```

## Formato obligatorio del README.md del ejercicio

Cada paso debe tener:
1. Título con el concepto
2. Explicación breve (2–4 líneas)
3. Ejemplo SQL ejecutable en bloque de código
4. Instrucción: **Abre `starter/ejercicio.sql`** y descomenta la sección X

## Formato obligatorio del starter/ejercicio.sql

```sql
-- ============================================
-- PASO 1: Nombre del Concepto
-- ============================================

-- Explicación breve
-- Descomenta las siguientes líneas:

-- SELECT
--     columna1,
--     columna2
-- FROM tabla
-- WHERE condicion;
```

## Formato obligatorio del solution/ejercicio.sql

```sql
-- ============================================
-- PASO 1: Nombre del Concepto
-- ============================================

SELECT
    columna1,
    columna2
FROM tabla
WHERE condicion;
```

## Reglas críticas

- ❌ NUNCA usar `-- TODO:` en ejercicios (eso es para proyectos)
- ✅ SIEMPRE usar consultas comentadas que el alumno descomenta
- El `setup.sql` debe ser autocontenido: `DROP TABLE IF EXISTS` + `CREATE` + `INSERT`
- Datos de prueba realistas, nunca `foo`, `bar`, `test1`
- Mínimo 3 pasos, máximo 6 pasos por ejercicio
- Semanas 13–24: incluir bloque "Cómo ejecutar" con Docker en el README

## Semanas 13–24 — bloque Docker en README

```markdown
## Cómo ejecutar

1. Levanta el contenedor:
   ```bash
   docker compose -f scripts/docker-compose.yml up -d
   ```
2. Carga el esquema:
   ```bash
   docker compose -f scripts/docker-compose.yml exec -T postgres \
     psql -U bootcamp -d bootcamp_db < starter/setup.sql
   ```
3. Abre el ejercicio en tu editor y conecta:
   ```bash
   docker compose -f scripts/docker-compose.yml exec postgres \
     psql -U bootcamp -d bootcamp_db
   ```
```
