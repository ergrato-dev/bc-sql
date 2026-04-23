# Proyecto Semanal — DML: Manipulación de Datos

## Semana 03 — Evidencia de Producto (30%)

Aplica `INSERT INTO`, `UPDATE` y `DELETE` sobre el esquema diseñado en la Semana 02,
adaptado a tu **dominio asignado**.

---

> ## ⚠️ ANTES DE EMPEZAR — Datos de prueba
>
> Esta semana **el volumen de datos es el entregable principal**. Con 5 filas no se practica DML real.
> **Mínimo obligatorio: 15 filas en tu tabla principal, 5 en cada tabla secundaria.**
>
> Cómo obtener datos realistas rápidamente:
> - **Mockaroo** → [mockaroo.com](https://mockaroo.com) — genera hasta 1.000 INSERT en segundos
> - **Copilot / ChatGPT** → pídele: *"Dame 15 INSERT INTO realistas para una tabla SQLite llamada `X` con columnas A, B, C"*
>
> 📖 Guía completa: [`docs/seed-datos.md`](../../../../docs/seed-datos.md)

---

## Instrucciones

1. Abre `starter/proyecto.sql`
2. Cambia los nombres de tablas y columnas al vocabulario de tu dominio
3. Implementa cada `TODO` con SQL funcional
4. Ejecuta el archivo completo en SQLite para verificar que no hay errores

---

## Requisitos mínimos

| Requisito | Descripción |
|-----------|-------------|
| INSERT bulk | Al menos **2 tablas** con mínimo **15 filas** cada una |
| FK correcta | Los inserts respetan el orden padre → hijo |
| UPDATE seguro | Mínimo **2 sentencias UPDATE** con `WHERE` usando PK |
| UPDATE condicional | Al menos **1 UPDATE** sobre múltiples filas por condición |
| DELETE seguro | Mínimo **1 DELETE** precedido de un `SELECT` de verificación |

---

## Dominios de ejemplo

- Escape room → `rooms`, `teams`, `bookings`
- Acuario → `species`, `tanks`, `feeding_logs`
- Marina deportiva → `boats`, `berths`, `owners`
- Empresa pesquera → `vessels`, `catches`, `species`

---

## Criterios de evaluación

- **Funcionalidad** (50%): todos los scripts se ejecutan sin error
- **Integridad de datos** (25%): FKs respetadas, constraints satisfechos
- **Buenas prácticas** (25%): `WHERE` en UPDATE/DELETE, comentarios en español
