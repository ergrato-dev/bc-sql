# Proyecto Semana 02 — DDL de tu Dominio

## Descripción

Esta semana aplicarás lo aprendido sobre DDL para diseñar el esquema de base
de datos de tu dominio asignado. Crearás las tablas con tipos de datos y
constraints adecuados.

---

> ## ⚠️ ANTES DE EMPEZAR — Datos de prueba
>
> El DDL sin datos no se puede probar. Define el esquema **y** cárgalo con datos desde el inicio.
> **Mínimo obligatorio para esta semana: 15 filas en tu tabla principal, 5 en cada tabla secundaria.**
>
> Cómo obtener datos realistas rápidamente:
> - **Mockaroo** → [mockaroo.com](https://mockaroo.com) — genera hasta 1.000 INSERT en segundos
> - **Copilot / ChatGPT** → pídele: *"Dame 15 INSERT INTO realistas para una tabla SQLite llamada `X` con columnas A, B, C"*
>
> 📖 Guía completa: [`docs/seed-datos.md`](../../../../docs/seed-datos.md)

---

## Instrucciones

1. Identifica las **3 entidades principales** de tu dominio.
2. Define columnas con tipos de datos apropiados.
3. Aplica `NOT NULL`, `DEFAULT`, `UNIQUE` y al menos un `CHECK`.
4. Usa `IF NOT EXISTS` para que el script sea idempotente.

> Adapta las tablas a tu dominio:
>
> - Biblioteca → `books`, `members`, `loans`
> - Farmacia → `medicines`, `categories`, `suppliers`
> - Gimnasio → `members`, `plans`, `trainers`
> - Agencia de taxis → `drivers`, `vehicles`, `trips`

## Entregable

Completa `starter/proyecto.sql` con tu implementación.

## Cómo ejecutar

```bash
sqlite3 mi_dominio.db < starter/proyecto.sql
sqlite3 mi_dominio.db
.tables
PRAGMA table_info(nombre_tabla);
```
