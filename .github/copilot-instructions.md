# 🤖 Instrucciones para GitHub Copilot

## 📋 Contexto del Bootcamp

Este es un **Bootcamp de SQL de Cero a Héroe** estructurado para llevar a
estudiantes desde cero conocimiento de bases de datos relacionales hasta un
nivel de SQL Developer Junior o Data Analyst Junior.

### 📊 Datos del Bootcamp

- **Duración**: 24 semanas (~6 meses)
- **Dedicación semanal**: 8 horas
- **Total de horas**: ~192 horas
- **Nivel de entrada**: Cero (sin experiencia previa en bases de datos)
- **Nivel de salida**: SQL Developer Junior / Data Analyst Junior
- **Enfoque**: Progresión desde fundamentos absolutos hasta SQL avanzado y
  optimización de consultas
- **Motor principal**: SQLite (fundamentos) → PostgreSQL vía Docker (producción)

---

## 🎯 Objetivos de Aprendizaje

Al finalizar el bootcamp, los estudiantes serán capaces de:

- ✅ Diseñar y crear esquemas de base de datos relacionales normalizados
- ✅ Escribir consultas SQL complejas con JOINs, subqueries y CTEs
- ✅ Utilizar funciones de ventana (window functions) para análisis avanzado
- ✅ Implementar transacciones y garantizar la integridad de los datos (ACID)
- ✅ Optimizar el rendimiento con índices y análisis de planes de ejecución
- ✅ Crear vistas, procedimientos almacenados y funciones
- ✅ Manejar errores y edge cases en consultas reales
- ✅ Modelar datos para casos de uso del mundo real

---

## 📚 Estructura del Bootcamp

### Distribución por Etapas

#### **Etapa 0: Fundamentos de SQL (Semanas 1–8)** — 64 horas

- Qué es una base de datos relacional: tablas, filas, columnas, tipos de datos
- DDL: `CREATE TABLE`, `ALTER TABLE`, `DROP TABLE`, `TRUNCATE`
- DML: `INSERT INTO`, `UPDATE`, `DELETE`
- Consultas básicas: `SELECT`, `FROM`, `WHERE`, `ORDER BY`, `LIMIT`
- Operadores: comparación, lógicos (`AND`, `OR`, `NOT`), `BETWEEN`, `IN`, `LIKE`
- Funciones de agregación: `COUNT()`, `SUM()`, `AVG()`, `MIN()`, `MAX()`
- `GROUP BY` y `HAVING`
- Manejo de `NULL`: `IS NULL`, `IS NOT NULL`, `COALESCE()`, `NULLIF()`
- Constraints: `PRIMARY KEY`, `FOREIGN KEY`, `UNIQUE`, `NOT NULL`, `DEFAULT`, `CHECK`

#### **Etapa 1: SQL Intermedio (Semanas 9–16)** — 64 horas

- `JOIN`s: `INNER JOIN`, `LEFT JOIN`, `RIGHT JOIN`, `FULL OUTER JOIN`, `CROSS JOIN`
- `SELF JOIN` para relaciones jerárquicas
- Subqueries: correlacionadas, escalares, en `FROM`, en `WHERE`
- CTEs (`WITH`) y CTEs recursivas
- Funciones de ventana: `ROW_NUMBER()`, `RANK()`, `DENSE_RANK()`, `LEAD()`, `LAG()`, `FIRST_VALUE()`, `LAST_VALUE()`
- Vistas (`CREATE VIEW`) y vistas materializadas
- Índices: tipos, creación, cuándo usarlos
- Funciones de cadena, fecha/hora y numéricas
- `CASE WHEN` y expresiones condicionales

#### **Etapa 2: SQL Avanzado (Semanas 17–24)** — 64 horas

- Transacciones y propiedades ACID
- Control de concurrencia y niveles de aislamiento
- Procedimientos almacenados y funciones definidas por el usuario
- Triggers
- Optimización de consultas: `EXPLAIN`, `ANALYZE`, plan de ejecución
- Normalización: 1FN, 2FN, 3FN, BCNF, desnormalización estratégica
- Diseño de esquemas para casos reales: OLTP vs OLAP
- PostgreSQL: tipos avanzados (`JSONB`, arrays, `hstore`), extensiones, particionamiento

