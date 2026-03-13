# Semana 18 — Funciones y Procedimientos en PL/pgSQL

## Descripción

Aprende a encapsular lógica reutilizable en la base de datos mediante
**funciones** (`CREATE FUNCTION`) y **procedimientos** (`CREATE PROCEDURE`)
escritos en PL/pgSQL, el lenguaje procedural nativo de PostgreSQL 16.

## Motor de base de datos

**PostgreSQL 16** vía Docker.

```bash
docker compose -f _scripts/docker-compose.yml up -d
```

## Objetivos de la semana

- Crear funciones que retornan valores escalares, tablas y `VOID`
- Usar variables, condicionales (`IF/ELSIF/ELSE`) y bucles (`LOOP`, `FOR`) en PL/pgSQL
- Crear procedimientos almacenados con `CREATE PROCEDURE` y llamarlos con `CALL`
- Manejar excepciones dentro de bloques PL/pgSQL con `EXCEPTION`

## Distribución del tiempo (8 horas)

| Actividad                                     | Tiempo estimado |
|-----------------------------------------------|-----------------|
| Teoría                                        | 2 horas         |
| Ejercicio 01 (funciones escalares y de tabla) | 1.5 horas       |
| Ejercicio 02 (procedimientos y excepciones)   | 1.5 horas       |
| Proyecto                                      | 2 horas         |
| Recursos y repaso                             | 1 hora          |

## Contenido

### Teoría

1. [CREATE FUNCTION en PL/pgSQL](1-teoria/01-create-function.md)
2. [Variables, condicionales y bucles](1-teoria/02-variables-control.md)
3. [CREATE PROCEDURE y manejo de excepciones](1-teoria/03-procedure-exception.md)

### Assets

- [Anatomía de una función PL/pgSQL](0-assets/01-funcion-anatomia.svg)
- [Flujo PROCEDURE vs FUNCTION](0-assets/02-procedure-vs-function.svg)

### Prácticas

- [Ejercicio 01 — Funciones escalares y RETURNS TABLE](2-practicas/ejercicio-01/README.md)
- [Ejercicio 02 — Procedimientos y EXCEPTION](2-practicas/ejercicio-02/README.md)

### Proyecto

- [Proyecto semanal](3-proyecto/README.md)

### Recursos

- [Recursos adicionales](4-recursos/README.md)

### Glosario

- [Términos de la semana](5-glosario/README.md)

## Navegación

| Anterior | Actual | Siguiente |
|----------|--------|-----------|
| [Semana 17](../week-17/README.md) | Semana 18 | [Semana 19](../week-19/README.md) |
