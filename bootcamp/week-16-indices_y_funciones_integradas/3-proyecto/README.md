# Semana 16 — Proyecto: Índices y Consultas Optimizadas

## Descripción

Aplica índices estratégicos a las tablas de tu dominio y crea un reporte
que combine funciones de cadena, fecha y numéricas para transformar y
presentar los datos.

---

> ## ⚠️ ANTES DE EMPEZAR — Verifica tus datos (PostgreSQL)
>
> Los índices y `EXPLAIN ANALYZE` solo muestran diferencia de rendimiento con volumen real. Con 20 filas un seq scan y un index scan son idénticos.
> **Mínimo obligatorio: 200 filas en tu tabla principal.**
>
> Cómo completar tus datos rápidamente:
> - **`generate_series`** en PostgreSQL → ver [`docs/seed-datos.md`](../../../../docs/seed-datos.md)
> - **Copilot / ChatGPT** → pídele: *"Dame un INSERT masivo con generate_series para una tabla PostgreSQL de tu dominio"*
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

Adapta el esquema genérico a tu dominio asignado. Ejemplos de columnas
relevantes:

| Dominio     | Columna de texto  | Columna de fecha  | Columna numérica |
|-------------|------------------|------------------|-----------------|
| Biblioteca  | title, author     | loan_date        | fine_amount      |
| Farmacia    | medicine_name     | expiry_date      | price            |
| Gimnasio    | member_name       | registration_date| monthly_fee      |
| Restaurante | dish_name         | order_date       | price            |

## Evidencia a entregar

- `proyecto.sql` con los tres TODOs implementados
- EXPLAIN capturado antes y después del índice
- Reporte con funciones de texto, fecha y numérica funcionando

## Criterios de evaluación

| Criterio                                            | Puntos |
|-----------------------------------------------------|--------|
| Índice creado y verificado con EXPLAIN              | 25     |
| Funciones de texto aplicadas correctamente          | 25     |
| Funciones de fecha con AGE o DATE_TRUNC             | 25     |
| Reporte final combinado, estilo y comentarios       | 25     |
| **Total**                                           | **100**|