---

## 🗂️ Estructura de Carpetas

Cada semana sigue esta estructura estándar:

```
bootcamp/week-XX-tema_principal/
├── README.md                 # Descripción y objetivos de la semana
├── rubrica-evaluacion.md     # Criterios de evaluación detallados
├── 0-assets/                 # Diagramas SVG (ER, flujo, índices, etc.)
├── 1-teoria/                 # Material teórico (archivos .md)
├── 2-practicas/              # Ejercicios guiados paso a paso
│   └── ejercicio-XX/
│       ├── README.md         # Instrucciones y pasos
│       ├── starter/
│       │   ├── setup.sql     # Crea tablas e inserta datos de prueba
│       │   └── ejercicio.sql # Consultas comentadas para descomentar
│       └── solution/
│           ├── setup.sql
│           └── ejercicio.sql
├── 3-proyecto/               # Proyecto semanal integrador
│   ├── README.md
│   └── starter/
│       ├── setup.sql         # Esquema genérico adaptable al dominio
│       └── proyecto.sql      # TODOs para implementar
├── 4-recursos/               # Recursos adicionales
│   ├── ebooks-free/
│   ├── videografia/
│   └── webgrafia/
└── 5-glosario/               # Términos SQL clave (A–Z)
    └── README.md
```

### 📁 Carpetas Raíz

- **`_assets/`**: Recursos visuales globales (logos, headers, banners)
- **`_docs/`**: Documentación general del bootcamp
- **`_scripts/`**: Scripts de automatización y utilidades
- **`bootcamp/`**: Contenido semanal del bootcamp

### 🗂️ Orden de Creación de Cada Semana

Al desarrollar el contenido de una nueva semana, seguir **siempre** este orden:

1. `README.md` — Descripción general, objetivos, distribución del tiempo, navegación
2. `rubrica-evaluacion.md` — Tabla de criterios y puntajes
3. `1-teoria/` — Archivos markdown numerados (`01-`, `02-`, …)
4. `0-assets/` — Diagramas SVG vinculados a la teoría
5. `2-practicas/` — Ejercicios con `starter/` + `solution/`
6. `3-proyecto/` — Proyecto integrador semanal
7. `4-recursos/` — Ebooks gratuitos, videografía, webgrafía
8. `5-glosario/README.md` — Términos SQL de la semana ordenados A–Z

---

## 🎓 Componentes de Cada Semana

### 1. Teoría (1-teoria/)

- Archivos markdown con explicaciones conceptuales
- Ejemplos SQL completos y ejecutables
- Referencia a diagrama SVG al inicio (después de objetivos)
- Referencias a documentación oficial (PostgreSQL docs, SQLite docs)

#### 📏 Límites de Extensión (NON-NEGOTIABLE)

El público objetivo tiene déficit de atención. Textos extensos generan
abandono. Seguir el patrón del bootcamp JS hermano (`bc-javascript-es2023-cf`):

| Elemento           | Límite                                          |
| ------------------ | ----------------------------------------------- |
| Líneas por archivo | **Máximo 120**                                  |
| Objetivos          | 3–4 ítems                                       |
| Secciones          | 4–6 secciones numeradas (`## 1.`, `## 2.`...)   |
| Checklist          | **4 ítems** formulados como preguntas concretas |
| Referencias        | 2–3 links                                       |

**Qué NO incluir en teoría:**

- ❌ Tablas de comparación de más de 4 filas
- ❌ Tablas de resultados después de cada query de ejemplo
- ❌ Secciones de "Herramientas recomendadas" (van en `4-recursos/`)
- ❌ Notas de compatibilidad extensas (una línea `>` es suficiente)
- ❌ Más de 2 ejemplos de código por sección

### 2. Prácticas (2-practicas/)

Los ejercicios son **tutoriales guiados**, NO tareas con TODOs. El estudiante
aprende descomentando consultas SQL.

#### 📋 Formato de Ejercicios

**README.md del ejercicio:**

```markdown
### Paso 1: Nombre del Concepto

Explicación del concepto con ejemplo:

\`\`\`sql
-- Ejemplo explicativo
SELECT column_name
FROM table_name
WHERE condition;
\`\`\`

**Abre `starter/ejercicio.sql`** y descomenta la sección correspondiente.
```

