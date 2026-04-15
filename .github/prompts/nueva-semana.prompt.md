---
mode: agent
description: Genera el contenido completo de una semana nueva del bootcamp de SQL.
---

Crea el contenido completo de la siguiente semana del bootcamp bc-sql siguiendo
estrictamente la estructura y convenciones del repositorio.

## Datos de la semana a crear

- **Número de semana**: [COMPLETAR — ej. 10]
- **Slug**: [COMPLETAR — ej. week-10-cross_join_y_self_join]
- **Tema principal**: [COMPLETAR — ej. CROSS JOIN y SELF JOIN]
- **Motor de BD**: [COMPLETAR — SQLite | PostgreSQL 16]
- **Etapa**: [COMPLETAR — Etapa 0 (sem 1–8) | Etapa 1 (sem 9–16) | Etapa 2 (sem 17–24)]

## Orden de creación obligatorio

Crea los archivos en este orden exacto:

1. `bootcamp/<slug>/README.md`
2. `bootcamp/<slug>/rubrica-evaluacion.md`
3. `bootcamp/<slug>/1-teoria/01-<concepto>.md`
4. `bootcamp/<slug>/1-teoria/02-<concepto>.md`
5. `bootcamp/<slug>/1-teoria/03-<concepto>.md` (si aplica)
6. `bootcamp/<slug>/0-assets/` — al menos 1 diagrama SVG (dark theme)
7. `bootcamp/<slug>/2-practicas/ejercicio-01/README.md`
8. `bootcamp/<slug>/2-practicas/ejercicio-01/starter/setup.sql`
9. `bootcamp/<slug>/2-practicas/ejercicio-01/starter/ejercicio.sql`
10. `bootcamp/<slug>/2-practicas/ejercicio-01/solution/setup.sql`
11. `bootcamp/<slug>/2-practicas/ejercicio-01/solution/ejercicio.sql`
12. `bootcamp/<slug>/2-practicas/ejercicio-02/` (misma estructura)
13. `bootcamp/<slug>/3-proyecto/README.md`
14. `bootcamp/<slug>/3-proyecto/starter/setup.sql`
15. `bootcamp/<slug>/3-proyecto/starter/proyecto.sql`
16. `bootcamp/<slug>/4-recursos/README.md`
17. `bootcamp/<slug>/5-glosario/README.md`

## Reglas críticas

### SQL
- Keywords en UPPERCASE, identificadores en snake_case en inglés, comentarios en español
- Semanas 1–12 → `INTEGER PRIMARY KEY` (SQLite)
- Semanas 13–24 → `SERIAL PRIMARY KEY` (PostgreSQL 16)
- Ejercicios: consultas **comentadas** para descomentar (NO usar TODO)
- Proyectos: usar `-- TODO:` para implementación libre del alumno

### Teoría
- Máximo 120 líneas por archivo
- 4–6 secciones numeradas
- Checklist de exactamente 4 preguntas al final

### Assets SVG
- Tema dark: fondo `#1a1a2e`, tablas `#16213e`, bordes `#336791`
- Notación crow's foot para diagramas ER
- Sin degradés, fuentes sans-serif

### Proyectos
- Dominio de ejemplo NO debe ser: biblioteca, farmacia, gimnasio, escuela,
  tienda de mascotas, restaurante, banco, agencia de taxis, hospital, cine,
  hotel, agencia de viajes, concesionario, tienda de ropa, taller mecánico
- Usar dominios alternativos: museo, planetario, acuario, zoológico, etc.

### Semanas 13–24 (PostgreSQL)
- Incluir bloque "Cómo ejecutar" con comandos Docker en cada README de ejercicio

## Distribución del tiempo (tabla en README)

| Actividad | Tiempo |
|---|---|
| Teoría | 2 h |
| Ejercicios | 3 h |
| Proyecto | 2 h |
| Revisión | 1 h |

## Navegación en README

Incluir siempre al final:
```
← [Semana N-1 — Tema](../week-NN-slug/README.md) |
→ [Semana N+1 — Tema](../week-NN-slug/README.md)
```

Divide la creación por secciones (teoría → prácticas → proyecto) y espera
confirmación entre secciones si el contenido es extenso.
