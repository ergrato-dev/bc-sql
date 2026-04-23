# Proyecto Semana 12 — CTEs y CASE WHEN en tu dominio

## Objetivo

Aplicar CTEs (simples y encadenados) junto con `CASE WHEN` para construir
un reporte analítico completo sobre el dominio asignado.

---

> ## ⚠️ ANTES DE EMPEZAR — Verifica tus datos
>
> `CASE WHEN` con 3 categorías y 2 filas por categoría no muestra nada útil. La clasificación tiene valor solo con distribución real.
> **Mínimo obligatorio: 80 filas en tu tabla principal, con variación en las columnas que usarás en `CASE WHEN`.**
>
> Cómo completar tus datos rápidamente:
> - **Mockaroo** → [mockaroo.com](https://mockaroo.com) — genera hasta 1.000 INSERT en segundos
> - **Copilot / ChatGPT** → pídele: *"Dame 80 INSERT INTO realistas con distribución desigual de categorías para practicar CASE WHEN"*
>
> 📖 Guía completa: [`docs/seed-datos.md`](../../../../docs/seed-datos.md)

---

## Instrucciones generales

1. Adapta el esquema del `starter/proyecto.sql` a tu dominio.
2. Implementa las tres consultas marcadas como `TODO`.
3. Usa al menos un CTE en cada consulta donde se indique.

---

## Ejemplos de casos de uso por dominio

| Dominio     | CTE encadenado | CASE WHEN |
|-------------|---------------|-----------|
| Biblioteca  | libros activos → préstamos por categoría | Clasificar popularidad: alta/media/baja |
| Farmacia    | ventas del mes → por producto | Clasificar stock: crítico/normal/excedente |
| Gimnasio    | asistencia por mes → por miembro | Clasificar frecuencia: activo/regular/inactivo |
| Restaurante | ventas por día → por categoría | Clasificar precio: económico/estándar/premium |

---

## Requerimientos del proyecto

### Consulta 1 — CTE simple + clasificación CASE WHEN

Filtra o pre-procesa datos en el CTE. La consulta principal clasifica
los resultados en categorías usando `CASE WHEN`.

### Consulta 2 — Dos CTEs encadenados

Primer CTE: calcula métricas agregadas.
Segundo CTE: filtra sobre esas métricas.
Consulta final: muestra los registros que pasan el filtro.

### Consulta 3 — CTE con CASE WHEN y agregación condicional

El CTE combina información de al menos dos tablas. La consulta principal
usa `COUNT(CASE WHEN ...)` para contar por categoría.

---

## Criterios de evaluación

- Las tres consultas implementadas y sin errores de sintaxis
- CTE encadenado con segundo CTE que referencia al primero
- `CASE WHEN` con mínimo 3 ramas (2 WHEN + ELSE)
- Comentarios en español explicando el propósito de cada CTE
- Ningún `SELECT *` — columnas explícitas siempre
