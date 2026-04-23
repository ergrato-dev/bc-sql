# Proyecto Semana 11 — Subqueries en tu dominio

## Objetivo

Aplicar subqueries escalares, `IN`/`NOT IN`, `EXISTS`/`NOT EXISTS` y tablas
derivadas en el dominio asignado para generar reportes analíticos.

---

> ## ⚠️ ANTES DE EMPEZAR — Verifica tus datos
>
> `NOT EXISTS` sobre una tabla vacía siempre devuelve todos los registros. Eso no prueba que tu subquery esté bien.
> **Mínimo obligatorio: 80 filas en tu tabla principal, 20 en cada tabla secundaria, con casos de inclusión y exclusión reales.**
>
> Cómo completar tus datos rápidamente:
> - **Mockaroo** → [mockaroo.com](https://mockaroo.com) — genera hasta 1.000 INSERT en segundos
> - **Copilot / ChatGPT** → pídele: *"Dame 80 INSERT INTO realistas para una tabla SQLite con distribución variada de estados y categorías"*
>
> 📖 Guía completa: [`docs/seed-datos.md`](../../../../docs/seed-datos.md)

---

## Instrucciones generales

1. Adapta el esquema del `starter/proyecto.sql` a tu dominio.
2. Implementa las cuatro consultas marcadas como `TODO`.
3. Cada consulta debe incluir un comentario explicando qué retorna la subquery.

---

## Ejemplos de casos de uso por dominio

| Dominio     | Subquery escalar | IN/EXISTS |
|-------------|-----------------|-----------|
| Biblioteca  | Libros con más préstamos que el promedio | Miembros que nunca han tomado un libro prestado |
| Farmacia    | Medicamentos con precio > promedio cat. | Proveedores sin stock activo |
| Gimnasio    | Miembros con asistencia > promedio      | Rutinas sin ningún miembro asignado |
| Restaurante | Platos con precio > promedio del menú   | Categorías sin ningún plato activo |

---

## Requerimientos del proyecto

### Consulta 1 — Subquery escalar en WHERE

Compara una columna de la tabla principal contra un valor calculado
dinámicamente (AVG, MAX, MIN, COUNT) por la subquery.

### Consulta 2 — Subquery escalar en SELECT

Agrega una columna calculada globalmente a cada fila del resultado
para facilitar la comparación visual.

### Consulta 3 — NOT EXISTS

Detecta registros de la tabla principal que **no tienen** registros
relacionados en otra tabla. Alternativa segura a NOT IN.

### Consulta 4 — Tabla derivada en FROM

Construye una subquery que agrupa y calcula métricas, y filtra sobre
ese resultado en la consulta exterior.

---

## Criterios de evaluación

- Las cuatro consultas implementadas y funcionales
- Subquery en FROM con alias correcto
- `NOT EXISTS` bien correlacionado con la tabla exterior
- Comentarios en español explicando cada subquery
- Ningún `SELECT *` — siempre columnas explícitas
