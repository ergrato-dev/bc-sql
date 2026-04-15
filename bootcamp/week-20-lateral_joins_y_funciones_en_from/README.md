# Semana 20 — LATERAL Joins y Funciones en FROM

## Objetivos

1. Entender qué es `LATERAL` y cuándo usarlo frente a un `JOIN` ordinario.
2. Escribir consultas con `JOIN LATERAL` y `CROSS JOIN LATERAL`.
3. Usar funciones que retornan tablas (`RETURNS TABLE`) en la cláusula `FROM`.
4. Combinar `LATERAL` con subqueries correlacionadas para consultas eficientes.

## Tiempo estimado

| Actividad            | Tiempo   |
|----------------------|----------|
| Teoría               | 2 h      |
| Práctica guiada      | 3 h      |
| Proyecto semanal     | 2.5 h    |

## Descripción

Esta semana exploramos `LATERAL`, la extensión de SQL que permite que
una subquery o función en `FROM` haga referencia a columnas de tablas
anteriores en la misma cláusula `FROM`. Es la base de patrones
como "top-N por grupo" y la integración de funciones tabulares
en consultas complejas.

## Contenido

- [01 — Qué es LATERAL](1-teoria/01-lateral-intro.md)
- [02 — CROSS JOIN LATERAL y funciones tabulares](1-teoria/02-cross-join-lateral.md)
- [03 — LATERAL en la práctica](1-teoria/03-lateral-casos.md)
- [Ejercicio 01 — JOIN LATERAL básico](2-practicas/ejercicio-01/README.md)
- [Ejercicio 02 — Top-N por grupo y funciones tabulares](2-practicas/ejercicio-02/README.md)
- [Proyecto semanal](3-proyecto/README.md)
- [Recursos adicionales](4-recursos/README.md)
- [Glosario](5-glosario/README.md)

## Diagramas

- [`0-assets/01-lateral-flujo.svg`](0-assets/01-lateral-flujo.svg) — Cómo `LATERAL` correlaciona filas
- [`0-assets/02-topn-patron.svg`](0-assets/02-topn-patron.svg) — Patrón Top-N por grupo

## Cómo ejecutar

1. Levanta el contenedor PostgreSQL:
   ```bash
   docker compose -f scripts/docker-compose.yml up -d
   ```
2. Carga el esquema de cualquier ejercicio:
   ```bash
   docker compose -f scripts/docker-compose.yml exec -T postgres \
     psql -U bootcamp -d bootcamp_db < bootcamp/week-20-lateral_joins_y_funciones_en_from/2-practicas/ejercicio-01/starter/setup.sql
   ```
3. Conéctate:
   ```bash
   docker compose -f scripts/docker-compose.yml exec postgres \
     psql -U bootcamp -d bootcamp_db
   ```

## Navegación

| ← Semana 19 | Inicio | Semana 21 → |
|-------------|--------|-------------|
| [Triggers](../week-19-triggers_automatizacion/README.md) | [Bootcamp](../../README.md) | [Full-Text Search](../week-21-full_text_search/README.md) |
