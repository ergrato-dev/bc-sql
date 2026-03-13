# Rúbrica de Evaluación — Semana 14: Window Functions (Ranking)

## Distribución de puntaje

| Tipo | Peso | Descripción |
|------|------|-------------|
| Conocimiento 🧠 | 30% | Comprensión de window functions y ranking |
| Desempeño 💪 | 40% | Ejercicios ejecutados correctamente |
| Producto 📦 | 30% | Proyecto integrador adaptado al dominio |

---

## Conocimiento 🧠 (30 puntos)

| Criterio | Puntos | Indicadores |
|----------|--------|-------------|
| Explica OVER() y PARTITION BY | 10 | Describe partición sin colapsar filas |
| Diferencia RANK vs DENSE_RANK vs ROW_NUMBER | 10 | Ejemplo con empates (ties) correcto |
| Explica cómo filtrar top-N por grupo | 10 | Menciona CTE + WHERE rank_col <= N |

---

## Desempeño 💪 (40 puntos)

| Criterio | Puntos | Indicadores |
|----------|--------|-------------|
| ROW_NUMBER() con PARTITION BY ejecutado | 10 | Numeración reinicia por partición |
| RANK() con empates manejados | 10 | Valores iguales comparten rango |
| DENSE_RANK() ejecutado | 10 | Sin saltos en la numeración tras empate |
| Top-N por grupo con CTE + ranking | 10 | Filtra correctamente por el rank |

---

## Producto 📦 (30 puntos)

| Criterio | Puntos | Indicadores |
|----------|--------|-------------|
| Window function aplicada al dominio | 15 | OVER(PARTITION BY ... ORDER BY ...) correcto |
| Filtrado top-N implementado | 10 | CTE bien estructurado + WHERE rank <= N |
| Estilo y documentación SQL | 5 | Keywords UPPERCASE, comentarios en español |

---

## Criterios de aprobación

- Mínimo **70 puntos** en total
- Mínimo **21 puntos** en Conocimiento
- Mínimo **28 puntos** en Desempeño
- Mínimo **21 puntos** en Producto