**starter/ejercicio.sql:**

```sql
-- ============================================
-- PASO 1: Nombre del Concepto
-- ============================================

-- Explicación breve del concepto
-- Descomenta las siguientes líneas:

-- SELECT
--     e.id,
--     e.first_name
-- FROM employees e
-- WHERE e.department_id = 1;
```

**solution/ejercicio.sql:**

```sql
-- ============================================
-- PASO 1: Nombre del Concepto
-- ============================================

SELECT
    e.id,
    e.first_name
FROM employees e
WHERE e.department_id = 1;
```

#### ❌ NO usar este formato en ejercicios:

```sql
-- ❌ INCORRECTO — Este formato es para PROYECTOS, no ejercicios
SELECT * FROM employees; -- TODO: Agregar filtro por departamento
```

#### ✅ Usar este formato en ejercicios:

```sql
-- ✅ CORRECTO — Consulta comentada para descomentar
-- Descomenta las siguientes líneas:
-- SELECT *
-- FROM employees
-- WHERE department_id = 1;
```

### 3. Proyecto (3-proyecto/)

A diferencia de los ejercicios, el proyecto SÍ usa TODOs para que el
estudiante implemente desde cero.

**Las instrucciones de los proyectos deben ser genéricas y adaptables a
cualquier dominio.**

#### 🏛️ Política de Dominios Únicos (Anticopia)

**Cada aprendiz recibe un dominio único asignado por el instructor:**

- 📖 Biblioteca
- 💊 Farmacia
- 🏋️ Gimnasio
- 🏫 Escuela
- 🏬 Tienda de mascotas
- 🏪 Restaurante
- 🏦 Banco
- 🚕 Agencia de taxis
- 🏥 Hospital
- 🎥 Cine
- 🏨 Hotel
- ✈️ Agencia de viajes
- 🚗 Concesionario de autos
- 👗 Tienda de ropa
- 🛠️ Taller mecánico
- Y otros dominios únicos según cantidad de aprendices

**Objetivo**: Prevenir copia entre estudiantes y fomentar implementaciones
originales.

**⚠️ IMPORTANTE para desarrollo de contenidos:**

- Los ejemplos en los proyectos **NO deben usar dominios de la lista anterior**
- Usar ejemplos genéricos o dominios diferentes (ej: Museo, Planetario, Acuario)
- Esto evita "regalar" soluciones a aprendices con esos dominios asignados

#### 📋 Formato del starter del proyecto:

```sql
-- ============================================
-- PROYECTO SEMANAL: [Título Genérico]
-- Semana XX — [Tema]
-- ============================================

-- NOTA PARA EL APRENDIZ:
-- Adapta este esquema a tu dominio asignado.
-- Ejemplos:
--   Biblioteca  → books, members, loans
--   Farmacia    → medicines, sales, inventory
--   Gimnasio    → members, routines, attendance
--   Restaurante → dishes, tables, orders

-- TODO: Renombrar las tablas según tu dominio
-- TODO: Agregar columnas específicas de tu dominio

CREATE TABLE items (
    -- TODO: Definir las columnas de tu entidad principal
    id          INTEGER PRIMARY KEY,
    name        TEXT    NOT NULL
    -- TODO: Agregar columnas específicas
);

-- TODO: Implementar la consulta de reporte principal
-- Debe incluir: [requisito 1], [requisito 2], [requisito 3]
```

### 4. Recursos (4-recursos/)

