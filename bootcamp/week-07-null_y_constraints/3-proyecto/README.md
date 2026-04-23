# Proyecto Semanal — NULL y Constraints

## Semana 07 — Evidencia de Producto (30%)

Amplía el esquema de tu dominio asignado aplicando correctamente
constraints de integridad y manejo seguro de valores NULL.

---

> ## ⚠️ ANTES DE EMPEZAR — Verifica tus datos
>
> Para practicar `IS NULL`, `COALESCE` y `CHECK` necesitas datos que incluyan NULLs reales y valores en los límites de los constraints.
> **Mínimo obligatorio para esta semana: 30 filas en tu tabla principal. Al menos 3 con columnas opcionales en NULL.**
>
> Cómo completar tus datos rápidamente:
> - **Mockaroo** → [mockaroo.com](https://mockaroo.com) — genera hasta 1.000 INSERT en segundos
> - **Copilot / ChatGPT** → pídele: *"Dame 30 INSERT INTO realistas para una tabla SQLite incluyendo algunos NULLs en columnas opcionales"*
>
> 📖 Guía completa: [`docs/seed-datos.md`](../../../../docs/seed-datos.md)

---

## Instrucciones

1. Abre `starter/proyecto.sql`
2. Adapta nombres de tablas y columnas a tu dominio
3. Implementa cada `TODO`
4. Ejecuta el archivo completo sin errores

---

## Requisitos mínimos

| Requisito | Descripción |
|-----------|-------------|
| NOT NULL | Columnas obligatorias marcadas explícitamente |
| UNIQUE | Al menos una columna con valor único (ej: código, email) |
| CHECK | Validación de negocio en al menos una columna |
| FOREIGN KEY | Relación entre dos tablas con `PRAGMA foreign_keys = ON` |
| IS NULL | Consulta que filtre filas con valor desconocido |
| COALESCE | Reemplaza un NULL en una consulta SELECT |

---

## Criterios de evaluación

- **Funcionalidad** (50%): Todas las sentencias ejecutan sin error
- **Correctitud** (30%): Los constraints tienen sentido para el dominio
- **Completitud** (20%): Todos los requisitos cubiertos
