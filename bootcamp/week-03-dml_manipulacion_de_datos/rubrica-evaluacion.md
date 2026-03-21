# Rúbrica de Evaluación — Semana 03

## Distribución de Puntaje

| Tipo de Evidencia      | Peso | Puntaje máximo |
| ---------------------- | ---- | -------------- |
| Conocimiento 🧠        | 30%  | 30 pts         |
| Desempeño 💪           | 40%  | 40 pts         |
| Producto 📦            | 30%  | 30 pts         |
| **Total**              |      | **100 pts**    |

> Mínimo aprobatorio: **70 pts** en cada tipo de evidencia.

---

## Conocimiento 🧠 — 30 pts

| Criterio                                                                        | Puntaje |
| ------------------------------------------------------------------------------- | ------- |
| Explica la diferencia entre `INSERT` de fila única y múltiples filas            | 10 pts  |
| Describe qué ocurre si se hace `UPDATE` o `DELETE` sin `WHERE`                  | 10 pts  |
| Explica cuándo usar `DELETE` vs `DROP TABLE` vs `TRUNCATE` (en PostgreSQL)      | 10 pts  |

---

## Desempeño 💪 — 40 pts

| Criterio                                                                  | Puntaje |
| ------------------------------------------------------------------------- | ------- |
| Completa el ejercicio 01 insertando datos sin errores de constraints      | 20 pts  |
| Completa el ejercicio 02 actualizando y eliminando registros correctamente| 20 pts  |

---

## Producto 📦 — 30 pts

| Criterio                                                                          | Puntaje |
| --------------------------------------------------------------------------------- | ------- |
| `proyecto.sql` inserta al menos 5 registros en cada tabla del dominio             | 15 pts  |
| Los datos son realistas y coherentes con el dominio asignado                      | 10 pts  |
| Incluye al menos un `UPDATE` y un `DELETE` justificados con comentario            | 5 pts   |

---

## Notas

- Un `UPDATE` o `DELETE` sin `WHERE` que afecte todas las filas se penaliza.
- Los datos de prueba deben ser realistas, no `'dato1'`, `'test'`, etc.
