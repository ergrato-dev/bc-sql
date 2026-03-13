<p align="center">
  <img src="_assets/bootcamp-header.svg" alt="SQL Bootcamp — Zero to Hero" width="860">
</p>

<p align="center">
  <a href="https://github.com/ergrato-dev/bc-sql/blob/main/LICENSE"><img src="https://img.shields.io/badge/license-MIT-blue.svg" alt="License MIT"></a>
  <a href="#"><img src="https://img.shields.io/badge/weeks-24-yellow.svg" alt="24 Weeks"></a>
  <a href="#"><img src="https://img.shields.io/badge/hours-192-orange.svg" alt="192 Hours"></a>
  <a href="#"><img src="https://img.shields.io/badge/PostgreSQL-16-336791?logo=postgresql&logoColor=white" alt="PostgreSQL 16"></a>
  <a href="CONTRIBUTING.md"><img src="https://img.shields.io/badge/PRs-Welcome-brightgreen?style=flat-square" alt="PRs Welcome"></a>
</p>

<p align="center">
  <a href="README.md"><img src="https://img.shields.io/badge/🇪🇸_Español-DC143C?style=for-the-badge&logoColor=white" alt="Versión en Español"></a>
</p>

---

## 📋 Description

Intensive **24-week (~6-month)** bootcamp designed to take students from zero to
SQL Developer Junior or Data Analyst Junior. The approach is 100% practical:
each week combines concise theory, guided exercises, and an integrative project
adapted to the student's assigned domain.

> 🏛️ **Unique Domain Policy (Anti-copying)**: Each student works on a unique
> business domain assigned by the instructor (Library, Pharmacy, Gym, etc.).
> This ensures original implementations and prevents copying between peers.

### 🎯 Objectives

Upon completing the bootcamp, students will be able to:

- ✅ Design and create normalized relational database schemas
- ✅ Write complex SQL queries with JOINs, subqueries, and CTEs
- ✅ Use window functions for advanced analysis
- ✅ Implement transactions and ensure data integrity (ACID)
- ✅ Optimize performance with indexes and execution plan analysis
- ✅ Create views, stored procedures, and triggers
- ✅ Work with advanced PostgreSQL types: JSONB, Full-Text Search
- ✅ Model data for real-world use cases (OLTP and OLAP)

### 🚀 Why SQL with PostgreSQL 16?

> **Standard SQL first, engine-specific features after** — the right order
> for learning relational databases.

This bootcamp uses SQLite for the fundamentals (zero configuration, full focus
on SQL) and migrates to PostgreSQL 16 via Docker for the advanced stage.
Students learn the same tools used by real data teams.

---

## 🗓️ Bootcamp Structure

| Stage | Weeks | Hours | Main Topics |
| :---: | :---: | :---: | --- |
| **Stage 0** — SQL Fundamentals | 1–8 | 64h | DDL, DML, SELECT, GROUP BY, NULL, Constraints |
| **Stage 1** — Intermediate SQL | 9–16 | 64h | JOINs, Subqueries, CTEs, Window Functions, Views, Indexes |
| **Stage 2** — Advanced SQL | 17–24 | 64h | ACID Transactions, Triggers, JSONB, FTS, EXPLAIN ANALYZE, Normalization |

**Total: 24 weeks** | **~192 hours** of intensive training

---

## 📚 Weekly Content

Each week includes:

```
bootcamp/week-XX/
├── README.md                 # Description and objectives
├── rubrica-evaluacion.md     # Evaluation criteria
├── 0-assets/                 # SVG diagrams (ER, flow, indexes)
├── 1-teoria/                 # Theoretical material in markdown
├── 2-practicas/              # Guided exercises (uncomment SQL)
│   └── ejercicio-XX/
│       ├── starter/          # setup.sql + commented ejercicio.sql
│       └── solution/         # setup.sql + solved ejercicio.sql
├── 3-proyecto/               # Weekly integrative project
│   └── starter/              # setup.sql + proyecto.sql with TODOs
├── 4-recursos/               # Additional resources
│   ├── ebooks-free/
│   ├── videografia/
│   └── webgrafia/
└── 5-glosario/               # Key SQL terms (A–Z)
```

### 🔑 Key Components

- 📖 **Theory**: Fundamental concepts with executable SQL examples
- 💻 **Practice**: Progressive exercises (uncomment and run)
- 📝 **Assessment**: Evidence of knowledge, performance, and product
- 🎓 **Resources**: Glossaries, free ebooks, and official references

---

## 🛠️ Tech Stack

| Technology | Version | Use |
| --- | --- | --- |
| SQLite | 3.x | Fundamentals (weeks 1–12, zero configuration) |
| PostgreSQL | 16 (Alpine) | Advanced (weeks 13–24, via Docker) |
| Docker | 24+ | Reproducible environment for PostgreSQL |
| Git | 2.30+ | Version control |
| VS Code | - | Recommended editor |

