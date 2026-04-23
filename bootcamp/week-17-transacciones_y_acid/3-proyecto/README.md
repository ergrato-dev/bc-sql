# Proyecto Semanal — Semana 17: Transacciones y ACID

## Descripción

Implementa el control de integridad de datos de tu dominio asignado
usando transacciones explícitas con `BEGIN`, `COMMIT`, `ROLLBACK`
y al menos un `SAVEPOINT`.

---

> ## ⚠️ ANTES DE EMPEZAR — Verifica tus datos (PostgreSQL)
>
> Una transacción que opera sobre 3 filas no demuestra nada. Necesitas datos suficientes para que el `ROLLBACK` y el `SAVEPOINT` tengan impacto visible.
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
2. Carga el esquema genérico y adáptalo a tu dominio:
   ```bash
   docker compose -f scripts/docker-compose.yml exec -T postgres \
     psql -U bootcamp -d bootcamp_db < bootcamp/week-17-transacciones_y_acid/3-proyecto/starter/proyecto.sql
   ```
3. Conéctate:
   ```bash
   docker compose -f scripts/docker-compose.yml exec postgres \
     psql -U bootcamp -d bootcamp_db
   ```

## Requisitos del proyecto

1. **Esquema** — Al menos dos tablas relacionadas con claves foráneas
   y al menos una constraint `CHECK` que valide un invariante de negocio.

2. **Transacción exitosa** — Una operación que modifica ambas tablas
   dentro de un `BEGIN … COMMIT`. Verifica con `SELECT` que los datos
   son consistentes.

3. **Rollback explícito** — Una operación que inicia con `BEGIN`, hace
   cambios en una tabla y termina con `ROLLBACK` porque los datos
   no cumplen una regla de negocio. Explica en un comentario por qué
   se revierte.

4. **SAVEPOINT** — Una transacción que usa al menos un `SAVEPOINT`
   para deshacer parte de los cambios y confirmar el resto con `COMMIT`.

5. **Verificación final** — Consulta el estado de ambas tablas tras
   todas las transacciones y muestra que los datos son coherentes.

## Ejemplos de dominios y sus invariantes

| Dominio | Invariante de negocio |
|---------|----------------------|
| Biblioteca | Un ejemplar no puede estar prestado a dos miembros al mismo tiempo |
| Farmacia | El stock no puede ser negativo |
| Gimnasio | Un aprendiz no puede inscribirse dos veces a la misma clase |
| Escuela | La nota debe estar entre 0 y 100 |

> Adapta las tablas y los nombres según **tu dominio asignado**.
