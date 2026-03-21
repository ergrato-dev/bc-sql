# Rúbrica de Evaluación — Semana 22: JSON y JSONB

## Distribución de puntaje

| Tipo | Porcentaje |
|------|-----------|
| Conocimiento 🧠 | 30% |
| Desempeño 💪 | 40% |
| Producto 📦 | 30% |

---

## Conocimiento 🧠 (30 pts)

| Criterio | Puntos |
|----------|--------|
| Explica la diferencia entre JSON y JSONB | 10 |
| Describe para qué sirve el operador `@>` | 10 |
| Explica cuándo usar `->` vs `->>` | 10 |

---

## Desempeño 💪 (40 pts)

| Criterio | Puntos |
|----------|--------|
| Ejercicio 01 completo (operadores de acceso) | 20 |
| Ejercicio 02 completo (GIN + modificación) | 20 |

---

## Producto 📦 (30 pts)

| Criterio | Puntos |
|----------|--------|
| Tabla con columna JSONB y datos representativos | 10 |
| Índice GIN creado y consulta con `@>` funcional | 10 |
| `jsonb_agg` o `jsonb_build_object` en consulta de reporte | 10 |

---

## Criterios de aprobación

- Mínimo 70% en cada tipo de evidencia
- Todas las queries deben ejecutar sin errores en PostgreSQL 16
- El proyecto debe estar adaptado al dominio asignado
