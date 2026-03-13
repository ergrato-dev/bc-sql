# Semana 13: CTEs Recursivas

## Descripción

Las CTEs recursivas extienden la cláusula `WITH` con un modelo de consulta
que se ejecuta repetidamente hasta alcanzar una condición de parada.
Son la herramienta estándar para recorrer jerarquías y generar secuencias
en SQL. A partir de esta semana se usa **PostgreSQL 16 vía Docker**.

## Objetivos de la semana

1. Distinguir el caso base del caso recursivo en un CTE recursivo
2. Recorrer jerarquías (org chart) con `WITH RECURSIVE`
3. Generar secuencias numéricas y de fechas con recursión
4. Detectar ciclos y controlar la profundidad de recursión

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
     psql -U bootcamp -d bootcamp_db < bootcamp/week-13/2-practicas/ejercicio-01/starter/setup.sql
   ```
4. Conecta e interactúa:
   ```bash
   docker compose -f _scripts/docker-compose.yml exec postgres \
     psql -U bootcamp -d bootcamp_db
   ```

## Contenido

### Teoría

- [01 — CTE recursiva: estructura y funcionamiento](1-teoria/01-cte-recursiva-intro.md)
- [02 — Jerarquías con WITH RECURSIVE](1-teoria/02-cte-recursiva-jerarquia.md)
- [03 — Generación de secuencias](1-teoria/03-cte-recursiva-secuencias.md)

### Diagramas

- [Diagrama: Estructura CTE recursiva](0-assets/01-cte-recursiva-estructura.svg)
- [Diagrama: Jerarquía org chart](0-assets/02-jerarquia-org.svg)

### Prácticas

- [Ejercicio 01 — Árbol jerárquico de empleados](2-practicas/ejercicio-01/README.md)
- [Ejercicio 02 — Generación de secuencias](2-practicas/ejercicio-02/README.md)

### Proyecto

- [Proyecto Semana 13 — Jerarquías en tu dominio](3-proyecto/README.md)

## Motor de base de datos

**PostgreSQL 16** vía Docker — todos los archivos `.sql` de esta semana.
