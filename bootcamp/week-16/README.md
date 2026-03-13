# Semana 16 — Índices y Funciones Integradas

## Descripción

Aprende a **crear y usar índices** para acelerar consultas, y domina
las **funciones integradas** de PostgreSQL para cadenas de texto,
fechas y números.

## Motor de base de datos

**PostgreSQL 16** vía Docker.

```bash
docker compose -f _scripts/docker-compose.yml up -d
```

## Objetivos de la semana

- Entender qué es un índice y cómo afecta el rendimiento de las consultas
- Crear índices B-tree con `CREATE INDEX` y evaluar su uso con `EXPLAIN`
- Manipular texto con funciones de cadena (`UPPER`, `TRIM`, `SUBSTRING`, etc.)
- Trabajar con fechas y tiempos (`NOW()`, `DATE_TRUNC`, `AGE`, `EXTRACT`)
- Aplicar funciones numéricas (`ROUND`, `CEIL`, `FLOOR`, `ABS`)

## Distribución del tiempo (8 horas)

| Actividad                          | Tiempo estimado |
|------------------------------------|-----------------|
| Teoría                             | 2 horas         |
| Ejercicio 01 (Índices + EXPLAIN)   | 1.5 horas       |
| Ejercicio 02 (Funciones integradas)| 1.5 horas       |
| Proyecto                           | 2 horas         |
| Recursos y repaso                  | 1 hora          |

## Contenido

### Teoría

1. [Índices — cómo funcionan y cuándo usarlos](1-teoria/01-indices.md)
2. [Funciones de cadena y fecha](1-teoria/02-funciones-cadena-fecha.md)
3. [Funciones numéricas y CAST](1-teoria/03-funciones-numericas-cast.md)

### Assets

- [Diagrama de índice B-tree](0-assets/01-btree-index.svg)
- [Mapa de funciones integradas](0-assets/02-funciones-mapa.svg)

### Prácticas

- [Ejercicio 01 — Índices y EXPLAIN](2-practicas/ejercicio-01/README.md)
- [Ejercicio 02 — Funciones de cadena, fecha y numéricas](2-practicas/ejercicio-02/README.md)

### Proyecto

- [Proyecto semanal](3-proyecto/README.md)

### Recursos

- [Recursos adicionales](4-recursos/README.md)

### Glosario

- [Términos de la semana](5-glosario/README.md)

## Navegación

| Anterior | Actual | Siguiente |
|----------|--------|-----------|
| [Semana 15](../week-15/README.md) | Semana 16 | [Semana 17](../week-17/README.md) |
