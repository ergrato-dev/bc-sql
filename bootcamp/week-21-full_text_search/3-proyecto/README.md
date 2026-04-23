# Proyecto Semanal — Semana 21: Full-Text Search

## Tema

Implementar búsqueda de texto completo en el dominio asignado usando
`tsvector`, `tsquery`, índice GIN, `ts_rank` y `ts_headline`.

---

> ## ⚠️ ANTES DE EMPEZAR — Verifica tus datos (PostgreSQL)
>
> Full-text search sobre 10 filas con el mismo texto no muestra diferencia de relevancia. Necesitas textos variados y suficientes para que `ts_rank` produzca resultados distintos.
> **Mínimo obligatorio: 200 filas con columnas de texto variado y realista.**
>
> Cómo completar tus datos rápidamente:
> - **`generate_series`** + textos generados → ver [`docs/seed-datos.md`](../../../../docs/seed-datos.md)
> - **Copilot / ChatGPT** → pídele: *"Dame 200 INSERT con textos variados en español para una tabla PostgreSQL de descripciones de tu dominio"*
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
     psql -U bootcamp -d bootcamp_db < bootcamp/week-21-full_text_search/3-proyecto/starter/proyecto.sql
   ```
3. Conéctate:
   ```bash
   docker compose -f scripts/docker-compose.yml exec postgres \
     psql -U bootcamp -d bootcamp_db
   ```

---

## Descripción

Adapta este proyecto a tu dominio asignado. Cualquier dominio que
gestione registros con texto descriptivo (descripción, notas, reseñas,
resúmenes) puede beneficiarse de búsqueda full-text.

Ejemplos de entidades con texto buscable:

| Dominio      | Entidad        | Columnas de texto          |
|--------------|----------------|----------------------------|
| Biblioteca   | `books`        | `title`, `description`     |
| Farmacia     | `medicines`    | `name`, `indications`      |
| Gimnasio     | `routines`     | `name`, `description`      |
| Restaurante  | `dishes`       | `name`, `ingredients`      |

---

## Requisitos del proyecto

1. Tabla principal con al menos dos columnas de texto (nombre/título + descripción)
2. Columna `search_vector TSVECTOR` calculada con `setweight` para ponderar columnas
3. Índice GIN sobre `search_vector`
4. Al menos 10 filas de datos de prueba representativos del dominio
5. Consulta de búsqueda usando `@@` + `plainto_tsquery`
6. Consulta con ranking `ts_rank` ordenada por relevancia
7. Consulta con `ts_headline` para resaltar fragmentos relevantes

---

## Entregable

Archivo `proyecto.sql` completo con:
- `DROP TABLE IF EXISTS` al inicio
- `CREATE TABLE` con la columna `search_vector`
- `INSERT` con al menos 10 filas
- `UPDATE` para poblar `search_vector` con `setweight`
- `CREATE INDEX` GIN
- Las 3 consultas requeridas
