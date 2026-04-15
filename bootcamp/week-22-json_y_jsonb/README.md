# Semana 22 — JSON y JSONB en PostgreSQL

## Tema

Almacenamiento semiestructurado con `JSON` y `JSONB`: operadores de
acceso, modificación, consultas con índice GIN y agregación en documentos.

## Objetivos

Al finalizar esta semana serás capaz de:

- Crear columnas `JSONB` y operar sobre documentos con `->`, `->>` y `#>`
- Modificar documentos con `jsonb_set` y `jsonb_strip_nulls`
- Crear índices GIN sobre columnas `JSONB` y usar el operador `@>`
- Agregar filas en documentos con `jsonb_agg` y `jsonb_build_object`

## Programa

| Bloque | Actividad | Tiempo |
|--------|-----------|--------|
| Teoría | tsvector/tsquery, operadores de acceso | 2 h |
| Práctica | Ejercicio 01 y 02 | 3 h |
| Proyecto | Implementación en dominio asignado | 2 h |
| Revisión | Revisión de pares + rúbrica | 1 h |

## Contenido

```
week-22-json_y_jsonb/
├── 0-assets/
│   ├── 01-jsonb-operadores.svg
│   └── 02-gin-containment.svg
├── 1-teoria/
│   ├── 01-json-vs-jsonb.md
│   ├── 02-operadores-acceso.md
│   └── 03-gin-modificacion.md
├── 2-practicas/
│   ├── ejercicio-01/   (operadores de lectura)
│   └── ejercicio-02/   (modificación y GIN)
├── 3-proyecto/
├── 4-recursos/
└── 5-glosario/
```

## Navegación

← [Semana 21 — Full-Text Search](../week-21-full_text_search/README.md)  
→ [Semana 23 — Performance y EXPLAIN ANALYZE](../week-23-optimizacion_de_consultas_explain_analyze/README.md)

## Cómo ejecutar

```bash
docker compose -f scripts/docker-compose.yml up -d
docker compose -f scripts/docker-compose.yml exec postgres \
  psql -U bootcamp -d bootcamp_db
```
