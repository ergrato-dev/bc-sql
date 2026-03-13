# Glosario — Semana 14: Window Functions (Ranking)

Términos introducidos esta semana, ordenados A–Z.

---

## DENSE_RANK()

Función de ventana que asigna rangos compartiendo el número cuando hay empates, **sin saltar posiciones**.

```sql
-- Empate en posición 2: ambos obtienen 2, el siguiente obtiene 3
DENSE_RANK() OVER (ORDER BY salary DESC)
-- resultado con empate: 1, 2, 2, 3  (no salta a 4)
```

> Diferencia clave con RANK(): DENSE_RANK no deja huecos numéricos.

---

## OVER()

Cláusula que convierte una función de agregación o ranking en **función de ventana**. Define la partición y el orden sin colapsar filas.

```sql
ROW_NUMBER() OVER (PARTITION BY dept_id ORDER BY salary DESC)
```

---

## PARTITION BY

Cláusula dentro de `OVER()` que divide las filas en grupos independientes. La función de ventana se calcula por separado en cada partición.

```sql
-- La numeración reinicia en 1 para cada valor de dept_id
ROW_NUMBER() OVER (PARTITION BY dept_id ORDER BY salary DESC)
```

> Sin PARTITION BY: la función opera sobre todas las filas como una sola partición.

---

## RANK()

Función de ventana que asigna rangos compartiendo el número en empates, **saltando posiciones** subsiguientes.

```sql
RANK() OVER (ORDER BY salary DESC)
-- resultado con empate: 1, 2, 2, 4  (salta el 3)
```

---

## ROW_NUMBER()

Función de ventana que asigna un número secuencial **único e irrepetible** a cada fila dentro de su partición. Nunca produce empates.

```sql
ROW_NUMBER() OVER (PARTITION BY dept_id ORDER BY salary DESC)
-- resultado: siempre 1, 2, 3, 4... aunque haya empates en el valor
```

> Uso frecuente: deduplicar registros manteniendo el más reciente (WHERE rn = 1).

---

## Top-N por grupo

Patrón que combina CTE + función de window para obtener los N mejores registros por partición.

```sql
WITH ranked AS (
    SELECT *, DENSE_RANK() OVER (PARTITION BY dept_id ORDER BY salary DESC) AS dr
    FROM employees
)
SELECT * FROM ranked WHERE dr <= 3;
```

---

## Ventana (Window)

Conjunto de filas relacionadas con la fila actual según la definición en `OVER()`. A diferencia de GROUP BY, las filas originales no se colapsan.

---

## Window Function (Función de ventana)

Función SQL que opera sobre un conjunto de filas relacionadas y retorna un valor para **cada fila** sin agruparlas.

```sql
-- Funciones de ranking: ROW_NUMBER, RANK, DENSE_RANK
-- Funciones de navegación: LEAD, LAG, FIRST_VALUE, LAST_VALUE  (semana 15)
-- Funciones de agregado como ventana: SUM() OVER(), AVG() OVER()
```
