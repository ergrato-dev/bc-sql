# Semana 15 — Window Functions: Navegación y Vistas

## Descripción

Explora las funciones de ventana de **navegación** (`LEAD`, `LAG`,
`FIRST_VALUE`, `LAST_VALUE`) y crea **vistas** (`CREATE VIEW`) para
encapsular consultas reutilizables.

## Motor de base de datos

**PostgreSQL 16** vía Docker.

```bash
docker compose -f _scripts/docker-compose.yml up -d
```

## Objetivos de la semana

- Calcular diferencias entre filas consecutivas con `LEAD()` y `LAG()`
- Obtener el primer y último valor de una partición con `FIRST_VALUE()` / `LAST_VALUE()`
- Crear vistas para encapsular window functions y simplificar queries
- Combinar vistas con CTEs para análisis complejos

## Distribución del tiempo (8 horas)

| Actividad              | Tiempo estimado |
|------------------------|-----------------|
| Teoría                 | 2 horas         |
| Ejercicio 01 (LAG/LEAD)| 1.5 horas       |
| Ejercicio 02 (FIRST/LAST + VIEW) | 1.5 horas |
| Proyecto               | 2 horas         |
| Recursos y repaso      | 1 hora          |

## Contenido

### Teoría

1. [LEAD y LAG — desplazamiento entre filas](1-teoria/01-lead-lag.md)
2. [FIRST_VALUE y LAST_VALUE](1-teoria/02-first-last-value.md)
3. [CREATE VIEW — vistas en PostgreSQL](1-teoria/03-create-view.md)

### Assets

- [Diagrama LEAD/LAG](0-assets/01-lead-lag-diagrama.svg)
- [Diagrama FIRST_VALUE/LAST_VALUE con frame](0-assets/02-first-last-frame.svg)

### Prácticas

- [Ejercicio 01 — LEAD y LAG para comparar filas](2-practicas/ejercicio-01/README.md)
- [Ejercicio 02 — FIRST_VALUE, LAST_VALUE y CREATE VIEW](2-practicas/ejercicio-02/README.md)

### Proyecto

- [Proyecto semanal](3-proyecto/README.md)

### Recursos

- [Recursos adicionales](4-recursos/README.md)

### Glosario

- [Términos de la semana](5-glosario/README.md)

## Navegación

| Anterior | Actual | Siguiente |
|----------|--------|-----------|
| [Semana 14](../week-14/README.md) | Semana 15 | [Semana 16](../week-16/README.md) |