- **ebooks-free/**: Libros gratuitos de SQL y bases de datos
- **videografia/**: Videos tutoriales recomendados
- **webgrafia/**: Documentación oficial, artículos y referencias

### 5. Glosario (5-glosario/)

- Términos SQL ordenados alfabéticamente
- Definiciones claras y concisas
- Ejemplos de código cuando aplique

---

## 📝 Convenciones de Código SQL

### Estilo SQL

```sql
-- ✅ BIEN — Keywords en UPPERCASE, identificadores en snake_case
SELECT
    e.employee_id,
    e.first_name,
    e.last_name,
    d.department_name,
    COUNT(p.project_id) AS total_projects
FROM employees e
INNER JOIN departments d ON e.department_id = d.id
LEFT JOIN projects p ON e.employee_id = p.lead_id
WHERE e.hire_date >= '2020-01-01'
  AND d.is_active = TRUE
GROUP BY e.employee_id, e.first_name, e.last_name, d.department_name
HAVING COUNT(p.project_id) > 2
ORDER BY total_projects DESC, e.last_name ASC
LIMIT 10;

-- ❌ MAL — keywords en minúsculas, nombres en camelCase o español
select employeeId, firstName from Employees where hireDate > '2020-01-01';
```

### Reglas de Nomenclatura

- **Tablas**: snake_case, plural (`employees`, `departments`, `order_items`)
- **Columnas**: snake_case, descriptivas (`first_name`, `created_at`, `is_active`)
- **Claves primarias**: `id` o `<tabla_singular>_id` (ej: `employee_id`)
- **Claves foráneas**: `<tabla_referenciada_singular>_id` (ej: `department_id`)
- **Índices**: `idx_<tabla>_<columna>` (ej: `idx_employees_department_id`)
- **Vistas**: `v_<nombre>` (ej: `v_active_employees`)
- **Procedimientos**: `sp_<nombre>` (ej: `sp_calculate_salary`)
- **Funciones**: `fn_<nombre>` (ej: `fn_get_full_name`)

### Tipos de Dato para PRIMARY KEY

#### ✅ Patrón estándar del bootcamp

| Etapa          | Semanas | Motor      | Tipo correcto                                                                                              |
| -------------- | ------- | ---------- | ---------------------------------------------------------------------------------------------------------- |
| Etapa 0        | 1–12    | SQLite     | `INTEGER PRIMARY KEY`                                                                                      |
| Etapa 1–2      | 13–23   | PostgreSQL | `SERIAL PRIMARY KEY`                                                                                       |
| Proyecto final | 24      | PostgreSQL | `SERIAL PRIMARY KEY` (tablas normales) / `BIGSERIAL PRIMARY KEY` (tablas de auditoría/log de alto volumen) |

```sql
-- ✅ SQLite (semanas 1–12)
-- INTEGER PRIMARY KEY es alias de rowid → autoincrement implícito
id  INTEGER  PRIMARY KEY

-- ✅ PostgreSQL (semanas 13–24)
-- SERIAL = INTEGER + secuencia automática
id  SERIAL   PRIMARY KEY

-- ✅ PostgreSQL — solo para tablas de alto volumen (audit_log, eventos)
id  BIGSERIAL  PRIMARY KEY

-- ❌ NUNCA en SQLite — AUTOINCREMENT es redundante y más lento
id  INTEGER PRIMARY KEY AUTOINCREMENT
```

#### UUID como PRIMARY KEY — cuándo sí, cuándo no

**✅ Usar UUID cuando:**

- Los IDs se exponen en URLs/APIs públicas (opacos, no revelan conteo)
- Sistema distribuido o multi-tenant donde los IDs se generan sin coordinación
- Merge de datos entre instancias independientes (sin colisión entre `id=1` de dos DBs)
- Sincronización offline (el cliente genera el ID antes de conectarse)

**❌ NO usar UUID como PK por defecto porque:**

- UUID v4 es aleatorio → inserciones en nodos aleatorios del B-tree → índice fragmentado (+30–50% tamaño)
- Comparar 128 bits vs 32/64 bits tiene costo en JOINs masivos
- Sin orden natural: `ORDER BY id` no da orden de inserción
- En SQLite no existe tipo nativo UUID (se almacena como `TEXT(36)`)

**En PostgreSQL 16 (el motor del bootcamp), si fuera necesario:**

```sql
-- Requiere extensión pgcrypto o la función nativa gen_random_uuid()
CREATE EXTENSION IF NOT EXISTS pgcrypto;

CREATE TABLE api_tokens (
    id          UUID    DEFAULT gen_random_uuid() PRIMARY KEY,
    user_id     INTEGER NOT NULL REFERENCES users(id),
    created_at  TIMESTAMPTZ DEFAULT NOW()
);
```

> ⚠️ **Regla para Copilot**: NO usar UUID como PK en ningún contenido del
> bootcamp (semanas 1–24). Mencionar UUID solo en teoría de semana 22
> (tipos avanzados) o en contexto de APIs. Siempre usar `INTEGER PRIMARY KEY`
> (SQLite) o `SERIAL`/`BIGSERIAL PRIMARY KEY` (PostgreSQL).

### Formato de Queries

- Keywords SQL siempre en **UPPERCASE**
- Identificadores (tablas, columnas) siempre en **snake_case** en **inglés**
- Comentarios y explicaciones siempre en **español**
- Indentación de 4 espacios
- Cada cláusula (`SELECT`, `FROM`, `WHERE`, etc.) en su propia línea
- Columnas multilínea alineadas
- Strings con comillas simples únicamente (`'value'`, nunca `"value"`)
- Longitud de línea máxima: 80 caracteres

---

## 🌐 Idioma y Nomenclatura

### ⚠️ REGLA CRÍTICA: Inglés Técnico + Español Educativo

**NOMENCLATURA TÉCNICA: SIEMPRE EN INGLÉS**

- ✅ Nombres de tablas, columnas, índices, vistas
- ✅ Nombres de procedimientos y funciones
- ✅ Aliases en queries
- ✅ Nombres de archivos (`.sql`, `.md`)

**COMENTARIOS Y DOCUMENTACIÓN: SIEMPRE EN ESPAÑOL**

- ✅ Comentarios SQL (`-- comentario`, `/* comentario */`)
- ✅ READMEs y documentación
- ✅ Mensajes de error y validación
- ✅ Explicaciones educativas

### Ejemplos Correctos

```sql
-- ✅ CORRECTO — Nomenclatura en inglés, comentarios en español
-- Obtener el salario promedio por departamento excluyendo directivos
SELECT
    d.department_name,
    ROUND(AVG(e.salary), 2) AS avg_salary
