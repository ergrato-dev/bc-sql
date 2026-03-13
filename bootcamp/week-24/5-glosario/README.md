# Glosario — Semana 24: Proyecto Integrador Final

Términos consolidados del bootcamp completo, ordenados A–Z.

---

## A

**ACID** — Propiedades de las transacciones: Atomicidad, Consistencia,
Aislamiento y Durabilidad.

**audit_log** — Tabla que registra los cambios históricos sobre otras
tablas, generalmente poblada por triggers.

## B

**B-tree** — Estructura de árbol balanceado usada por defecto para
índices en PostgreSQL. Soporta igualdad y rangos.

**BIGSERIAL** — Tipo de dato entero de 64 bits con autoincremento.
Usar para identificadores en tablas de alto volumen.

## C

**CHECK** — Constraint que valida que los valores de una columna
satisfacen una condición booleana.

**CTE (Common Table Expression)** — Subconsulta con nombre definida
con `WITH` que mejora la legibilidad de queries complejos.

**covering index** — Índice que incluye todas las columnas necesarias
para resolver una query, evitando acceder al heap (Index Only Scan).

## D

**DENSE_RANK()** — Window function que asigna ranks consecutivos sin
saltos para valores empatados.

**DDL (Data Definition Language)** — Instrucciones que definen la
estructura: `CREATE`, `ALTER`, `DROP`.

**DML (Data Definition Language)** — Instrucciones que manipulan datos:
`INSERT`, `UPDATE`, `DELETE`.

## E

**EXPLAIN ANALYZE** — Comando que ejecuta la query y muestra el plan
de ejecución con tiempos reales. Fundamental para optimización.

## F

**FOREIGN KEY** — Restricción que garantiza que el valor de una columna
existe en la tabla referenciada.

**Full-Text Search (FTS)** — Búsqueda semántica sobre texto usando
`TSVECTOR`, `TSQUERY` y el operador `@@`.

**functional index** — Índice creado sobre una expresión o función
(`LOWER(name)`) en lugar de una columna directa.

## G

**GIN (Generalized Inverted Index)** — Tipo de índice optimizado para
JSONB y `TSVECTOR`. Permite búsquedas de contenido.

**GROUP BY** — Cláusula que agrupa filas para aplicar funciones de
agregación.

## I

**Index Only Scan** — Plan donde PostgreSQL resuelve la query leyendo
solo el índice, sin acceder al heap.

**Index Scan** — Plan donde PostgreSQL usa el índice para localizar
filas y luego accede al heap para obtener columnas adicionales.

## J

**JOIN** — Cláusula que combina filas de dos o más tablas según una
condición de coincidencia.

**JSONB** — Tipo de dato binario de PostgreSQL para documentos JSON.
Soporta indexación y operadores avanzados.

**jsonb_agg** — Función de agregación que construye un array JSONB
a partir de un conjunto de filas.

**jsonb_build_object** — Función que construye un objeto JSONB a partir
de pares clave-valor.

**jsonb_set** — Función que actualiza un campo específico dentro de un
documento JSONB.

## L

**LAG()** — Window function que retorna el valor de la fila anterior
dentro de la partición.

**LATERAL** — Modificador en `FROM` que permite que una subconsulta
haga referencia a columnas de tablas anteriores en el mismo `FROM`.

**LEAD()** — Window function que retorna el valor de la fila siguiente
dentro de la partición.

## N

**normalización** — Proceso de organizar tablas para minimizar
redundancia y garantizar integridad. 1FN → 2FN → 3FN → BCNF.

**NUMERIC(p, s)** — Tipo de dato de precisión fija para valores
monetarios. `NUMERIC(10,2)` = hasta 10 dígitos y 2 decimales.

## O

**OVER()** — Cláusula que define la ventana deslizante de una window
function. Puede incluir `PARTITION BY` y `ORDER BY`.

## P

**partial index** — Índice creado con cláusula `WHERE` para indexar
solo un subconjunto de filas. Reduce tamaño y mejora velocidad.

**plainto_tsquery** — Convierte texto libre a tsquery sin operadores
especiales. Ideal para búsquedas de usuarios finales.

**PRIMARY KEY** — Constraint que identifica de forma única cada fila.
Combina `NOT NULL` + `UNIQUE`.

## R

**RANK()** — Window function que asigna el mismo rank a empates pero
deja huecos en la secuencia siguiente.

**ROW_NUMBER()** — Window function que asigna un número entero único
y consecutivo a cada fila dentro de su partición.

## S

**Seq Scan** — Plan de acceso que lee la tabla completa fila por fila.
Eficiente cuando se necesita un gran porcentaje de las filas.

**SERIAL** — Tipo de dato entero de 32 bits con autoincremento.
Equivale a `INTEGER` + `DEFAULT nextval(...)`.

**setweight** — Función FTS que asigna importancia (A, B, C, D) a un
`TSVECTOR` para afectar el ranking de resultados.

## T

**TG_OP** — Variable especial en funciones de trigger que indica la
operación: `INSERT`, `UPDATE` o `DELETE`.

**TG_TABLE_NAME** — Variable especial en funciones de trigger con el
nombre de la tabla que disparó el trigger.

**transaction** — Unidad de trabajo atómica que agrupa múltiples
operaciones SQL. Garantiza que todas se aplican o ninguna.

**trigger** — Objeto de base de datos que ejecuta código automáticamente
ante un evento (`INSERT`, `UPDATE`, `DELETE`) en una tabla.

**ts_headline** — Función FTS que resalta los términos encontrados en
el texto original con marcadores configurables.

**ts_rank** — Función FTS que calcula la relevancia de un documento
respecto a una consulta. Usado para ordenar resultados.

**tsquery** — Tipo de dato que representa una consulta de texto para
FTS. Puede incluir operadores `&`, `|`, `!`, `<->`.

**tsvector** — Tipo de dato que representa un documento de texto
normalizado (lexemas + pesos) para Full-Text Search.

## U

**UNIQUE** — Constraint que impide valores duplicados en una columna
o combinación de columnas.

## V

**VACUUM ANALYZE** — Comando que libera espacio de filas muertas y
actualiza las estadísticas usadas por el planificador.

**vista (VIEW)** — Consulta almacenada con nombre que se comporta
como una tabla virtual.

## W

**window function** — Función que calcula un valor para cada fila
considerando un conjunto de filas relacionadas (la ventana).

**WITH** — Palabra clave que inicia una CTE (Common Table Expression).
Permite nombrar subconsultas y reutilizarlas.
