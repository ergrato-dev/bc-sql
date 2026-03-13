# Semana 24 — Proyecto Integrador Final

## Tema

Diseñar e implementar un esquema relacional completo que integre todos
los conceptos del bootcamp: DDL, DML, JOINs, CTEs, window functions,
triggers, vistas, FTS, JSONB e índices optimizados.

## Objetivos

Al finalizar esta semana serás capaz de:

- Diseñar un esquema normalizado de 5+ tablas para un dominio real
- Implementar triggers de auditoría y validación
- Escribir consultas analíticas con window functions y CTEs
- Aplicar FTS y/o JSONB según el dominio asignado
- Demostrar mejoras de rendimiento con índices y EXPLAIN ANALYZE

## Programa

| Bloque | Actividad | Tiempo |
|--------|-----------|--------|
| Teoría | Revisión integradora de conceptos clave | 1 h |
| Práctica | Ejercicio guiado de integración | 2 h |
| Proyecto | Implementación completa en dominio asignado | 4 h |
| Revisión | Presentación y revisión final | 1 h |

## Contenido

```
week-24/
├── 0-assets/
│   ├── 01-esquema-integrador.svg
│   └── 02-capas-sql.svg
├── 1-teoria/
│   ├── 01-revision-etapa-2.md
│   ├── 02-patrones-produccion.md
│   └── 03-checklist-final.md
├── 2-practicas/
│   ├── ejercicio-01/   (esquema + queries integrados)
│   └── ejercicio-02/   (auditoría + FTS + rendimiento)
├── 3-proyecto/
│   ├── README.md
│   └── starter/proyecto.sql
├── 4-recursos/
└── 5-glosario/
```

## Navegación

← [Semana 23 — Optimización y EXPLAIN ANALYZE](../week-23/README.md)

## Cómo ejecutar

```bash
docker compose -f _scripts/docker-compose.yml up -d
docker compose -f _scripts/docker-compose.yml exec postgres \
  psql -U bootcamp -d bootcamp_db
```
