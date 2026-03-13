# Proyecto Semanal — NULL y Constraints

## Semana 07 — Evidencia de Producto (30%)

Amplía el esquema de tu dominio asignado aplicando correctamente
constraints de integridad y manejo seguro de valores NULL.

---

## Instrucciones

1. Abre `starter/proyecto.sql`
2. Adapta nombres de tablas y columnas a tu dominio
3. Implementa cada `TODO`
4. Ejecuta el archivo completo sin errores

---

## Requisitos mínimos

| Requisito | Descripción |
|-----------|-------------|
| NOT NULL | Columnas obligatorias marcadas explícitamente |
| UNIQUE | Al menos una columna con valor único (ej: código, email) |
| CHECK | Validación de negocio en al menos una columna |
| FOREIGN KEY | Relación entre dos tablas con `PRAGMA foreign_keys = ON` |
| IS NULL | Consulta que filtre filas con valor desconocido |
| COALESCE | Reemplaza un NULL en una consulta SELECT |

---

## Criterios de evaluación

- **Funcionalidad** (50%): Todas las sentencias ejecutan sin error
- **Correctitud** (30%): Los constraints tienen sentido para el dominio
- **Completitud** (20%): Todos los requisitos cubiertos
