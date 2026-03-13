# Semana 23 — Optimización de Consultas y EXPLAIN ANALYZE

## Tema

Interpretar planes de ejecución, identificar cuellos de botella y aplicar
índices, `VACUUM ANALYZE` y reescritura de queries para mejorar el rendimiento.

## Objetivos

Al finalizar esta semana serás capaz de:

- Leer e interpretar la salida de `EXPLAIN` y `EXPLAIN ANALYZE`
- Identificar seq scan, index scan e index only scan
- Crear índices parciales y compuestos para casos específicos
- Usar `pg_stat_user_tables` y `pg_indexes` para monitoreo

## Programa

| Bloque | Actividad | Tiempo |
|--------|-----------|--------|
| Teoría | Planes de ejecución, costos, índices | 2 h |
| Práctica | Ejercicio 01 y 02 | 3 h |
| Proyecto | Análisis de rendimiento en dominio asignado | 2 h |
| Revisión | Revisión de pares + rúbrica | 1 h |

## Contenido

```
week-23/
├── 0-assets/
│   ├── 01-explain-anatomia.svg
│   └── 02-index-tipos.svg
├── 1-teoria/
│   ├── 01-explain-analyze.md
│   ├── 02-tipos-scan.md
│   └── 03-indices-optimizacion.md
├── 2-practicas/
│   ├── ejercicio-01/   (EXPLAIN + índice B-tree)
│   └── ejercicio-02/   (índices parciales + VACUUM)
├── 3-proyecto/
├── 4-recursos/
└── 5-glosario/
```

## Navegación

← [Semana 22 — JSON y JSONB](../week-22/README.md)  
→ [Semana 24 — Proyecto Integrador Final](../week-24/README.md)

## Cómo ejecutar

```bash
docker compose -f _scripts/docker-compose.yml up -d
docker compose -f _scripts/docker-compose.yml exec postgres \
  psql -U bootcamp -d bootcamp_db
```
