---
mode: agent
description: Genera el proyecto semanal integrador de una semana del bootcamp.
---

Crea el proyecto semanal integrador para el bootcamp bc-sql.

## Datos del proyecto

- **Semana**: [COMPLETAR — ej. 11]
- **Tema**: [COMPLETAR — ej. Subqueries]
- **Motor**: [COMPLETAR — SQLite | PostgreSQL 16]
- **Ruta destino**: `bootcamp/week-<NN>-<slug>/3-proyecto/`

## Archivos a generar

```
3-proyecto/
├── README.md
└── starter/
    ├── setup.sql
    └── proyecto.sql
```

> No hay `solution/` en proyectos — cada aprendiz tiene un dominio único.

## Política de dominios (CRÍTICO)

El proyecto usa ejemplos **genéricos** adaptables a cualquier dominio.
**NO usar** como dominio de ejemplo: biblioteca, farmacia, gimnasio, escuela,
tienda de mascotas, restaurante, banco, agencia de taxis, hospital, cine,
hotel, agencia de viajes, concesionario de autos, tienda de ropa, taller mecánico.

Usar dominios alternativos para los ejemplos: museo, planetario, acuario,
zoológico, galería de arte, estación espacial, observatorio, etc.

## Formato del README.md del proyecto

```markdown
# Proyecto Semana XX — Título

## Contexto

Breve descripción del caso de negocio genérico (2–3 líneas).

## Tu dominio asignado

Adapta el esquema y las consultas al dominio que te asignó el instructor.
Ejemplos de adaptación:
- Biblioteca → books, members, loans
- Farmacia → medicines, sales, inventory
- Gimnasio → members, routines, attendance

## Requisitos

1. **Requisito 1**: descripción concreta y verificable
2. **Requisito 2**: ...
3. **Requisito 3**: ...
(mínimo 4, máximo 6 requisitos)

## Entregables

- [ ] `setup.sql` adaptado a tu dominio con datos reales
- [ ] `proyecto.sql` con todas las consultas implementadas y comentadas
- [ ] Cada query con un comentario explicando qué resuelve

## Criterios de evaluación

| Criterio | Puntaje |
|---|---|
| Esquema correcto con FK | 20 pts |
| Consultas funcionan sin errores | 40 pts |
| Uso correcto del concepto de la semana | 30 pts |
| Comentarios en español | 10 pts |
| **Total** | **100 pts** |
```

## Formato del starter/proyecto.sql

```sql
-- ============================================
-- PROYECTO SEMANAL: [Título Genérico]
-- Semana XX — [Tema]
-- ============================================

-- NOTA PARA EL APRENDIZ:
-- Adapta este esquema a tu dominio asignado.
-- Renombra las tablas y columnas según corresponda.

-- TODO: Renombrar según tu dominio
CREATE TABLE items (
    id    INTEGER PRIMARY KEY,
    name  TEXT    NOT NULL
    -- TODO: Agregar columnas específicas de tu dominio
);

-- TODO: Implementar consulta 1 — [descripción del requisito]

-- TODO: Implementar consulta 2 — [descripción del requisito]
```

## Reglas

- Mínimo 4 TODOs de implementación (uno por requisito)
- El `setup.sql` del proyecto usa un dominio de ejemplo alternativo,
  no los dominios de la lista de aprendices
- Semanas 13–24: incluir bloque "Cómo ejecutar" con Docker en el README
