# Semana 17 — Transacciones y propiedades ACID

## Descripción

Aprende a controlar la **integridad de datos** mediante transacciones
con `BEGIN`, `COMMIT`, `ROLLBACK` y `SAVEPOINT`. Entiende qué significa
que una base de datos sea ACID-compliant.

## Motor de base de datos

**PostgreSQL 16** vía Docker.

```bash
docker compose -f scripts/docker-compose.yml up -d
```

## Objetivos de la semana

- Entender las cuatro propiedades ACID y qué protege cada una
- Controlar transacciones con `BEGIN`, `COMMIT` y `ROLLBACK`
- Usar `SAVEPOINT` para rollback parcial dentro de una transacción
- Identificar problemas de concurrencia: dirty read, non-repeatable read, phantom read

## Distribución del tiempo (8 horas)

| Actividad                                | Tiempo estimado |
|------------------------------------------|-----------------|
| Teoría                                   | 2 horas         |
| Ejercicio 01 (BEGIN/COMMIT/ROLLBACK)     | 1.5 horas       |
| Ejercicio 02 (SAVEPOINT y niveles de aislamiento) | 1.5 horas |
| Proyecto                                 | 2 horas         |
| Recursos y repaso                        | 1 hora          |

## Contenido

### Teoría

1. [Propiedades ACID](1-teoria/01-acid.md)
2. [BEGIN, COMMIT y ROLLBACK](1-teoria/02-begin-commit-rollback.md)
3. [SAVEPOINT y niveles de aislamiento](1-teoria/03-savepoint-isolation.md)

### Assets

- [Diagrama propiedades ACID](0-assets/01-acid-propiedades.svg)
- [Diagrama flujo de transacción](0-assets/02-transaccion-flujo.svg)

### Prácticas

- [Ejercicio 01 — BEGIN, COMMIT y ROLLBACK](2-practicas/ejercicio-01/README.md)
- [Ejercicio 02 — SAVEPOINT y manejo de errores](2-practicas/ejercicio-02/README.md)

### Proyecto

- [Proyecto semanal](3-proyecto/README.md)

### Recursos

- [Recursos adicionales](4-recursos/README.md)

### Glosario

- [Términos de la semana](5-glosario/README.md)

## Navegación

| Anterior | Actual | Siguiente |
|----------|--------|-----------|
| [Semana 16](../week-16-indices_y_funciones_integradas/README.md) | Semana 17 | [Semana 18](../week-18-funciones_y_procedimientos_plpgsql/README.md) |
