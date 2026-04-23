# Proyecto Semanal — Semana 22: JSON y JSONB

## Tema

Implementar una columna `JSONB` para almacenar atributos variables en el
dominio asignado, crear un índice GIN y construir consultas de reporte
con `jsonb_agg`.

---

> ## ⚠️ ANTES DE EMPEZAR — Verifica tus datos (PostgreSQL)
>
> `jsonb_agg` sobre 5 filas con el mismo JSON no prueba nada. Necesitas datos con atributos JSON variados para que las consultas sean significativas.
> **Mínimo obligatorio: 200 filas con columnas JSONB de estructura variada.**
>
> Cómo completar tus datos rápidamente:
> - **`generate_series`** en PostgreSQL → ver [`docs/seed-datos.md`](../../../../docs/seed-datos.md)
> - **Copilot / ChatGPT** → pídele: *"Dame 200 INSERT PostgreSQL con columna JSONB variada para el dominio X"*
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
     psql -U bootcamp -d bootcamp_db < bootcamp/week-22-json_y_jsonb/3-proyecto/starter/proyecto.sql
   ```
3. Conéctate:
   ```bash
   docker compose -f scripts/docker-compose.yml exec postgres \
     psql -U bootcamp -d bootcamp_db
   ```

---

## Descripción

Adapta este proyecto a tu dominio asignado. Cualquier entidad con
atributos variables o semiestructurados es candidata para JSONB.

| Dominio      | Entidad        | JSONB para                    |
|--------------|----------------|-------------------------------|
| Biblioteca   | `books`        | `metadata` (genre, language)  |
| Farmacia     | `medicines`    | `properties` (dosage, side effects) |
| Gimnasio     | `equipment`    | `specs` (weight, dimensions)  |
| Restaurante  | `dishes`       | `details` (allergens, nutrition) |

---

## Requisitos del proyecto

1. Tabla principal con columna `attributes JSONB`
2. Al menos 10 filas con documentos JSONB variados
3. Índice GIN sobre la columna JSONB
4. Consulta con `@>` para filtrar por atributos
5. Consulta que modifique documentos con `jsonb_set`
6. Reporte con `jsonb_agg` y `jsonb_build_object`

---

## Entregable

Archivo `proyecto.sql` con todas las secciones completadas.
