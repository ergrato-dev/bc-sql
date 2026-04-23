# Proyecto Semana 13 — Jerarquías con CTEs Recursivas

## Objetivo

Modelar una estructura jerárquica del dominio asignado y recorrerla
con `WITH RECURSIVE` para generar reportes de profundidad y paths.

---

> ## ⚠️ ANTES DE EMPEZAR — Verifica tus datos (PostgreSQL)
>
> Una CTE recursiva sobre 4 nodos no demuestra que entiendes la recursividad. Necesitas una jerarquía real con al menos 3 niveles y varios nodos por nivel.
> **Mínimo obligatorio: 200 filas en tu tabla principal, con estructura jerárquica de al menos 3 niveles.**
>
> Cómo completar tus datos rápidamente:
> - **`generate_series`** en PostgreSQL → ver [`docs/seed-datos.md`](../../../../docs/seed-datos.md)
> - **Copilot / ChatGPT** → pídele: *"Dame un INSERT masivo con generate_series para una tabla PostgreSQL con columna parent_id jerárquica"*
>
> 📖 Guía completa: [`docs/seed-datos.md`](../../../../docs/seed-datos.md)

---

## Instrucciones generales

1. Adapta el esquema del `starter/proyecto.sql` a tu dominio.
2. El esquema debe incluir una tabla **con columna auto-referencial** (`parent_id`).
3. Implementa las tres consultas marcadas como `TODO`.

## Cómo ejecutar

```bash
docker compose -f scripts/docker-compose.yml up -d

docker compose -f scripts/docker-compose.yml exec -T postgres \
  psql -U bootcamp -d bootcamp_db < starter/proyecto.sql
```

---

## Ejemplos de jerarquías por dominio

| Dominio     | Entidad jerárquica | parent_id |
|-------------|-------------------|-----------|
| Biblioteca  | Categorías de libros | categoría padre |
| Farmacia    | Clasificación ATC de medicamentos | categoría padre |
| Gimnasio    | Estructura de rutinas | rutina padre |
| Restaurante | Categorías del menú | categoría padre |
| Escuela     | Estructura del currículo | unidad padre |

---

## Requerimientos del proyecto

### Consulta 1 — Árbol completo con depth y path

Recorre todos los nodos desde la raíz. Calcula el nivel de profundidad
y construye el path completo concatenando nombres.

### Consulta 2 — Nodos de un nivel específico

Filtra el resultado de la CTE recursiva para mostrar solo los nodos
del nivel N (a elección del estudiante).

### Consulta 3 — Hojas del árbol (nodos sin hijos)

Un nodo es hoja si no existe ningún otro nodo cuyo `parent_id` sea su `id`.
Usa `NOT EXISTS` o `LEFT JOIN ... WHERE ... IS NULL`.

---

## Criterios de evaluación

- Tabla auto-referencial con al menos 3 niveles de profundidad
- CTE recursiva funcional con caso base y caso recursivo correctos
- Columna `depth` calculada correctamente
- Consulta de hojas implementada con `NOT EXISTS` o `LEFT JOIN`
- Comentarios en español explicando cada parte del CTE
