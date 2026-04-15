---
applyTo: "**/1-teoria/*.md"
---

# Convenciones de Teoría — bc-sql Bootcamp

## Límites de extensión (NON-NEGOTIABLE)

| Elemento | Límite |
|---|---|
| Líneas por archivo | **Máximo 120** |
| Objetivos | 3–4 ítems |
| Secciones numeradas | 4–6 (`## 1.`, `## 2.`…) |
| Ejemplos de código por sección | Máximo 2 |
| Checklist final | **4 ítems** como preguntas concretas |
| Referencias | 2–3 links |

## Estructura obligatoria de cada archivo de teoría

```markdown
# Título del Concepto

## Objetivos
- Objetivo 1 (verbo de acción)
- Objetivo 2
- Objetivo 3

## Diagrama
![Descripción](../0-assets/XX-nombre.svg)

## 1. Primera sección
...

## 2. Segunda sección
...

## Checklist
- [ ] ¿Pregunta concreta 1?
- [ ] ¿Pregunta concreta 2?
- [ ] ¿Pregunta concreta 3?
- [ ] ¿Pregunta concreta 4?

## Referencias
- [Título](url)
- [Título](url)
```

## Qué NO incluir

- ❌ Tablas de comparación de más de 4 filas
- ❌ Tablas mostrando resultados de cada query de ejemplo
- ❌ Secciones de "Herramientas recomendadas" (van en `4-recursos/`)
- ❌ Notas de compatibilidad extensas (una línea `>` es suficiente)
- ❌ Más de 2 ejemplos de código por sección

## Idioma

- Texto explicativo: **español**
- Código SQL (tablas, columnas, aliases): **inglés**
- Comentarios dentro del código SQL: **español**

## Numeración de archivos

Prefijo numérico de dos dígitos: `01-`, `02-`, `03-`…
Archivo de nivelación (si existe): `00-nivelacion.md`
