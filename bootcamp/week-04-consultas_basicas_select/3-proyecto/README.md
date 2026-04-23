# Proyecto Semanal — Consultas SELECT

## Semana 04 — Evidencia de Producto (30%)

Escribe consultas `SELECT` sobre el esquema de tu **dominio asignado**,
ya pobado con datos reales en la Semana 03.

---

> ## ⚠️ ANTES DE EMPEZAR — Verifica tus datos
>
> Un `SELECT` sobre 3 filas no prueba nada. Si no tienes datos suficientes de la semana anterior, agrégalos ahora.
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
3. Implementa cada `TODO` con SQL funcional
4. Ejecuta el archivo completo sin errores

---

## Requisitos mínimos

| Requisito | Descripción |
|-----------|-------------|
| SELECT explícito | Ninguna consulta usa `SELECT *` |
| Alias | Al menos **3 consultas** con alias descriptivos en español |
| WHERE | Al menos **2 filtros** con operadores diferentes |
| ORDER BY | Al menos **2 consultas** con orden lógico para el dominio |
| LIMIT/OFFSET | Al menos **1 consulta paginada** (2 páginas) |

---

## Criterios de evaluación

- **Funcionalidad** (50%): todas las consultas se ejecutan sin error
- **Legibilidad** (30%): alias descriptivos, indentación correcta
- **Cobertura** (20%): cada requisito mínimo cubierto
