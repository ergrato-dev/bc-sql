# Proyecto Semanal — Funciones de Agregación

## Semana 06 — Evidencia de Producto (30%)

Genera reportes de resumen sobre los datos de tu **dominio asignado**
usando funciones de agregación, `GROUP BY` y `HAVING`.

---

> ## ⚠️ ANTES DE EMPEZAR — Verifica tus datos
>
> `GROUP BY` con 5 filas produce grupos de 1 o 2 registros. `HAVING` nunca filtra nada. Eso no es practicar agregaciones, es engañarse.
> **Mínimo obligatorio para esta semana: 30 filas en tu tabla principal con distribución desigual entre grupos.**
>
> Cómo completar tus datos rápidamente:
> - **Mockaroo** → [mockaroo.com](https://mockaroo.com) — genera hasta 1.000 INSERT en segundos
> - **Copilot / ChatGPT** → pídele: *"Dame 30 INSERT INTO realistas para una tabla SQLite con distribución desigual por categoría"*
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
| COUNT | Total de registros de tu entidad principal |
| SUM + AVG | Suma y promedio de una columna numérica relevante |
| GROUP BY | Agrupación con al menos 2 funciones de agregación |
| HAVING | Filtro de grupo con condición de negocio |

---

## Criterios de evaluación

- **Funcionalidad** (50%): todas las consultas ejecutan sin error
- **Semántica** (30%): los reportes tienen sentido para el dominio
- **Completitud** (20%): todos los requisitos cubiertos
