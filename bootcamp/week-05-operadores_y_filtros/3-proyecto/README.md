# Proyecto Semanal — Operadores y Filtros

## Semana 05 — Evidencia de Producto (30%)

Escribe consultas de filtrado sobre el esquema de tu **dominio asignado**
usando `BETWEEN`, `IN`, `LIKE` y combinaciones.

---

> ## ⚠️ ANTES DE EMPEZAR — Verifica tus datos
>
> `BETWEEN`, `IN` y `LIKE` solo funcionan correctamente con datos variados y suficientes.
> Si todos tus registros tienen la misma ciudad o el mismo rango de fechas, los filtros no filtran nada.
> **Mínimo obligatorio para esta semana: 30 filas en tu tabla principal, 10 en cada tabla secundaria.**
>
> Cómo completar tus datos rápidamente:
> - **Mockaroo** → [mockaroo.com](https://mockaroo.com) — genera hasta 1.000 INSERT en segundos
> - **Copilot / ChatGPT** → pídele: *"Dame 30 INSERT INTO realistas para una tabla SQLite llamada `X` con columnas A, B, C"*
>
> 📖 Guía completa: [`docs/seed-datos.md`](../../../../docs/seed-datos.md)

---

## Instrucciones

1. Abre `starter/proyecto.sql`
2. Adapta los nombres de tablas y columnas a tu dominio
3. Implementa cada `TODO`
4. Ejecuta el archivo sin errores

---

## Requisitos mínimos

| Requisito | Descripción |
|-----------|-------------|
| BETWEEN | Al menos **1 filtro** por rango numérico o de fecha |
| IN | Al menos **1 filtro** con lista de valores |
| LIKE | Al menos **1 búsqueda** de texto con `%` |
| Combinado | Al menos **1 consulta** con ≥ 3 operadores distintos |

---

## Criterios de evaluación

- **Funcionalidad** (50%): todas las consultas se ejecutan sin error
- **Semántica** (30%): los filtros tienen sentido para el dominio asignado
- **Legibilidad** (20%): indentación, alias y comentarios en español
