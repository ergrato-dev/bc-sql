# 1. Revisión integradora — Etapa 2

## Objetivo

Conectar todos los conceptos aprendidos en las semanas 13–23 y entender
cómo interactúan en un sistema de base de datos real.

> Esta semana no introduce conceptos nuevos; consolida los anteriores.

---

## 1. Mapa de conceptos de la Etapa 2

| Semana | Concepto | Para qué sirve |
|--------|----------|----------------|
| 13–14 | Transacciones | Garantizar integridad ACID |
| 15–16 | Vistas e índices | Simplificar acceso y acelerar queries |
| 17–18 | Window functions | Análisis sin perder detalle de filas |
| 19 | Triggers | Automatizar auditoría y validación |
| 20 | LATERAL | Correlación en FROM, Top-N por grupo |
| 21 | Full-Text Search | Búsqueda semántica sin motor externo |
| 22 | JSONB | Atributos variables sin columnas extra |
| 23 | EXPLAIN ANALYZE | Medir y mejorar el rendimiento |

---

## 2. El ciclo de una consulta productiva

```
1. Diseño del esquema normalizado (semanas 1–12)
2. Escribir la query con JOIN / CTE / window function
3. Ejecutar EXPLAIN ANALYZE
4. Identificar seq scan o high cost
5. Crear índice apropiado (B-tree, partial, covering, GIN)
6. Volver al paso 3 y comparar
```

---

## 3. Cuándo usar cada herramienta

```sql
-- Datos con estructura fija → columnas relacionales
-- Datos con atributos variables → JSONB + GIN
-- Búsqueda por texto → tsvector + tsquery + GIN
-- Cálculos por partición → window functions
-- Lógica automática al escribir → triggers
-- Columna reutilizable → vista
-- Muchas filas, filtro selectivo → índice B-tree o parcial
```

---

## 4. Checklist

- ¿Cuándo el planificador ignora un índice existente?
- ¿Cuál es la diferencia entre `@>` y `->>`+`=`?
- ¿Para qué sirve `setweight` en Full-Text Search?
- ¿Cuándo un trigger BEFORE es preferible a AFTER?

---

## Referencias

- https://www.postgresql.org/docs/16/
- https://use-the-index-luke.com/
