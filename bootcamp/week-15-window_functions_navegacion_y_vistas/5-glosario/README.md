# Glosario — Semana 15: Window Functions Navegación y Vistas

Términos introducidos esta semana, ordenados A–Z.

---

## CREATE VIEW

Sentencia DDL que guarda una consulta SQL con un nombre. No almacena datos;
ejecuta la query subyacente cada vez que se consulta.

```sql
CREATE OR REPLACE VIEW v_dept_sales AS
SELECT department_id, SUM(amount) AS total
FROM monthly_sales
GROUP BY department_id;
```

---

## DROP VIEW

Elimina una vista del esquema. Los datos de las tablas base no se afectan.

```sql
DROP VIEW IF EXISTS v_dept_sales;
```

---

## FIRST_VALUE()

Función de ventana que devuelve el valor de la **primera fila** de la
partición según el ORDER BY definido en OVER.

```sql
FIRST_VALUE(amount) OVER (PARTITION BY dept_id ORDER BY amount DESC)
-- → el mayor monto de cada departamento en cada fila
```

---

## Frame clause

Define qué filas dentro de la partición forman la "ventana" de cálculo
para la fila actual.

```sql
ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW      -- defecto
ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING  -- toda la partición
```

> `LAST_VALUE` requiere el segundo frame para funcionar correctamente.

---

## LAG()

Función de ventana que accede al valor de la fila **anterior** dentro
de la partición.

```sql
LAG(amount, 1, 0) OVER (PARTITION BY dept_id ORDER BY sale_month)
-- offset=1 (fila anterior), default=0 (si no existe fila anterior)
```

---

## LAST_VALUE()

Función de ventana que devuelve el valor de la **última fila** de la
partición, pero requiere frame clause extendido para comportarse correctamente.

```sql
LAST_VALUE(amount) OVER (
    PARTITION BY dept_id ORDER BY amount DESC
    ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
)
-- → el mínimo de cada departamento en cada fila
```

---

## LEAD()

Función de ventana que accede al valor de la fila **siguiente** dentro
de la partición.

```sql
LEAD(amount, 1, NULL) OVER (ORDER BY sale_month)
-- → el monto del mes siguiente; NULL en la última fila
```

---

## Vista (View)

Objeto de base de datos que encapsula una consulta SQL con nombre.
Se usa como tabla en otros queries pero no almacena datos propios.

---

## WINDOW alias

Cláusula que define una ventana con nombre para reutilizarla en
múltiples funciones del mismo SELECT.

```sql
SELECT FIRST_VALUE(x) OVER w, LAST_VALUE(x) OVER w
FROM t
WINDOW w AS (PARTITION BY dept ORDER BY x DESC
             ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING);
```
