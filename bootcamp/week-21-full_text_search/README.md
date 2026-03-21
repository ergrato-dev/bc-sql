# Semana 21 — Full-Text Search en PostgreSQL

## Objetivos

1. Entender los tipos `tsvector` y `tsquery` y cómo representan documentos y búsquedas.
2. Crear índices GIN sobre columnas `tsvector` para búsquedas eficientes.
3. Usar `to_tsvector()`, `to_tsquery()`, `plainto_tsquery()` y el operador `@@`.
4. Calcular relevancia con `ts_rank()` y resaltar coincidencias con `ts_headline()`.

## Tiempo estimado

| Actividad        | Tiempo  |
|------------------|---------|
| Teoría           | 2 h     |
| Práctica guiada  | 3 h     |
| Proyecto semanal | 2.5 h   |

## Descripción

Esta semana implementamos búsqueda de texto completo nativa de PostgreSQL:
indexación de documentos, consultas y ranking de relevancia.
Es la base para construir motores de búsqueda internos sin dependencias externas.

## Contenido

- [01 — tsvector y tsquery](1-teoria/01-tsvector-tsquery.md)
- [02 — Índice GIN y operador @@](1-teoria/02-gin-operador.md)
- [03 — Ranking y resaltado](1-teoria/03-ranking-headline.md)
- [Ejercicio 01 — Indexación y búsqueda básica](2-practicas/ejercicio-01/README.md)
- [Ejercicio 02 — Ranking y búsquedas avanzadas](2-practicas/ejercicio-02/README.md)
- [Proyecto semanal](3-proyecto/README.md)
- [Recursos adicionales](4-recursos/README.md)
- [Glosario](5-glosario/README.md)

## Diagramas

- [`0-assets/01-fts-pipeline.svg`](0-assets/01-fts-pipeline.svg) — Pipeline de indexación FTS
- [`0-assets/02-gin-estructura.svg`](0-assets/02-gin-estructura.svg) — Estructura del índice GIN

## Cómo ejecutar

1. Levanta el contenedor:
   ```bash
   docker compose -f _scripts/docker-compose.yml up -d
   ```
2. Carga el esquema:
   ```bash
   docker compose -f _scripts/docker-compose.yml exec -T postgres \
     psql -U bootcamp -d bootcamp_db < bootcamp/week-21-full_text_search/2-practicas/ejercicio-01/starter/setup.sql
   ```
3. Conéctate:
   ```bash
   docker compose -f _scripts/docker-compose.yml exec postgres \
     psql -U bootcamp -d bootcamp_db
   ```

## Navegación

| ← Semana 20 | Inicio | Semana 22 → |
|-------------|--------|-------------|
| [LATERAL Joins](../week-20-lateral_joins_y_funciones_en_from/README.md) | [Bootcamp](../../README.md) | [JSON/JSONB](../week-22-json_y_jsonb/README.md) |