FROM departments d
INNER JOIN employees e ON d.id = e.department_id
WHERE e.job_title != 'Director'
GROUP BY d.department_name
ORDER BY avg_salary DESC;
```

---

## 🎨 Recursos Visuales y Estándares de Diseño

### Formato de Assets

- ✅ **Preferir SVG** para todos los diagramas (ER, flujo, índices, arquitectura)
- ❌ **NO usar ASCII art** para diagramas o visualizaciones
- ✅ Usar PNG/JPG solo para screenshots

### Tema Visual

- 🌙 **Tema dark** para todos los assets visuales
- ❌ **Sin degradés** (gradients) en diseños
- ✅ Colores sólidos y contrastes claros
- ✅ Paleta base: `#336791` (azul PostgreSQL) para SQL, `#003B57` (SQLite)
- Fondos: `#1a1a2e` y `#16213e`

### Tipografía

- ✅ **Fuentes sans-serif** exclusivamente
- ✅ Recomendadas: Inter, Roboto, Open Sans, System UI
- ❌ **NO usar fuentes serif**

---

## � Entorno PostgreSQL con Docker

Para las **semanas 13–24** (Etapa 2: SQL Avanzado) se usa **PostgreSQL vía
Docker** para garantizar:

- Versión idéntica en todos los entornos (`postgres:16-alpine`)
- Sin conflictos con PostgreSQL instalado en el sistema
- Reset fácil del entorno para repetir ejercicios desde cero
- Reproducibilidad en Linux, macOS y Windows

### Imagen recomendada

```
postgres:16-alpine
```

### docker-compose.yml

El archivo `_scripts/docker-compose.yml` incluye la configuración lista
para usar. Comandos principales:

```bash
# Levantar PostgreSQL en background
docker compose -f _scripts/docker-compose.yml up -d

# Conectar con psql interactivo
docker compose -f _scripts/docker-compose.yml exec postgres \
  psql -U bootcamp -d bootcamp_db

# Ejecutar un archivo .sql contra el contenedor
docker compose -f _scripts/docker-compose.yml exec -T postgres \
  psql -U bootcamp -d bootcamp_db < ruta/al/setup.sql

# Detener el contenedor (conserva datos)
docker compose -f _scripts/docker-compose.yml down

# Reset completo — elimina volumen de datos
docker compose -f _scripts/docker-compose.yml down -v
```

### Credenciales de desarrollo

| Variable            | Valor         |
| ------------------- | ------------- |
| `POSTGRES_USER`     | `bootcamp`    |
| `POSTGRES_PASSWORD` | `bootcamp123` |
| `POSTGRES_DB`       | `bootcamp_db` |
| Puerto host         | `5432`        |

