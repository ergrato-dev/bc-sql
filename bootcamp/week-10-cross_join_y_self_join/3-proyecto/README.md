# Proyecto Semana 10 — SELF JOIN en tu dominio

## Objetivo

Aplicar SELF JOIN para modelar una relación jerárquica o de referencia propia
dentro del dominio asignado.

---

> ## ⚠️ ANTES DE EMPEZAR — Verifica tus datos
>
> El SELF JOIN requiere filas con relación padre-hijo real. Con 5 filas planas no hay jerarquía que recorrer.
> **Mínimo obligatorio: 80 filas en tu tabla principal, con al menos 3 niveles de jerarquía.**
>
> Cómo completar tus datos rápidamente:
> - **Mockaroo** → [mockaroo.com](https://mockaroo.com) — genera hasta 1.000 INSERT en segundos
> - **Copilot / ChatGPT** → pídele: *"Dame 80 INSERT INTO para una tabla con auto-referencia `parent_id`, con 3 niveles jerárquicos"*
>
> 📖 Guía completa: [`docs/seed-datos.md`](../../../../docs/seed-datos.md)

---

## Instrucciones generales

1. Identifica una entidad en tu dominio que tenga una relación jerárquica
   (categoría padre/hijo, producto base/variante, etc.).
2. Adapta el esquema del `starter/proyecto.sql` a tu dominio.
3. Implementa las cuatro consultas marcadas como `TODO`.

---

## Ejemplos de jerarquías por dominio

| Dominio     | Entidad con jerarquía | Columna auto-referencial |
|-------------|----------------------|--------------------------|
| Biblioteca  | categories           | parent_category_id       |
| Farmacia    | medicines            | base_medicine_id         |
| Gimnasio    | exercises            | parent_exercise_id       |
| Restaurante | menu_items           | parent_item_id           |

> Adapta a tu dominio propio, no uses estos ejemplos directamente.

---

## Requerimientos del proyecto

### Consulta 1 — SELF JOIN básico (INNER JOIN)

Muestra la relación entre hijo y padre usando dos aliases distintos.
Excluye los registros raíz (sin padre).

### Consulta 2 — Incluir la raíz (LEFT JOIN + COALESCE)

Usa `LEFT JOIN` para incluir los registros raíz y `COALESCE` para mostrar
una etiqueta descriptiva cuando no hay padre.

### Consulta 3 — Contar hijos por padre

Usa LEFT JOIN + GROUP BY + COUNT para saber cuántos hijos tiene cada padre.
Incluye solo los que tienen al menos un hijo (`HAVING`).

### Consulta 4 — Dos niveles jerárquicos

Encadena tres aliases para mostrar: hijo → padre → abuelo.
Usar `LEFT JOIN` en cada nivel para no perder registros sin referencia.

---

## Criterios de evaluación

- Tabla con columna auto-referencial bien definida como FK
- Las cuatro consultas implementadas y funcionales
- Dos aliases descriptivos reflejando roles en la jerarquía
- Al menos un registro raíz (columna padre = NULL) en los datos de prueba
- Comentarios en español explicando cada consulta
