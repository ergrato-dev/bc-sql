# Proyecto Semanal — Semana 22: JSON y JSONB

## Tema

Implementar una columna `JSONB` para almacenar atributos variables en el
dominio asignado, crear un índice GIN y construir consultas de reporte
con `jsonb_agg`.

## Cómo ejecutar

1. Levanta el contenedor:
   ```bash
   docker compose -f _scripts/docker-compose.yml up -d
   ```
2. Carga el esquema:
   ```bash
   docker compose -f _scripts/docker-compose.yml exec -T postgres \
     psql -U bootcamp -d bootcamp_db < bootcamp/week-22-json_y_jsonb/3-proyecto/starter/proyecto.sql
   ```
3. Conéctate:
   ```bash
   docker compose -f _scripts/docker-compose.yml exec postgres \
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
