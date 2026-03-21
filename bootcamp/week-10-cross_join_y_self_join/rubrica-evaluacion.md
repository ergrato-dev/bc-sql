# Rúbrica de Evaluación — Semana 10: CROSS JOIN y SELF JOIN

## Tabla de criterios

### Conocimiento 🧠 (30%)

| Criterio | Excelente (100%) | Satisfactorio (70%) | Insuficiente (<70%) |
|----------|-----------------|---------------------|---------------------|
| CROSS JOIN | Explica producto cartesiano y calcula filas resultantes | Sabe usarlo pero no calcula el total | No distingue CROSS JOIN de INNER JOIN |
| SELF JOIN | Explica por qué necesita dos aliases y qué representa cada uno | Usa aliases pero no explica el motivo | Confunde la tabla consigo misma |
| Auto-referencial | Define FK hacia la misma tabla y explica el rol de NULL | Define la columna pero no explica NULL | No identifica la columna padre |
| Rendimiento | Menciona el riesgo de tablas grandes con CROSS JOIN | Sabe que puede ser lento | No identifica riesgo |

### Desempeño 💪 (40%)

| Criterio | Excelente (100%) | Satisfactorio (70%) | Insuficiente (<70%) |
|----------|-----------------|---------------------|---------------------|
| CROSS JOIN funcional | Genera el producto cartesiano correcto con filtros | Genera combinaciones sin filtros | No ejecuta el query |
| SELF JOIN con alias | Usa `e` y `m` (u otros alias descriptivos) correctamente | Usa alias pero los confunde | Usa la tabla sin alias |
| Jerarquía 1 nivel | Obtiene empleado + su jefe | Obtiene el nombre pero falta columna | No produce el JOIN |
| Jerarquía 2 niveles | Encadena 3 aliases para 2 niveles jerárquicos | Solo logra 1 nivel | No intenta el segundo nivel |

### Producto 📦 (30%)

| Criterio | Excelente (100%) | Satisfactorio (70%) | Insuficiente (<70%) |
|----------|-----------------|---------------------|---------------------|
| Esquema con FK auto-ref | Tabla con `parent_id` o equivalente bien definida | Tiene la columna pero sin FK constraint | No implementa la relación |
| Consultas funcionales | Las 4 consultas del proyecto ejecutan sin error | 3 de 4 funcionan | Menos de 3 funcionan |
| Dominio adaptado | Nombres de tablas y columnas coherentes con el dominio | Usa nombres genéricos del starter | No adapta el dominio |
| Comentarios en español | Explica el propósito de cada query | Comenta parcialmente | Sin comentarios |

## Puntaje total

| Tipo | Peso | Mínimo para aprobar |
|------|------|---------------------|
| Conocimiento 🧠 | 30% | 70% |
| Desempeño 💪   | 40% | 70% |
| Producto 📦    | 30% | 70% |
