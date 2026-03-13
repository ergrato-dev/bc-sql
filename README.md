<p align="center">
  <img src="_assets/bootcamp-header.svg" alt="Bootcamp SQL — De Cero a Héroe" width="860">
</p>

<p align="center">
  <a href="https://github.com/ergrato-dev/bc-sql/blob/main/LICENSE"><img src="https://img.shields.io/badge/license-MIT-blue.svg" alt="License MIT"></a>
  <a href="#"><img src="https://img.shields.io/badge/semanas-24-yellow.svg" alt="24 Semanas"></a>
  <a href="#"><img src="https://img.shields.io/badge/horas-192-orange.svg" alt="192 Horas"></a>
  <a href="#"><img src="https://img.shields.io/badge/PostgreSQL-16-336791?logo=postgresql&logoColor=white" alt="PostgreSQL 16"></a>
  <a href="CONTRIBUTING.md"><img src="https://img.shields.io/badge/PRs-Welcome-brightgreen?style=flat-square" alt="PRs Welcome"></a>
</p>

<p align="center">
  <a href="README_EN.md"><img src="https://img.shields.io/badge/🇺🇸_English-0969DA?style=for-the-badge&logoColor=white" alt="English Version"></a>
</p>

---

## 📋 Descripción

Bootcamp intensivo de **24 semanas (~6 meses)** diseñado para llevar a
estudiantes desde cero hasta SQL Developer Junior o Data Analyst Junior. El
enfoque es 100% práctico: cada semana combina teoría concisa, ejercicios
guiados y un proyecto integrador adaptado al dominio asignado.

> 🏛️ **Política de Dominios Únicos (Anticopia)**: Cada aprendiz trabaja sobre
> un dominio de negocio único asignado por el instructor (Biblioteca, Farmacia,
> Gimnasio, etc.). Esto garantiza implementaciones originales y previene la
> copia entre compañeros.

### 🎯 Objetivos

Al finalizar el bootcamp, los estudiantes serán capaces de:

- ✅ Diseñar y crear esquemas de base de datos relacionales normalizados
- ✅ Escribir consultas SQL complejas con JOINs, subqueries y CTEs
- ✅ Utilizar funciones de ventana (window functions) para análisis avanzado
- ✅ Implementar transacciones y garantizar la integridad de los datos (ACID)
- ✅ Optimizar el rendimiento con índices y análisis de planes de ejecución
- ✅ Crear vistas, procedimientos almacenados y triggers
- ✅ Trabajar con tipos avanzados de PostgreSQL: JSONB, Full-Text Search
- ✅ Modelar datos para casos de uso reales (OLTP y OLAP)

### 🚀 ¿Por qué SQL con PostgreSQL 16?

> **SQL estándar primero, features específicas después** — el orden correcto
> para aprender bases de datos relacionales.

Este bootcamp usa SQLite para los fundamentos (cero configuración, enfoque
total en SQL) y migra a PostgreSQL 16 vía Docker para la etapa avanzada. Los
estudiantes aprenden las mismas herramientas que usan equipos de datos reales.

---

## 🗓️ Estructura del Bootcamp

| Etapa | Semanas | Horas | Temas Principales |
| :---: | :-----: | :---: | --- |
| **Etapa 0** — Fundamentos de SQL | 1–8 | 64h | DDL, DML, SELECT, GROUP BY, NULL, Constraints |
| **Etapa 1** — SQL Intermedio | 9–16 | 64h | JOINs, Subqueries, CTEs, Window Functions, Vistas, Índices |
| **Etapa 2** — SQL Avanzado | 17–24 | 64h | Transacciones ACID, Triggers, JSONB, FTS, EXPLAIN ANALYZE, Normalización |

**Total: 24 semanas** | **~192 horas** de formación intensiva

---

## 📚 Contenido por Semana

Cada semana incluye:

```
bootcamp/week-XX/
├── README.md                 # Descripción y objetivos
├── rubrica-evaluacion.md     # Criterios de evaluación
├── 0-assets/                 # Diagramas SVG (ER, flujo, índices)
├── 1-teoria/                 # Material teórico en markdown
├── 2-practicas/              # Ejercicios guiados (descomentar SQL)
│   └── ejercicio-XX/
│       ├── starter/          # setup.sql + ejercicio.sql comentado
│       └── solution/         # setup.sql + ejercicio.sql resuelto
├── 3-proyecto/               # Proyecto semanal integrador
│   └── starter/              # setup.sql + proyecto.sql con TODOs
├── 4-recursos/               # Recursos adicionales
│   ├── ebooks-free/
│   ├── videografia/
│   └── webgrafia/
└── 5-glosario/               # Términos SQL clave (A–Z)
```

### 🔑 Componentes Clave

- 📖 **Teoría**: Conceptos fundamentales con ejemplos SQL ejecutables
- 💻 **Práctica**: Ejercicios progresivos (descomenta y ejecuta)
- 📝 **Evaluación**: Evidencias de conocimiento, desempeño y producto
- 🎓 **Recursos**: Glosarios, ebooks gratuitos y referencias oficiales

---

## 🛠️ Stack Tecnológico

| Tecnología | Versión | Uso |
| --- | --- | --- |
| SQLite | 3.x | Fundamentos (semanas 1–12, sin configuración) |
| PostgreSQL | 16 (Alpine) | Avanzado (semanas 13–24, vía Docker) |
| Docker | 24+ | Entorno reproducible para PostgreSQL |
| Git | 2.30+ | Control de versiones |
| VS Code | - | Editor recomendado |

---

