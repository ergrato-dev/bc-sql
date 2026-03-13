# Rúbrica de Evaluación — Semana 11: Subqueries

## Tabla de criterios

### Conocimiento 🧠 (30%)

| Criterio | Excelente (100%) | Satisfactorio (70%) | Insuficiente (<70%) |
|----------|-----------------|---------------------|---------------------|
| Subquery escalar | Define correctamente y explica dónde usarla | Sabe que retorna un valor pero no ubica su contexto | No distingue de subquery de conjunto |
| IN vs EXISTS | Explica la diferencia y cuándo cada uno es preferible | Los usa pero no distingue su comportamiento | Confunde ambos operadores |
| Tabla derivada | Explica por qué se necesita alias en subquery de FROM | Escribe la sintaxis pero no explica el alias | No sabe poner alias a la subquery |
| Correlación | Explica que la subquery usa columnas de la consulta externa | Intuye la dependencia pero no la explica | No distingue correlacionada de no correlacionada |

### Desempeño 💪 (40%)

| Criterio | Excelente (100%) | Satisfactorio (70%) | Insuficiente (<70%) |
|----------|-----------------|---------------------|---------------------|
| Subquery escalar funcional | Compara contra AVG/MAX/MIN correctamente | Tiene la subquery pero falla el WHERE | No ejecuta el query |
| IN/NOT IN correcto | Filtra con lista de IDs de subquery sin error | Usa IN pero con una columna incorrecta | No logra el filtro |
| EXISTS funcional | Correlaciona correctamente con tabla exterior | Escribe EXISTS pero olvida la correlación | No logra el EXISTS |
| Tabla derivada con alias | Usa la subquery en FROM con alias y columnas correctas | Tiene la subquery pero sin alias | No logra anidar en FROM |

### Producto 📦 (30%)

| Criterio | Excelente (100%) | Satisfactorio (70%) | Insuficiente (<70%) |
|----------|-----------------|---------------------|---------------------|
| Subqueries funcionales | Las 4 consultas del proyecto ejecutan sin error | 3 de 4 ejecutan | Menos de 3 ejecutan |
| Dominio adaptado | Tablas y columnas coherentes con el dominio asignado | Nombres genéricos del starter | No adapta el esquema |
| Legibilidad | Indentación coherente, subquery visible como bloque | Subquery en una sola línea pero funcional | Código sin estructura |
| Comentarios | Explica qué retorna cada subquery | Comenta parcialmente | Sin comentarios |

## Puntaje total

| Tipo | Peso | Mínimo para aprobar |
|------|------|---------------------|
| Conocimiento 🧠 | 30% | 70% |
| Desempeño 💪   | 40% | 70% |
| Producto 📦    | 30% | 70% |
