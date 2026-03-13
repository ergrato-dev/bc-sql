# Guía de Contribución

¡Gracias por tu interés en contribuir al Bootcamp SQL — De Cero a Héroe! 🎉

Este documento proporciona las directrices para contribuir al proyecto.

## 📋 Tabla de Contenidos

- [Código de Conducta](#código-de-conducta)
- [¿Cómo puedo contribuir?](#cómo-puedo-contribuir)
- [Configuración del entorno](#configuración-del-entorno)
- [Flujo de trabajo](#flujo-de-trabajo)
- [Guías de estilo SQL](#guías-de-estilo-sql)
- [Commits](#commits)
- [¿Preguntas?](#preguntas)

---

## Código de Conducta

Este proyecto se adhiere al [Código de Conducta](CODE_OF_CONDUCT.md). Al
participar, se espera que mantengas este código.

---

## ¿Cómo puedo contribuir?

### 🐛 Reportar Bugs en Queries SQL

Antes de crear un reporte, por favor:

1. **Verifica** si ya existe un issue similar
2. **Prueba** el query en PostgreSQL 16 o SQLite según corresponda
3. **Incluye** toda la información solicitada

**Información necesaria:**

- Descripción clara del problema
- El query SQL que falla
- Error exacto o comportamiento inesperado
- Motor de BD y versión (SQLite 3.x / PostgreSQL 16)
- Semana y archivo afectado

### ✨ Sugerir Mejoras

1. **Abre un issue** describiendo tu propuesta
2. **Explica** por qué sería útil para el aprendizaje
3. **Proporciona** ejemplos SQL cuando sea posible

### 📝 Mejorar Documentación

- Corregir errores tipográficos
- Clarificar explicaciones confusas
- Agregar ejemplos SQL adicionales
- Mejorar diagramas SVG
- Traducir contenido

### 💻 Contribuir Código SQL

#### Áreas de contribución:

1. **Ejercicios prácticos**
   - Nuevos ejercicios con starter + solution
   - Datos de prueba más representativos
   - Casos edge que los estudiantes necesitan ver

2. **Proyectos**
   - Mejoras al starter del proyecto semanal
   - Nuevos dominios de ejemplo genéricos

3. **Recursos**
   - eBooks gratuitos de SQL/bases de datos
   - Videos tutoriales en español
   - Referencias a documentación oficial

4. **Diagramas SVG**
   - Diagramas ER con notación crow's foot
   - Visualizaciones de índices, planes de ejecución
   - Tema dark: fondo `#1a1a2e`, tablas `#16213e`, bordes `#336791`

---

## Configuración del entorno

### 1. Fork y Clone

```bash
# Fork el repositorio en GitHub, luego:
git clone https://github.com/TU-USUARIO/bc-sql.git
cd bc-sql

# Agrega el repositorio original como upstream
git remote add upstream https://github.com/ergrato-dev/bc-sql.git
```

### 2. Configurar PostgreSQL (semanas 13–24)

```bash
# Levantar el contenedor
docker compose -f _scripts/docker-compose.yml up -d

# Verificar conexión
docker compose -f _scripts/docker-compose.yml exec postgres \
  psql -U bootcamp -d bootcamp_db -c "SELECT version();"
```

### 3. Probar tu Query

Asegúrate de que tu SQL se ejecuta sin errores antes de hacer PR:

```bash
# SQLite (semanas 1–12)
sqlite3 test.db < tu-archivo.sql

# PostgreSQL (semanas 13–24)
docker compose -f _scripts/docker-compose.yml exec -T postgres \
  psql -U bootcamp -d bootcamp_db < tu-archivo.sql
```

---

## Flujo de trabajo

### 1. Sincronizar con upstream

```bash
git checkout main
git fetch upstream
git merge upstream/main
```

### 2. Crear una rama

```bash
git checkout -b feat/week-05-new-exercise
git checkout -b fix/week-12-typo-in-cte-query
git checkout -b docs/improve-week-08-readme
```

### 3. Hacer cambios

- Escribe SQL limpio siguiendo las guías de estilo
- Prueba todos los queries antes de commitear
- Agrega comentarios educativos en español

### 4. Commit y Pull Request

```bash
git add .
git commit -m "feat(week-05): add GROUP BY edge case exercise"
git push origin feat/week-05-new-exercise
```

Luego abre un Pull Request con:

- Descripción clara de los cambios
- Semana y archivo afectado
- Captura del resultado del query (si aplica)

---

## Guías de estilo SQL

### ✅ Hacer

```sql
-- Keywords en UPPERCASE, identificadores en snake_case en inglés
-- Comentarios y explicaciones en español
SELECT
    e.employee_id,
    e.first_name,
    d.department_name,
    COUNT(p.project_id) AS total_projects
FROM employees e
INNER JOIN departments d ON e.department_id = d.id
LEFT JOIN projects p    ON e.employee_id = p.lead_id
WHERE e.hire_date >= '2020-01-01'
GROUP BY e.employee_id, e.first_name, d.department_name
HAVING COUNT(p.project_id) > 2
ORDER BY total_projects DESC;
```

### ❌ Evitar

```sql
-- keywords en minúsculas, nombres en camelCase o español
select employeeId, firstName from Employees where hireDate > '2020-01-01';

-- SELECT * en código de producción
SELECT * FROM employees;

-- Concatenación de strings para construir queries (SQL Injection)
-- 'SELECT * FROM users WHERE id = ' + userId
```

### Nomenclatura

| Elemento | Convención | Ejemplo |
| --- | --- | --- |
| Tablas | snake_case, plural | `order_items` |
| Columnas | snake_case, descriptivas | `created_at` |
| Claves primarias | `id` o `<tabla>_id` | `employee_id` |
| Claves foráneas | `<tabla_ref>_id` | `department_id` |
| Índices | `idx_<tabla>_<col>` | `idx_orders_status` |
| Vistas | `v_<nombre>` | `v_active_employees` |
| Funciones | `fn_<nombre>` | `fn_get_full_name` |
| Triggers | `trg_<nombre>` | `trg_audit_orders` |

---

## Commits

### Conventional Commits

Usamos [Conventional Commits](https://www.conventionalcommits.org/):

```
<tipo>(<alcance>): <descripción>
```

#### Tipos

- `feat`: Nuevo ejercicio, proyecto o feature
- `fix`: Corrección de error en un query SQL
- `docs`: Solo documentación
- `style`: Formateo SQL, espaciado
- `refactor`: Reestructuración sin cambio de comportamiento
- `chore`: Mantenimiento (scripts, dependencias)

#### Ejemplos

```bash
feat(week-09): add LEFT JOIN exercise with NULLs
fix(week-14): correct window function PARTITION BY syntax
docs(week-01): clarify PRIMARY KEY explanation
style(week-07): reformat GROUP BY queries
chore: update docker-compose to postgres:16.2-alpine
```

#### Alcance

- `week-01` … `week-24` para semanas específicas
- `docs` para documentación general
- `scripts` para herramientas y automatización
- `assets` para diagramas SVG

---

## Proceso de revisión

Tu PR será revisado buscando:

1. **SQL funcional**: Sin errores de sintaxis ni lógica
2. **Estilo**: Siguiendo las guías SQL
3. **Educativo**: Los comentarios explican el porqué, no solo el qué
4. **Probado**: Los queries corren en el motor correcto (SQLite/PostgreSQL)

---

## ¿Preguntas?

- 💬 [GitHub Discussions](https://github.com/ergrato-dev/bc-sql/discussions)
- 🐛 [GitHub Issues](https://github.com/ergrato-dev/bc-sql/issues)

---

## Reconocimiento

Todos los contribuidores serán reconocidos en el README principal.

¡Gracias por contribuir! 🎉

---

_Última actualización: Marzo 2026_
