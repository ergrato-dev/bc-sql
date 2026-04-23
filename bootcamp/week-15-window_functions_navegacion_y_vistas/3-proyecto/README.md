# Semana 15 — Proyecto: Análisis temporal con Window Functions y Vistas

## Descripción

Aplica `LAG()`, `LEAD()`, `FIRST_VALUE()` y `LAST_VALUE()` a datos temporales
de tu dominio asignado. Encapsula el análisis en una **vista** reutilizable.

---

> ## ⚠️ ANTES DE EMPEZAR — Verifica tus datos (PostgreSQL)
>
> `LAG()` y `LEAD()` sobre 10 filas ordenadas por fecha no muestra tendencias. Necesitas datos con variación temporal real a lo largo de varios meses.
> **Mínimo obligatorio: 200 filas en tu tabla principal, con fechas distribuidas en al menos 12 meses.**
>
> Cómo completar tus datos rápidamente:
> - **`generate_series`** en PostgreSQL → ver [`docs/seed-datos.md`](../../../../docs/seed-datos.md)
> - **Copilot / ChatGPT** → pídele: *"Dame un INSERT con generate_series PostgreSQL con fechas distribuidas en los últimos 2 años"*
>
> 📖 Guía completa: [`docs/seed-datos.md`](../../../../docs/seed-datos.md)

---

## Cómo ejecutar

1. Asegúrate de tener Docker corriendo
2. Levanta el contenedor:
   ```bash
   docker compose -f scripts/docker-compose.yml up -d
   ```
3. Carga el esquema de prueba:
   ```bash
   docker compose -f scripts/docker-compose.yml exec -T postgres \
     psql -U bootcamp -d bootcamp_db < starter/proyecto.sql
   ```
4. Conecta e interactúa:
   ```bash
   docker compose -f scripts/docker-compose.yml exec postgres \
     psql -U bootcamp -d bootcamp_db
   ```

## Instrucciones

Adapta el esquema genérico a tu dominio asignado. Ejemplos:

| Dominio     | Tabla temporal     | Métrica a analizar   |
|-------------|-------------------|----------------------|
| Biblioteca  | monthly_loans     | total_loans          |
| Farmacia    | monthly_sales     | revenue              |
| Gimnasio    | monthly_attendance| sessions_count       |
| Restaurante | daily_orders      | total_orders         |
| Hotel       | monthly_bookings  | occupancy_rate       |

## Evidencia a entregar

- `proyecto.sql` con los tres TODOs implementados y ejecutables
- La vista creada correctamente y consultada con filtro
- Comentarios en español explicando cada paso

## Criterios de evaluación

| Criterio                                                 | Puntos |
|----------------------------------------------------------|--------|
| LAG/delta funcional con datos del dominio                | 25     |
| FIRST_VALUE/LAST_VALUE con frame correcto                | 25     |
| Vista creada y consultada con WHERE                      | 30     |
| Estilo SQL, nomenclatura y comentarios en español        | 20     |
| **Total**                                                | **100**|
