# Semana 14 — Proyecto: Ranking con Window Functions

## Descripción

Aplica `ROW_NUMBER()`, `RANK()` y `DENSE_RANK()` a las entidades de tu
dominio asignado para generar reportes de clasificación y análisis top-N.

---

> ## ⚠️ ANTES DE EMPEZAR — Verifica tus datos (PostgreSQL)
>
> Las window functions solo son interesantes con empates reales en los valores. Sin suficientes filas, `RANK()` y `DENSE_RANK()` producen el mismo resultado y no se nota la diferencia.
> **Mínimo obligatorio: 200 filas en tu tabla principal, con valores repetidos en la columna que clasificarás.**
>
> Cómo completar tus datos rápidamente:
> - **`generate_series`** en PostgreSQL → ver [`docs/seed-datos.md`](../../../../docs/seed-datos.md)
> - **Copilot / ChatGPT** → pídele: *"Dame un INSERT con generate_series PostgreSQL con distribución de valores con empates para window functions"*
>
> 📖 Guía completa: [`docs/seed-datos.md`](../../../../docs/seed-datos.md)

---

## Cómo ejecutar

1. Asegúrate de tener Docker corriendo
2. Levanta el contenedor:
   ```bash
   docker compose -f scripts/docker-compose.yml up -d
   ```
3. Carga el esquema de prueba:
   ```bash
   docker compose -f scripts/docker-compose.yml exec -T postgres \
     psql -U bootcamp -d bootcamp_db < starter/proyecto.sql
   ```
4. Conecta e interactúa:
   ```bash
   docker compose -f scripts/docker-compose.yml exec postgres \
     psql -U bootcamp -d bootcamp_db
   ```

## Instrucciones

Adapta el esquema genérico a tu dominio asignado. Ejemplos:

| Dominio     | Tabla principal | Valor a rankear   |
|-------------|-----------------|-------------------|
| Biblioteca  | books           | total_loans       |
| Farmacia    | medicines       | units_sold        |
| Gimnasio    | members         | sessions_attended |
| Restaurante | dishes          | total_orders      |
| Hotel       | rooms           | bookings_count    |

## Evidencia a entregar

- Archivo `proyecto.sql` con los tres TODOs implementados y ejecutables
- Screenshot o copia del resultado de cada consulta
- Los queries deben incluir comentarios que expliquen cada paso

## Criterios de evaluación

| Criterio                                              | Puntos |
|-------------------------------------------------------|--------|
| ROW_NUMBER() elimina duplicados correctamente         | 20     |
| RANK/DENSE_RANK por categoría con empates visibles    | 30     |
| CTE + top-N por grupo funcional                       | 30     |
| Nomenclatura, estilo SQL y comentarios en español     | 20     |
| **Total**                                             | **100**|