> ⚠️ **Solo para entorno local de aprendizaje.** Nunca usar estas
> credenciales en producción.

### Instrucciones para Copilot

Al generar contenido para semanas 13–24:

- Incluir el comando de conexión Docker al inicio del README de cada
  ejercicio y proyecto
- Referenciar siempre `PostgreSQL 16` en menciones de versión
- Verificar que la sintaxis usada sea compatible con PostgreSQL 16
- Añadir bloque "Cómo ejecutar" en el README:

````markdown
## Cómo ejecutar

1. Asegúrate de tener Docker corriendo
2. Levanta el contenedor:
   ```bash
   docker compose -f _scripts/docker-compose.yml up -d
   ```
````

3. Carga el esquema de prueba:
   ```bash
   docker compose -f _scripts/docker-compose.yml exec -T postgres \
     psql -U bootcamp -d bootcamp_db < starter/setup.sql
   ```
4. Conecta e interactúa:
   ```bash
   docker compose -f _scripts/docker-compose.yml exec postgres \
     psql -U bootcamp -d bootcamp_db
   ```

```

---

## �🔐 Mejores Prácticas

### Seguridad en SQL

- **NUNCA** construir queries con concatenación de strings (prevención de SQL Injection)
- Usar **parámetros preparados** o **placeholders** cuando se integre con código
- No exponer información sensible en mensajes de error
- Usar principio de mínimo privilegio en permisos de base de datos
- Enmascarar o hashear datos sensibles (`password_hash`, no `password`)

### Calidad de Código SQL

- Evitar `SELECT *` en consultas de producción — siempre listar columnas explícitas
- Preferir `JOIN` explícito sobre comas implícitas en `FROM`
- Usar CTEs para mejorar legibilidad de queries complejos
- Documentar el propósito de cada query con comentarios
- Validar datos antes de insertar (`CHECK` constraints, triggers)

### Rendimiento

- Indexar columnas usadas frecuentemente en `WHERE`, `JOIN` y `ORDER BY`
- Evitar funciones sobre columnas indexadas en `WHERE` (rompe el índice)
- Usar `EXPLAIN ANALYZE` para detectar table scans innecesarios
- Limitar resultados con `LIMIT` cuando sea posible

---

## 📊 Evaluación

Cada semana incluye **tres tipos de evidencias**:

1. **Conocimiento 🧠** (30%): Evaluaciones teóricas, cuestionarios sobre SQL
2. **Desempeño 💪** (40%): Ejercicios prácticos ejecutados correctamente
3. **Producto 📦** (30%): Proyecto entregable funcional adaptado al dominio asignado

### Criterios de Aprobación

- Mínimo **70%** en cada tipo de evidencia
- Entrega puntual de proyectos
- Queries funcionales y bien documentadas
- **Implementación coherente con el dominio asignado**
- **Originalidad**: Sin copia de implementaciones de otros aprendices

---

## 🚀 Metodología de Aprendizaje

### Estrategias Didácticas

- **Aprendizaje Basado en Proyectos (ABP)**: Proyectos semanales que modelan
  casos reales
- **Dominios Únicos**: Cada aprendiz aplica conceptos a su dominio asignado
- **Práctica Deliberada**: Ejercicios de complejidad incremental
- **Coding Challenges**: Problemas tipo entrevista técnica en semanas avanzadas
- **Code Review**: Revisión de queries entre estudiantes
- **Live Coding**: Sesiones en vivo con diseño de esquemas en tiempo real

### Distribución del Tiempo (8h/semana)

- **Teoría**: 2–2.5 horas
- **Prácticas**: 3–3.5 horas
- **Proyecto**: 2–2.5 horas

---

## 🤖 Instrucciones para Copilot

### Límites de Respuesta

1. **Divide respuestas largas**
   - ❌ **NUNCA generar respuestas que superen los límites de tokens**
   - ✅ **SIEMPRE dividir contenido extenso en múltiples entregas**
   - ✅ Crear contenido por secciones, esperar confirmación del usuario
   - Para semanas completas: dividir por carpetas (`teoria → practicas → proyecto`)

### Generación de Código SQL

1. **Usa siempre el estilo definido**
   - Keywords en UPPERCASE
   - Identificadores en snake_case en inglés
   - Comentarios en español
   - Una cláusula por línea

2. **Motor de BD principal**
   - ✅ **SQLite** para semanas 1–12 (fundamentos e intermedio)
   - ✅ **PostgreSQL 16 vía Docker** para semanas 13–24 (avanzado y producción)
   - Indicar claramente si una feature es específica de SQLite o PostgreSQL
   - Para semanas 13+: incluir siempre el comando de conexión Docker en el README
   - Ver sección [🐳 Entorno PostgreSQL con Docker](#-entorno-postgresql-con-docker)

3. **Scripts SQL estructurados**
   - Incluir siempre un `setup.sql` con datos de prueba representativos
   - Comenzar con `-- Semana XX: Tema` en el encabezado de cada archivo
   - Usar `-- ============================================` como separador

### Creación de Contenido

1. **Estructura clara y progresiva**
   - De lo simple a lo complejo
   - Conceptos construidos sobre conocimientos previos
   - Repetición espaciada de conceptos clave (ej: JOIN aparece en múltiples semanas)

2. **Ejemplos del mundo real**
   - Casos de uso que un analista o desarrollador encontrará en el trabajo
   - Datos de prueba realistas (no `foo`, `bar`, `test1`)
   - Errores comunes que los estudiantes cometerán (y cómo evitarlos)

3. **Compatibilidad**
   - Indicar explícitamente cuando una sintaxis es solo PostgreSQL vs estándar SQL
   - Proveer alternativas SQLite cuando el ejercicio use features de PG en etapa 0

### Diagramas ER (assets SVG)

- Usar notación de pata de gallo (crow's foot) para relaciones
- Incluir cardinalidad en las relaciones
- Tema dark: fondo `#1a1a2e`, tablas `#16213e`, bordes `#336791`
- Mostrar solo las tablas relevantes al tema de la semana