## 🚀 Inicio Rápido

### Prerrequisitos

- **Git** para clonar el repositorio
- **SQLite** (incluido en la mayoría de sistemas, o DB Browser for SQLite)
- **Docker** para las semanas 13–24 (PostgreSQL)
- **VS Code** con las extensiones recomendadas (`.vscode/extensions.json`)

### 1. Clonar el Repositorio

```bash
git clone https://github.com/ergrato-dev/bc-sql.git
cd bc-sql
```

### 2. Semanas 1–12 — SQLite

No requiere configuración adicional. Abre cualquier archivo `.sql` en
DB Browser for SQLite o ejecuta con la CLI:

```bash
sqlite3 mi_base.db < bootcamp/week-01/2-practicas/ejercicio-01/starter/setup.sql
```

### 3. Semanas 13–24 — PostgreSQL 16 con Docker

```bash
# Levantar el contenedor de PostgreSQL
docker compose -f _scripts/docker-compose.yml up -d

# Verificar que está corriendo
docker compose -f _scripts/docker-compose.yml ps

# Conectar con psql interactivo
docker compose -f _scripts/docker-compose.yml exec postgres \
  psql -U bootcamp -d bootcamp_db

# Cargar un archivo SQL
docker compose -f _scripts/docker-compose.yml exec -T postgres \
  psql -U bootcamp -d bootcamp_db < bootcamp/week-13/2-practicas/ejercicio-01/starter/setup.sql

# Detener el contenedor (conserva datos)
docker compose -f _scripts/docker-compose.yml down
```

### 4. Navegar al Contenido

```bash
# Ir a la primera semana
cd bootcamp/week-01

# Ver instrucciones
cat README.md
```

---

## 📊 Metodología de Aprendizaje

### Estrategias Didácticas

- 🎯 **Aprendizaje Basado en Proyectos (ABP)**
- 🧩 **Práctica Deliberada** — ejercicios de complejidad incremental
- 🔄 **Dominios Únicos** — cada aprendiz trabaja en su dominio asignado
- 👥 **Code Review** entre pares
- 🎮 **Live Coding** con diseño de esquemas en tiempo real

### Distribución del Tiempo (8h/semana)

- **Teoría**: 2–2.5 horas
- **Prácticas**: 3–3.5 horas
- **Proyecto**: 2–2.5 horas

### Evaluación

Cada semana incluye tres tipos de evidencias:

1. **Conocimiento 🧠** (30%): Cuestionarios y evaluaciones teóricas
2. **Desempeño 💪** (40%): Ejercicios prácticos ejecutados correctamente
3. **Producto 📦** (30%): Proyecto entregable adaptado al dominio asignado

**Criterio de aprobación**: Mínimo 70% en cada tipo de evidencia

---

## 🤝 Contribuir

¡Las contribuciones son bienvenidas! Este es un proyecto educativo de código
abierto.

### Cómo Contribuir

1. Lee la [Guía de Contribución](CONTRIBUTING.md)
2. Revisa el [Código de Conducta](CODE_OF_CONDUCT.md)
3. Haz fork del repositorio
4. Crea tu rama (`git checkout -b feature/nueva-practica`)
5. Commit con [Conventional Commits](https://www.conventionalcommits.org/) (`git commit -m 'feat(week-05): add window functions exercise'`)
6. Push a tu rama (`git push origin feature/nueva-practica`)
7. Abre un Pull Request

### 📋 Áreas de Contribución

- ✨ Ejercicios adicionales
- 📚 Mejoras en documentación
- 🐛 Corrección de errores en queries SQL
- 🎨 Diagramas SVG (ER, flujo, índices)
- 🌐 Traducciones
- 🐳 Mejoras al entorno Docker

---

## 📞 Soporte

- 💬 Discussions: [GitHub Discussions](https://github.com/ergrato-dev/bc-sql/discussions)
- 🐛 Issues: [GitHub Issues](https://github.com/ergrato-dev/bc-sql/issues)

---

## 📄 Licencia

Este proyecto está bajo la Licencia MIT — ver el archivo [LICENSE](LICENSE)
para más detalles.

---

## 🏆 Agradecimientos

- [PostgreSQL Global Development Group](https://www.postgresql.org/) — Por el mejor motor de base de datos open source
- [SQLite](https://www.sqlite.org/) — Por la base de datos más desplegada del mundo
- [Use The Index, Luke](https://use-the-index-luke.com/) — Por la mejor guía gratuita de índices SQL
- [Mode SQL Tutorial](https://mode.com/sql-tutorial/) — Por tutoriales de alta calidad
- Todos los contribuidores

---

## 📚 Documentación Adicional

- [🤖 Instrucciones de Copilot](.github/copilot-instructions.md)
- [🤝 Guía de Contribución](CONTRIBUTING.md)
- [📜 Código de Conducta](CODE_OF_CONDUCT.md)
- [🔒 Política de Seguridad](SECURITY.md)
- [📖 Documentación General](_docs/)

---

<p align="center">
  <strong>🎓 Bootcamp SQL — De Cero a Héroe</strong><br>
  <em>De cero a SQL Developer Junior en ~6 meses</em>
</p>

<p align="center">
  <a href="bootcamp/week-01">Comenzar Semana 1</a> •
  <a href="_docs">Ver Documentación</a> •
  <a href="https://github.com/ergrato-dev/bc-sql/issues">Reportar Issue</a> •
  <a href="CONTRIBUTING.md">Contribuir</a>
</p>

<p align="center">
  Hecho con ❤️ para la comunidad de datos
</p>
