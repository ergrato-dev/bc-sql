# Glosario — Semana 12: CTEs y CASE WHEN

Términos SQL introducidos esta semana, ordenados alfabéticamente.

---

## C

**CASE WHEN**
Expresión condicional que evalúa condiciones en orden y retorna el primer
valor `THEN` verdadero, o `ELSE` si ninguna condición se cumple.

```sql
CASE WHEN condicion THEN valor ELSE default END
```

**CASE simple**
Forma de `CASE` que compara una sola columna contra varios valores
de igualdad. Equivalente a `switch/match` en lenguajes de programación.

**CTE (Common Table Expression)**
Resultado temporal con nombre definido antes de la consulta principal
usando la cláusula `WITH`. Existe solo durante la ejecución de la consulta.

**CTE en cascada**
Dos o más CTEs en una sola cláusula `WITH`, separados por coma. Un CTE
posterior puede referenciar a uno anterior para crear un pipeline de datos.

---

## E

**Expresión condicional**
Expresión que retorna valores distintos según el resultado de una o más
condiciones. En SQL, `CASE WHEN` es la expresión condicional estándar.

---

## P

**Pipeline de datos (SQL)**
Serie de CTEs encadenados donde cada paso transforma el resultado del
anterior, similar a un pipe `|` en Unix.

---

## T

**Tabla derivada**
Ver definición en semana 11. Un CTE reemplaza a la tabla derivada en `FROM`
con mayor legibilidad y posibilidad de reutilización.

---

## W

**WITH**
Cláusula SQL que precede a la consulta principal y define uno o más CTEs.
Se coloca antes del primer `SELECT`.

```sql
WITH nombre AS (SELECT ...) SELECT ... FROM nombre;
```
