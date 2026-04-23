# Proyecto Semanal — Semana 19: Triggers

## Tema: Automatización con triggers en tu dominio

Implementa una capa de triggers que automatice validaciones,
transformaciones y auditoría en la base de datos de tu dominio asignado
(biblioteca, farmacia, gimnasio, restaurante, etc.).

---

> ## ⚠️ ANTES DE EMPEZAR — Verifica tus datos (PostgreSQL)
>
> Un trigger que solo se dispara 2 veces no se puede validar. Necesitas operar con volumen para confirmar que funciona en todos los casos.
> **Mínimo obligatorio: 200 filas en tu tabla principal.**
>
> Cómo completar tus datos rápidamente:
> - **`generate_series`** en PostgreSQL → ver [`docs/seed-datos.md`](../../../../docs/seed-datos.md)
>
> 📖 Guía completa: [`docs/seed-datos.md`](../../../../docs/seed-datos.md)

---

## Cómo ejecutar

1. Asegúrate de tener Docker corriendo:
   ```bash
   docker compose -f scripts/docker-compose.yml up -d
   ```
2. Carga el esquema base:
   ```bash
   docker compose -f scripts/docker-compose.yml exec -T postgres \
     psql -U bootcamp -d bootcamp_db < bootcamp/week-19-triggers_automatizacion/3-proyecto/starter/proyecto.sql
   ```
3. Conecta e implementa:
   ```bash
   docker compose -f scripts/docker-compose.yml exec postgres \
     psql -U bootcamp -d bootcamp_db
   ```

## Objetivo

Demostrar que puedes diseñar y registrar cambios automáticamente
en tu dominio, sin intervención manual, usando triggers
`BEFORE` y `AFTER`.

## Requerimientos

1. **Trigger de auditoría (AFTER)**: Registra en una tabla de log
   cada `INSERT`, `UPDATE` y `DELETE` sobre tu entidad principal.
2. **Trigger de validación (BEFORE)**: Rechaza operaciones que
   incumplan una regla de negocio de tu dominio.
3. **Trigger de transformación (BEFORE)**: Normaliza o calcula
   automáticamente un campo antes de persistir.
4. **Demostración de DISABLE / ENABLE**: Muestra cómo pausar un
   trigger temporalmente y verificar el efecto.

## Criterios de evaluación

| Criterio                                      | Puntaje |
|-----------------------------------------------|---------|
| Trigger AFTER de auditoría funcional          | 30 pts  |
| Trigger BEFORE de validación con excepción    | 25 pts  |
| Trigger BEFORE de transformación              | 20 pts  |
| DISABLE/ENABLE demostrado correctamente       | 15 pts  |
| Código documentado con comentarios en español | 10 pts  |

## Entrega

- Archivo `proyecto.sql` con todos los TODOs implementados.
- Cada sección debe ejecutarse sin errores en PostgreSQL 16.
