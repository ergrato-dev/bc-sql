# Proyecto Semanal — Semana 23: Optimización y EXPLAIN ANALYZE

## Tema

Analizar el rendimiento de consultas del dominio asignado, identificar
consultas lentas con `EXPLAIN ANALYZE` y aplicar índices para mejorarlas.

---

> ## ⚠️ ANTES DE EMPEZAR — Verifica tus datos (PostgreSQL)
>
> `EXPLAIN ANALYZE` sobre 50 filas **siempre** usa Seq Scan. No hay nada que optimizar. Esta semana requiere volumen real para que los índices cambien el plan de ejecución.
> **Mínimo obligatorio: 200 filas. Recomendado: 1.000+.**
>
> Cómo completar tus datos rápidamente:
> - **`generate_series`** en PostgreSQL → ver [`docs/seed-datos.md`](../../../../docs/seed-datos.md)
> - Esta semana más que ninguna: usa `generate_series` para llegar a 1.000 filas si puedes
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
     psql -U bootcamp -d bootcamp_db < bootcamp/week-23-optimizacion_de_consultas_explain_analyze/3-proyecto/starter/proyecto.sql
   ```
3. Conéctate:
   ```bash
   docker compose -f scripts/docker-compose.yml exec postgres \
     psql -U bootcamp -d bootcamp_db
   ```

---

## Descripción

Adapta este proyecto al dominio asignado. El objetivo es demostrar una
mejora de rendimiento medible antes y después de agregar un índice.

---

## Requisitos del proyecto

1. Tabla con al menos 500 filas generadas con `generate_series`
2. Consulta analizada con `EXPLAIN` **antes** del índice (mostrar Seq Scan)
3. Índice B-tree o parcial creado sobre la columna relevante
4. Misma consulta analizada con `EXPLAIN ANALYZE` **después** del índice
5. Consulta a `pg_stat_user_tables` mostrando estadísticas de la tabla
6. Consulta a `pg_indexes` listando los índices creados

---

## Entregable

Archivo `proyecto.sql` con todas las secciones completadas y comentadas
en español, mostrando la comparación antes/después del índice.
