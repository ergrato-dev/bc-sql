# 📋 Plan Curricular — Bootcamp SQL de Cero a Héroe

**Duración**: 24 semanas (~6 meses)  
**Dedicación**: 8 horas semanales  
**Total**: ~192 horas  
**Nivel de entrada**: Cero (sin experiencia previa en bases de datos)  
**Nivel de salida**: SQL Developer Junior / Data Analyst Junior  
**Motor principal**: SQLite (semanas 1–12) → PostgreSQL 16 vía Docker (semanas 13–24)

---

## Etapa 0 — Fundamentos de SQL · Semanas 1–8 · 64h · SQLite

| Semana | Título                               | Temas clave                                                                      | Horas |
| ------ | ------------------------------------ | -------------------------------------------------------------------------------- | ----- |
| 01     | Introducción a Bases de Datos        | BD relacional, tablas/filas/columnas, tipos de datos, primera consulta `SELECT`  | 8h    |
| 02     | DDL — Diseño de Esquemas             | `CREATE TABLE`, tipos de datos, `NOT NULL`, `DEFAULT`, `ALTER TABLE`, `DROP TABLE` | 8h  |
| 03     | DML — Manipulación de Datos          | `INSERT INTO`, `UPDATE`, `DELETE`, riesgos sin `WHERE`                           | 8h    |
| 04     | Consultas Básicas con SELECT         | `SELECT` explícito, `FROM`, `WHERE`, `ORDER BY`, `LIMIT`, `OFFSET`               | 8h    |
| 05     | Operadores y Filtros                 | Comparación, `AND/OR/NOT`, `BETWEEN`, `IN`, `LIKE`                               | 8h    |
| 06     | Funciones de Agregación              | `COUNT`, `SUM`, `AVG`, `MIN`, `MAX`, `GROUP BY`, `HAVING`                        | 8h    |
| 07     | NULL y Constraints                   | `IS NULL`, `COALESCE`, `NULLIF`, `PRIMARY KEY`, `FOREIGN KEY`, `UNIQUE`, `CHECK` | 8h    |
| 08     | Proyecto Integrador Etapa 0          | Esquema completo, DDL + DML + SELECT + agregaciones                              | 8h    |

---

## Etapa 1 — SQL Intermedio · Semanas 9–16 · 64h · SQLite → PostgreSQL

| Semana | Título                               | Temas clave                                                                          | Horas |
| ------ | ------------------------------------ | ------------------------------------------------------------------------------------ | ----- |
| 09     | JOINs I — INNER y LEFT JOIN          | Concepto de JOIN, `INNER JOIN`, `LEFT JOIN`, diferencias prácticas                   | 8h    |
| 10     | JOINs II — RIGHT, FULL, CROSS, SELF  | `RIGHT JOIN`, `FULL OUTER JOIN`, `CROSS JOIN`, `SELF JOIN` jerárquico                | 8h    |
| 11     | Subqueries                           | Escalares, en `WHERE` (`IN`, `EXISTS`), en `FROM`, correlacionadas                   | 8h    |
| 12     | CTEs y CTEs Recursivas               | `WITH`, CTEs encadenadas, CTEs recursivas, jerarquías                                | 8h    |
| 13     | Window Functions I                   | `ROW_NUMBER`, `RANK`, `DENSE_RANK`, `PARTITION BY`, top-N por grupo                  | 8h    |
| 14     | Window Functions II                  | `LEAD`, `LAG`, `FIRST_VALUE`, `LAST_VALUE`, `ROWS/RANGE BETWEEN`                    | 8h    |
| 15     | Vistas e Índices                     | `CREATE VIEW`, vistas materializadas, índices B-Tree/Hash, cuándo indexar            | 8h    |
| 16     | Funciones y CASE WHEN                | Funciones de cadena, fecha/hora, numéricas, `CASE WHEN` simple y buscado             | 8h    |

---

## Etapa 2 — SQL Avanzado · Semanas 17–24 · 64h · PostgreSQL 16 vía Docker

| Semana | Título                               | Temas clave                                                                           | Horas |
| ------ | ------------------------------------ | ------------------------------------------------------------------------------------- | ----- |
| 17     | Transacciones y ACID                 | `BEGIN/COMMIT/ROLLBACK/SAVEPOINT`, propiedades ACID, manejo de errores                | 8h    |
| 18     | Control de Concurrencia              | Dirty/phantom read, niveles de aislamiento, locks, deadlocks                          | 8h    |
| 19     | Procedimientos y Funciones PL/pgSQL  | `CREATE FUNCTION`, parámetros, `CALL`, función vs procedimiento                       | 8h    |
| 20     | Triggers                             | `CREATE TRIGGER`, `BEFORE/AFTER/INSTEAD OF`, auditoría, validación                   | 8h    |
| 21     | Optimización I — EXPLAIN ANALYZE     | `EXPLAIN`, `ANALYZE`, Seq Scan vs Index Scan, costo estimado vs real                  | 8h    |
| 22     | Optimización II + Normalización      | 1FN–BCNF, desnormalización estratégica, OLTP vs OLAP                                 | 8h    |
| 23     | PostgreSQL Avanzado                  | `JSONB`, arrays, `hstore`, extensiones, particionamiento, full-text search            | 8h    |
| 24     | Proyecto Final — Capstone            | Esquema completo, todas las features, optimización, documentación y presentación      | 8h    |

---

## Resumen de Distribución del Tiempo por Semana

| Actividad   | Horas/semana |
| ----------- | ------------ |
| Teoría      | 2–2.5h       |
| Prácticas   | 3–3.5h       |
| Proyecto    | 2–2.5h       |
| **Total**   | **8h**       |

---

## Transición de Motor de BD

| Etapa   | Semanas | Motor                          |
| ------- | ------- | ------------------------------ |
| Etapa 0 | 1–8     | SQLite                         |
| Etapa 1 | 9–12    | SQLite                         |
| Etapa 1 | 13–16   | PostgreSQL 16 vía Docker       |
| Etapa 2 | 17–24   | PostgreSQL 16 vía Docker       |

> ⚠️ La transición a PostgreSQL ocurre en la semana 13, con la introducción
> de Window Functions. A partir de esa semana todos los ejercicios y
> proyectos requieren Docker corriendo localmente.

---

_Última actualización: Marzo 2026_
