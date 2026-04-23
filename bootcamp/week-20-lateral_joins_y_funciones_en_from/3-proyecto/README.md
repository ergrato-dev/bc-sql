# Proyecto Semanal — Semana 20: LATERAL Joins

## Tema: Consultas correlacionadas avanzadas en tu dominio

Implementa consultas con `JOIN LATERAL` y funciones tabulares
para responder preguntas analíticas sobre los datos de tu dominio asignado.

---

> ## ⚠️ ANTES DE EMPEZAR — Verifica tus datos (PostgreSQL)
>
> `JOIN LATERAL` que devuelve 1 resultado por fila porque solo hay 5 filas no demuestra nada. Necesitas volumen para ver el impacto real.
> **Mínimo obligatorio: 200 filas en tu tabla principal.**
>
> Cómo completar tus datos rápidamente:
> - **`generate_series`** en PostgreSQL → ver [`docs/seed-datos.md`](../../../../docs/seed-datos.md)
>
> 📖 Guía completa: [`docs/seed-datos.md`](../../../../docs/seed-datos.md)

---

## Cómo ejecutar

1. Levanta el contenedor:
   ```bash
   docker compose -f scripts/docker-compose.yml up -d
   ```
2. Carga el esquema:
   ```bash
   docker compose -f scripts/docker-compose.yml exec -T postgres \
     psql -U bootcamp -d bootcamp_db < bootcamp/week-20-lateral_joins_y_funciones_en_from/3-proyecto/starter/proyecto.sql
   ```
3. Conéctate e implementa:
   ```bash
   docker compose -f scripts/docker-compose.yml exec postgres \
     psql -U bootcamp -d bootcamp_db
   ```

## Objetivo

Demostrar que puedes usar `LATERAL` para resolver problemas analíticos
reales en tu dominio que serían difíciles o repetitivos
con subqueries correlacionadas en `SELECT`.

## Requerimientos

1. **Top-N por grupo**: Obtén los N registros con mayor valor
   de tu métrica principal, agrupados por una categoría de tu dominio.
2. **Estadísticas por entidad**: Usa `CROSS JOIN LATERAL` para calcular
   múltiples agregados en una sola subquery.
3. **Función tabular**: Crea una función `RETURNS TABLE` que encapsule
   la lógica del Top-N y llámala con `LATERAL`.
4. **LEFT JOIN LATERAL**: Incluye entidades sin registros relacionados
   mostrando `NULL` en las columnas de la subquery.

## Criterios de evaluación

| Criterio                                        | Puntaje |
|-------------------------------------------------|---------|
| Top-N con JOIN LATERAL funcional                | 30 pts  |
| CROSS JOIN LATERAL con múltiples agregados      | 20 pts  |
| Función RETURNS TABLE + LATERAL                 | 25 pts  |
| LEFT JOIN LATERAL con entidades sin relaciones  | 15 pts  |
| Comentarios en español y código documentado     | 10 pts  |

## Entrega

- `proyecto.sql` con todos los TODOs implementados.
- Debe ejecutarse sin errores en PostgreSQL 16.
