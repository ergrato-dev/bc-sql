# Semana 14: Window Functions — Ranking

## Descripción

Las funciones de ventana operan sobre un conjunto de filas relacionadas
con la fila actual sin colapsar el resultado (a diferencia de `GROUP BY`).
Esta semana cubre las funciones de ranking: `ROW_NUMBER()`, `RANK()` y
`DENSE_RANK()`, con la cláusula `OVER(PARTITION BY ... ORDER BY ...)`.

## Objetivos de la semana

1. Entender qué es una ventana (`window`) y cómo se define con `OVER()`
2. Usar `PARTITION BY` para dividir en grupos independientes
3. Diferenciar `ROW_NUMBER()`, `RANK()` y `DENSE_RANK()` en casos de empate
4. Filtrar los top-N por grupo usando CTE + window function

## Distribución del tiempo (8 horas)

| Actividad | Tiempo |
|-----------|--------|
| Teoría (3 archivos) | 2 h |
| Prácticas (2 ejercicios) | 3 h |
| Proyecto integrador | 2 h |
| Revisión y glosario | 1 h |

## Cómo ejecutar

1. Asegúrate de tener Docker corriendo
2. Levanta el contenedor:
   ```bash
   docker compose -f _scripts/docker-compose.yml up -d
   ```
3. Carga el esquema de prueba:
   ```bash
   docker compose -f _scripts/docker-compose.yml exec -T postgres \
     psql -U bootcamp -d bootcamp_db < bootcamp/week-14/2-practicas/ejercicio-01/starter/setup.sql
   ```
4. Conecta e interactúa:
   ```bash
   docker compose -f _scripts/docker-compose.yml exec postgres \
     psql -U bootcamp -d bootcamp_db
   ```

## Contenido

### Teoría

- [01 — Funciones de ventana: la cláusula OVER()](1-teoria/01-window-functions-intro.md)
- [02 — ROW_NUMBER, RANK y DENSE_RANK](1-teoria/02-row-number-rank.md)
- [03 — Filtrar top-N por grupo con CTE](1-teoria/03-top-n-por-grupo.md)

### Diagramas

- [Diagrama: OVER y PARTITION BY](0-assets/01-window-partition.svg)
- [Diagrama: RANK vs DENSE_RANK vs ROW_NUMBER](0-assets/02-rank-comparacion.svg)

### Prácticas

- [Ejercicio 01 — ROW_NUMBER y RANK básicos](2-practicas/ejercicio-01/README.md)
- [Ejercicio 02 — DENSE_RANK y top-N por grupo](2-practicas/ejercicio-02/README.md)

### Proyecto

- [Proyecto Semana 14 — Ranking en tu dominio](3-proyecto/README.md)

## Motor de base de datos

**PostgreSQL 16** vía Docker — todos los archivos `.sql` de esta semana.
