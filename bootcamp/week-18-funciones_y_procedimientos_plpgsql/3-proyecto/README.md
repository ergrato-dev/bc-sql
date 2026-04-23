# Proyecto Semanal — Semana 18: Funciones y Procedimientos PL/pgSQL

## Descripción

Encapsula la lógica de negocio de tu dominio asignado en funciones
y procedimientos PL/pgSQL, añadiendo validaciones y auditoría de operaciones.

---

> ## ⚠️ ANTES DE EMPEZAR — Verifica tus datos (PostgreSQL)
>
> Una función que solo se prueba con 2 llamadas no está probada. Necesitas datos suficientes para cubrir todos los casos de la lógica condicional.
> **Mínimo obligatorio: 200 filas en tu tabla principal.**
>
> Cómo completar tus datos rápidamente:
> - **`generate_series`** en PostgreSQL → ver [`docs/seed-datos.md`](../../../../docs/seed-datos.md)
>
> 📖 Guía completa: [`docs/seed-datos.md`](../../../../docs/seed-datos.md)

---

## Cómo ejecutar

1. Inicia el contenedor:
   ```bash
   docker compose -f scripts/docker-compose.yml up -d
   ```
2. Carga el esquema:
   ```bash
   docker compose -f scripts/docker-compose.yml exec -T postgres \
     psql -U bootcamp -d bootcamp_db < bootcamp/week-18-funciones_y_procedimientos_plpgsql/3-proyecto/starter/proyecto.sql
   ```
3. Conéctate:
   ```bash
   docker compose -f scripts/docker-compose.yml exec postgres \
     psql -U bootcamp -d bootcamp_db
   ```

## Requisitos del proyecto

1. **Esquema** — Al menos dos tablas de tu dominio más una tabla
   `audit_log` para registrar operaciones importantes.

2. **Función escalar** — Una función que calcule o clasifique un valor
   a partir de los datos de tu dominio (ej: categoría, nivel, estado).

3. **Función RETURNS TABLE** — Una función que retorne registros filtrados
   o transformados (ej: lista de ítems disponibles, reporte de top items).

4. **Procedimiento con COMMIT** — Un procedimiento que encapsule una
   operación de negocio crítica (ej: registrar un pedido, un préstamo,
   una inscripción) y llame `COMMIT` al finalizar.

5. **Manejo de excepciones** — El procedimiento debe lanzar `RAISE EXCEPTION`
   con mensaje descriptivo si no se cumple una condición de negocio.
   Los intentos fallidos deben quedar registrados en `audit_log`.

6. **Bloque DO** — Usa un bloque anónimo `DO` para probar varios escenarios
   (casos exitosos y casos con error) llamando al procedimiento.

## Ejemplos de dominios

| Dominio | Operación crítica a encapsular |
|---------|-------------------------------|
| Biblioteca | Prestar un libro (verificar disponibilidad) |
| Farmacia | Vender un medicamento (verificar stock) |
| Gimnasio | Inscribir a una clase (verificar cupo máximo) |
| Escuela | Registrar una nota (verificar rango 0–100) |

> Adapta los nombres de tablas y funciones según tu dominio asignado.
