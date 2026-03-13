# Proyecto Integrador — Etapa 0

## Semana 08 — Evidencia de Producto (30%)

Este is el **capstone de la Etapa 0**. Diseña e implementa un esquema
completo para tu **dominio asignado**, aplicando todo lo aprendido en
las semanas 01–07.

---

## Instrucciones

1. Abre `starter/proyecto.sql`
2. Adapta todos los nombres al dominio asignado
3. Implementa cada `TODO`
4. Ejecuta el archivo sin errores de principio a fin

---

## Requisitos obligatorios

### Esquema (DDL)

- 3 tablas relacionadas (al menos 1 relación 1:N con FK)
- Cada tabla con PK
- Mínimo 1 columna con UNIQUE, 1 con CHECK, 1 con DEFAULT
- `PRAGMA foreign_keys = ON` al inicio

### Datos (DML)

- Al menos 3 registros en cada tabla de referencia
- Al menos 8 registros en la tabla principal
- Al menos 2 registros con una columna opcional en NULL

### Consultas de reporte (SELECT)

| # | Reporte | Cláusulas obligatorias |
|---|---------|------------------------|
| 1 | Totales globales | COUNT, SUM o AVG |
| 2 | Reporte por categoría | GROUP BY + ORDER BY |
| 3 | Grupos con umbral | GROUP BY + HAVING |
| 4 | Manejo de NULL | IS NULL o COALESCE |
| 5 | Búsqueda combinada | WHERE + rango o patrón |

---

## Criterios de evaluación

- **Funcionalidad** (40%): Todo el archivo ejecuta sin error
- **Diseño del esquema** (30%): Constraints justificados para el dominio
- **Calidad de reportes** (20%): Consultas con sentido de negocio
- **Estilo de código** (10%): UPPERCASE keywords, comentarios en español