---

## 📚 Referencias Oficiales

- **PostgreSQL Docs**: https://www.postgresql.org/docs/
- **SQLite Docs**: https://www.sqlite.org/docs.html
- **SQL Tutorial** (W3Schools): https://www.w3schools.com/sql/
- **Mode SQL Tutorial**: https://mode.com/sql-tutorial/
- **Use The Index, Luke**: https://use-the-index-luke.com/
- **DB Fiddle** (sandbox): https://www.db-fiddle.com/

---

## 🔗 Enlaces Importantes

- **Repositorio**: https://github.com/ergrato-dev/bc-sql
- **Documentación general**: [\_docs/README.md](_docs/README.md)
- **Primera semana**: [bootcamp/week-01-introduccion_bases_de_datos_relacionales/README.md](bootcamp/week-01-introduccion_bases_de_datos_relacionales/README.md)

---

## ✅ Checklist para Nuevas Semanas

Cuando crees contenido para una nueva semana:

- [ ] Crear estructura de carpetas completa
- [ ] `README.md` con objetivos, estructura y navegación
- [ ] Material teórico en `1-teoria/`
- [ ] Diagrama SVG en `0-assets/` (mínimo 1 por semana)
- [ ] Ejercicios prácticos en `2-practicas/` (mínimo 2 ejercicios)
- [ ] Proyecto integrador en `3-proyecto/`
- [ ] `setup.sql` con datos de prueba en ejercicios y proyecto
- [ ] Recursos adicionales en `4-recursos/`
- [ ] Glosario de términos en `5-glosario/`
- [ ] Rúbrica de evaluación
- [ ] Verificar coherencia con semanas anteriores
- [ ] Revisar progresión de dificultad
- [ ] Probar que todos los `.sql` son ejecutables
- [ ] **Semanas 13–24**: verificar bloque "Cómo ejecutar" con Docker en README
- [ ] **Semanas 13–24**: confirmar compatibilidad de sintaxis con PostgreSQL 16

---

## 💡 Notas Finales

- **Prioridad**: Claridad sobre brevedad
- **Enfoque**: SQL práctico sobre teoría abstracta
- **Objetivo**: Preparar analistas y developers listos para trabajar con datos reales
- **Filosofía**: SQL estándar primero, features específicas de motor después

---

_Última actualización: Marzo 2026_
_Versión: 1.0_
```