---

## 🚀 Quick Start

### Prerequisites

- **Git** to clone the repository
- **SQLite** (included in most systems, or DB Browser for SQLite)
- **Docker** for weeks 13–24 (PostgreSQL)
- **VS Code** with recommended extensions (`.vscode/extensions.json`)

### 1. Clone the Repository

```bash
git clone https://github.com/ergrato-dev/bc-sql.git
cd bc-sql
```

### 2. Weeks 1–12 — SQLite

No additional configuration required. Open any `.sql` file in
DB Browser for SQLite or run with the CLI:

```bash
sqlite3 my_db.db < bootcamp/week-01/2-practicas/ejercicio-01/starter/setup.sql
```

### 3. Weeks 13–24 — PostgreSQL 16 with Docker

```bash
# Start the PostgreSQL container
docker compose -f _scripts/docker-compose.yml up -d

# Verify it's running
docker compose -f _scripts/docker-compose.yml ps

# Connect with interactive psql
docker compose -f _scripts/docker-compose.yml exec postgres \
  psql -U bootcamp -d bootcamp_db

# Load a SQL file
docker compose -f _scripts/docker-compose.yml exec -T postgres \
  psql -U bootcamp -d bootcamp_db < bootcamp/week-13/2-practicas/ejercicio-01/starter/setup.sql

# Stop the container (preserves data)
docker compose -f _scripts/docker-compose.yml down
```

### 4. Navigate to Content

```bash
# Go to the first week
cd bootcamp/week-01

# Read instructions
cat README.md
```

---

## 📊 Learning Methodology

### Teaching Strategies

- 🎯 **Project-Based Learning (PBL)**
- 🧩 **Deliberate Practice** — exercises of incremental complexity
- 🔄 **Unique Domains** — each student works on their assigned domain
- 👥 **Peer Code Review**
- 🎮 **Live Coding** with real-time schema design

### Time Distribution (8h/week)

- **Theory**: 2–2.5 hours
- **Practice**: 3–3.5 hours
- **Project**: 2–2.5 hours

### Assessment

Each week includes three types of evidence:

1. **Knowledge 🧠** (30%): Quizzes and theoretical assessments
2. **Performance 💪** (40%): Practical exercises executed correctly
3. **Product 📦** (30%): Deliverable project adapted to the assigned domain

**Passing criteria**: Minimum 70% in each type of evidence

---

## 🤝 Contributing

Contributions are welcome! This is an open-source educational project.

### How to Contribute

1. Read the [Contributing Guide](CONTRIBUTING.md)
2. Review the [Code of Conduct](CODE_OF_CONDUCT.md)
3. Fork the repository
4. Create your branch (`git checkout -b feature/new-practice`)
5. Commit with [Conventional Commits](https://www.conventionalcommits.org/) (`git commit -m 'feat(week-05): add window functions exercise'`)
6. Push to your branch (`git push origin feature/new-practice`)
7. Open a Pull Request

### 📋 Contribution Areas

- ✨ Additional exercises
- 📚 Documentation improvements
- 🐛 SQL query bug fixes
- 🎨 SVG diagrams (ER, flow, indexes)
- 🌐 Translations
- 🐳 Docker environment improvements

---

## 📞 Support

- 💬 Discussions: [GitHub Discussions](https://github.com/ergrato-dev/bc-sql/discussions)
- 🐛 Issues: [GitHub Issues](https://github.com/ergrato-dev/bc-sql/issues)

---

## 📄 License

This project is under the MIT License — see the [LICENSE](LICENSE) file for
details.

---

## 🏆 Acknowledgments

- [PostgreSQL Global Development Group](https://www.postgresql.org/) — For the best open source database engine
- [SQLite](https://www.sqlite.org/) — For the most deployed database in the world
- [Use The Index, Luke](https://use-the-index-luke.com/) — For the best free guide to SQL indexes
- [Mode SQL Tutorial](https://mode.com/sql-tutorial/) — For high-quality tutorials
- All contributors

---

## 📚 Additional Documentation

- [🤖 Copilot Instructions](.github/copilot-instructions.md)
- [🤝 Contributing Guide](CONTRIBUTING.md)
- [📜 Code of Conduct](CODE_OF_CONDUCT.md)
- [🔒 Security Policy](SECURITY.md)
- [📖 General Documentation](_docs/)

---

<p align="center">
  <strong>🎓 SQL Bootcamp — Zero to Hero</strong><br>
  <em>From zero to SQL Developer Junior in ~6 months</em>
</p>

<p align="center">
  <a href="bootcamp/week-01">Start Week 1</a> •
  <a href="_docs">View Documentation</a> •
  <a href="https://github.com/ergrato-dev/bc-sql/issues">Report Issue</a> •
  <a href="CONTRIBUTING.md">Contribute</a>
</p>

<p align="center">
  Made with ❤️ for the data community
</p>
