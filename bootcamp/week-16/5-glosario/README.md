# Glosario — Semana 16: Índices y Funciones Integradas

Términos introducidos esta semana, ordenados A–Z.

---

## AGE()

Función de fecha que devuelve el intervalo entre dos fechas o entre
una fecha y el timestamp actual.

```sql
AGE('2024-06-15'::DATE, '1990-03-01'::DATE)
-- → '34 years 3 mons 14 days'
EXTRACT(YEAR FROM AGE(CURRENT_DATE, hire_date))::INT
-- → número de años completos
```

---

## CAST / ::

Operadores para convertir un valor de un tipo de dato a otro.

```sql
CAST(salary AS INT)  -- sintaxis estándar SQL
salary::INT          -- sintaxis PostgreSQL (equivalente)
'2024-01-01'::DATE
```

---

## CEIL() / FLOOR()

Funciones numéricas que redondean hacia arriba o hacia abajo al entero
más cercano.

```sql
CEIL(3.1)   -- 4
FLOOR(3.9)  -- 3
```

---

## CREATE INDEX

Crea un índice en una o más columnas de una tabla para acelerar las
búsquedas con WHERE, JOIN y ORDER BY.

```sql
CREATE INDEX idx_employees_department_id
    ON employees (department_id);

CREATE UNIQUE INDEX idx_employees_email
    ON employees (email);
```

---

## DATE_TRUNC()

Trunca un timestamp al inicio del período indicado (mes, año, semana, día).

```sql
DATE_TRUNC('month', NOW())  -- primer día del mes actual, 00:00:00
DATE_TRUNC('year',  NOW())  -- primer día del año actual
```

---

## EXPLAIN / EXPLAIN ANALYZE

Muestra el plan de ejecución de una consulta. `ANALYZE` además la
ejecuta y muestra tiempos reales.

```sql
EXPLAIN        SELECT * FROM employees WHERE department_id = 2;
EXPLAIN ANALYZE SELECT * FROM employees WHERE department_id = 2;
```

> Busca "Index Scan" vs "Seq Scan" para verificar el uso del índice.

---

## EXTRACT()

Extrae un campo específico (año, mes, día, hora) de un valor de fecha o intervalo.

```sql
EXTRACT(YEAR  FROM hire_date)
EXTRACT(MONTH FROM NOW())
```

---

## Index Scan

Plan de ejecución que indica que PostgreSQL usó un índice para
localizar filas, en lugar de leer la tabla completa (Seq Scan).

---

## NULLIF()

Devuelve NULL si los dos argumentos son iguales; de lo contrario devuelve
el primer argumento. Útil para evitar división por cero.

```sql
NULLIF(divisor, 0)  -- NULL si divisor es 0, evita error
value / NULLIF(other_value, 0)
```

---

## ROUND()

Redondea un número al número de decimales indicado.

```sql
ROUND(3.456, 2)   -- 3.46
ROUND(salary, 0)  -- entero más cercano
```

---

## Seq Scan (Sequential Scan)

Plan de ejecución que indica que PostgreSQL leyó todas las filas de la
tabla sin usar índice. Normal en tablas pequeñas; ineficiente en tablas
grandes.

---

## TO_CHAR()

Convierte un valor de fecha o número a una cadena de texto con el
formato especificado.

```sql
TO_CHAR(hire_date, 'DD/MM/YYYY')   -- '15/03/2021'
TO_CHAR(salary,    'FM$999,999')   -- '$82,000'
```
