# Proyecto Semana 09 — JOINs aplicados a tu dominio

## Objetivo

Aplicar INNER JOIN y LEFT JOIN para generar reportes relacionales en el dominio
asignado. Practicar el cruce de al menos dos tablas y la detección de registros
huérfanos.

---

> ## ⚠️ ANTES DE EMPEZAR — Verifica tus datos
>
> Un JOIN sobre 5 filas produce resultados triviales. Para que el ejercicio tenga valor,
> necesitas filas en **ambas tablas**, incluyendo registros que no cruzan (para el LEFT JOIN).
> **Mínimo obligatorio: 80 filas en tu tabla principal, 20 en cada tabla secundaria.**
>
> Cómo completar tus datos rápidamente:
> - **Mockaroo** → [mockaroo.com](https://mockaroo.com) — genera hasta 1.000 INSERT en segundos
> - **Copilot / ChatGPT** → pídele: *"Dame 80 INSERT INTO realistas para una tabla SQLite llamada `X` con columnas A, B, C, incluyendo ~10 sin FK asignada"*
>
> 📖 Guía completa: [`docs/seed-datos.md`](../../../../docs/seed-datos.md)

---

## Instrucciones generales

1. Adapta los nombres de tablas y columnas a tu dominio asignado.
2. El `setup.sql` incluye un esquema genérico de ejemplo; renómbralo.
3. Implementa las cuatro consultas marcadas como `TODO`.

---

## Ejemplos de adaptación por dominio

| Dominio      | Tabla principal | Tabla secundaria | Tabla de referencia |
|--------------|----------------|------------------|---------------------|
| Biblioteca   | books          | loans            | members             |
| Farmacia     | medicines      | sales            | suppliers           |
| Gimnasio     | members        | routines         | trainers            |
| Restaurante  | dishes         | orders           | categories          |

> Usa tu dominio, no los ejemplos anteriores.

---

## Requerimientos del proyecto

### Consulta 1 — INNER JOIN principal

Une las dos tablas más importantes de tu dominio. Muestra solo los registros
que tienen relación en ambas tablas.

### Consulta 2 — JOIN con tres tablas

Encadena la tabla principal con dos tablas relacionadas para enriquecer el
reporte con información adicional.

### Consulta 3 — LEFT JOIN: todos los registros

Usa LEFT JOIN para mostrar todos los registros de la tabla padre, incluyendo
los que no tienen registros hijos.

### Consulta 4 — Detectar huérfanos

Agrega `WHERE hijo.id IS NULL` al LEFT JOIN anterior para filtrar solo los
registros sin hijos (huérfanos).

### Consulta 5 — Reporte agregado con JOINs

Combina LEFT JOIN + GROUP BY + COUNT para generar un reporte que muestre
la cantidad de registros relacionados por cada entrada de la tabla padre.

---

## Criterios de evaluación

- Esquema con mínimo **tres tablas relacionadas** vía FK
- Las cinco consultas implementadas y funcionales
- Uso correcto de aliases de tabla
- Comentarios en español explicando cada consulta
- Ningún `SELECT *` — siempre columnas explícitas
