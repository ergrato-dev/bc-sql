# Rúbrica de Evaluación — Semana 21

## Distribución de evidencias

| Tipo         | Peso | Descripción                                      |
|--------------|------|--------------------------------------------------|
| Conocimiento | 30%  | Cuestionario sobre FTS, tsvector y GIN           |
| Desempeño    | 40%  | Ejercicios prácticos ejecutados correctamente    |
| Producto     | 30%  | Proyecto semanal funcional                       |

---

## Conocimiento (30 pts)

| Criterio                                                               | Pts |
|------------------------------------------------------------------------|-----|
| Explica la diferencia entre `tsvector` y un `TEXT` normal             | 10  |
| Describe cuándo usar `plainto_tsquery` vs `to_tsquery`                | 10  |
| Explica por qué un índice GIN acelera búsquedas FTS                   | 10  |

---

## Desempeño (40 pts)

| Criterio                                              | Pts |
|-------------------------------------------------------|-----|
| Ejercicio 01 completo y ejecuta sin errores           | 20  |
| Ejercicio 02 completo y ejecuta sin errores           | 20  |

---

## Producto (30 pts)

| Criterio                                              | Pts |
|-------------------------------------------------------|-----|
| Índice GIN creado y usado en la búsqueda              | 10  |
| Búsqueda con ranking `ts_rank()` funcional            | 10  |
| Resaltado con `ts_headline()` aplicado correctamente  |  5  |
| Comentarios en español                               |  5  |

---

## Aprobación

- Mínimo **70 pts** en total
- Mínimo **21 pts** por tipo de evidencia
- Queries ejecutables en PostgreSQL 16 sin modificaciones
