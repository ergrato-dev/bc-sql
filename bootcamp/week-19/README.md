# Semana 19 — Triggers: Automatización de lógica en la base de datos

## Descripción

Aprende a ejecutar lógica automáticamente cuando ocurren eventos DML
(`INSERT`, `UPDATE`, `DELETE`) o DDL usando **triggers** en PostgreSQL 16.

## Motor de base de datos

**PostgreSQL 16** vía Docker.

```bash
docker compose -f _scripts/docker-compose.yml up -d
```

## Objetivos de la semana

- Entender la diferencia entre triggers `BEFORE` y `AFTER`, y `ROW` vs `STATEMENT`
- Crear trigger functions con `NEW` y `OLD` en PL/pgSQL
- Implementar triggers de auditoría y validación automática
- Gestionar el ciclo de vida de un trigger: crear, deshabilitar, eliminar

## Distribución del tiempo (8 horas)

| Actividad                                    | Tiempo estimado |
|----------------------------------------------|-----------------|
| Teoría                                       | 2 horas         |
| Ejercicio 01 (triggers de auditoría)         | 1.5 horas       |
| Ejercicio 02 (triggers BEFORE con validación) | 1.5 horas      |
| Proyecto                                     | 2 horas         |
| Recursos y repaso                            | 1 hora          |

## Contenido

### Teoría

1. [Qué es un trigger y sus tipos](1-teoria/01-triggers-intro.md)
2. [NEW, OLD y la trigger function](1-teoria/02-trigger-function.md)
3. [Triggers BEFORE, AFTER y INSTEAD OF](1-teoria/03-before-after.md)

### Assets

- [Anatomía de un trigger](0-assets/01-trigger-anatomia.svg)
- [Flujo BEFORE vs AFTER](0-assets/02-before-after-flow.svg)

### Prácticas

- [Ejercicio 01 — Trigger de auditoría AFTER INSERT/UPDATE/DELETE](2-practicas/ejercicio-01/README.md)
- [Ejercicio 02 — Trigger BEFORE con validación y transformación](2-practicas/ejercicio-02/README.md)

### Proyecto

- [Proyecto semanal](3-proyecto/README.md)

### Recursos

- [Recursos adicionales](4-recursos/README.md)

### Glosario

- [Términos de la semana](5-glosario/README.md)

## Navegación

| Anterior | Actual | Siguiente |
|----------|--------|-----------|
| [Semana 18](../week-18/README.md) | Semana 19 | [Semana 20](../week-20/README.md) |
