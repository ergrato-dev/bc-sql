# Rúbrica de Evaluación — Semana 06

## Distribución de evidencias

| Tipo | Peso | Descripción |
|------|------|-------------|
| Conocimiento 🧠 | 30% | Cuestionario sobre agregación, GROUP BY, HAVING |
| Desempeño 💪 | 40% | Ejercicios prácticos completados y funcionales |
| Producto 📦 | 30% | Proyecto semanal adaptado al dominio asignado |

---

## Conocimiento (30%)

| Criterio | Puntaje |
|----------|---------|
| Explica qué cuenta `COUNT(*)` vs `COUNT(columna)` | 10 |
| Describe la diferencia entre `WHERE` y `HAVING` | 10 |
| Explica por qué las columnas no agregadas deben estar en `GROUP BY` | 10 |

---

## Desempeño (40%)

| Criterio | Puntaje |
|----------|---------|
| Ejercicio 01: COUNT(`*`), SUM, AVG, MIN, MAX correctamente | 10 |
| Ejercicio 01: combinación de función de agregación con WHERE | 10 |
| Ejercicio 02: GROUP BY con agrupación correcta | 10 |
| Ejercicio 02: HAVING con condición sobre función de agregación | 10 |

---

## Producto (30%)

| Criterio | Puntaje |
|----------|---------|
| Reporte de totales con al menos 3 funciones de agregación | 10 |
| GROUP BY con columna semánticamente relevante para el dominio | 10 |
| HAVING con filtro de negocio sobre el grupo | 10 |

---

## Criterios de aprobación

- Mínimo **70 puntos** en cada tipo de evidencia
- Todas las consultas ejecutables en SQLite sin error
- No usar `WHERE` para filtrar resultados de agregación (usar `HAVING`)
