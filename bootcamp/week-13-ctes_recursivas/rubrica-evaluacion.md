# Rúbrica de Evaluación — Semana 13: CTEs Recursivas

## Distribución de puntaje

| Tipo | Peso | Descripción |
|------|------|-------------|
| Conocimiento 🧠 | 30% | Comprensión de CTEs recursivas |
| Desempeño 💪 | 40% | Ejercicios ejecutados correctamente |
| Producto 📦 | 30% | Proyecto integrador adaptado al dominio |

---

## Conocimiento 🧠 (30 puntos)

| Criterio | Puntos | Indicadores |
|----------|--------|-------------|
| Identifica caso base y caso recursivo | 10 | Describe el `UNION ALL` que los une |
| Explica por qué `WITH RECURSIVE` sin condición loop | 10 | Menciona condición de parada o `WHERE` |
| Diferencia CTE recursiva de CTE normal | 10 | Describe auto-referencia de la tabla CTE |

---

## Desempeño 💪 (40 puntos)

| Criterio | Puntos | Indicadores |
|----------|--------|-------------|
| CTE recursiva para jerarquía ejecutada | 10 | Recorre N niveles desde la raíz |
| Columna `depth` calculada correctamente | 10 | Incrementa en cada paso recursivo |
| Generación de secuencia con recursión | 10 | Genera serie sin tabla base |
| Consulta sobre la jerarquía completa | 10 | Muestra path completo con columna |

---

## Producto 📦 (30 puntos)

| Criterio | Puntos | Indicadores |
|----------|--------|-------------|
| Jerarquía adaptada al dominio asignado | 15 | Tabla auto-referencial con parent_id |
| Código bien documentado | 10 | Comentarios explican caso base y recursivo |
| Naming y estilo PostgreSQL correcto | 5 | Keywords UPPERCASE, snake_case, sin SELECT * |

---

## Criterios de aprobación

- Mínimo **70 puntos** en total
- Mínimo **21 puntos** en Conocimiento
- Mínimo **28 puntos** en Desempeño
- Mínimo **21 puntos** en Producto
