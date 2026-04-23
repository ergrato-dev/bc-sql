# Proyecto Semana 01 — Conoce tu Dominio

## Descripción

Es tu primera semana. Antes de escribir código, necesitas **conocer y modelar
el dominio** que te fue asignado. En este proyecto crearás las tablas
principales de tu sistema y harás tus primeras consultas `SELECT`.

---

> ## ⚠️ ANTES DE EMPEZAR — Datos de prueba
>
> Tus consultas no se pueden evaluar con 2 o 3 registros inventados.
> **Mínimo obligatorio para esta semana: 15 filas en tu tabla principal, 5 en cada tabla secundaria.**
>
> Cómo obtener datos realistas rápidamente:
> - **Mockaroo** → [mockaroo.com](https://mockaroo.com) — genera hasta 1.000 INSERT en segundos
> - **Copilot / ChatGPT** → pídele: *"Dame 15 INSERT INTO realistas para una tabla SQLite llamada `X` con columnas A, B, C"*
>
> 📖 Guía completa: [`docs/seed-datos.md`](../../../../docs/seed-datos.md)

---

## Instrucciones

1. Identifica las **2 o 3 entidades principales** de tu dominio asignado.
2. Crea las tablas correspondientes con columnas relevantes y tipos de datos.
3. Inserta al menos **5 registros** en cada tabla.
4. Escribe consultas `SELECT` básicas sobre tus datos.

> Adapta las instrucciones a tu dominio:
>
> - Planetario → `celestial_bodies`, `observers`, `observations`
> - Escape room → `rooms`, `teams`, `bookings`
> - Acuario → `species`, `tanks`, `feeding_logs`
> - Marina deportiva → `boats`, `berths`, `owners`

## Entregable

Completa el archivo `starter/proyecto.sql` con tu implementación.

## Cómo ejecutar

```bash
sqlite3 mi_dominio.db < starter/proyecto.sql
sqlite3 mi_dominio.db
```
