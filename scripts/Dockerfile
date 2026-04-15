# ──────────────────────────────────────────────────────────────────
# Dockerfile — PostgreSQL 16 para bc-sql Bootcamp
# ──────────────────────────────────────────────────────────────────
# Extiende la imagen oficial con:
#   - Habilitación automática de extensiones (pgcrypto, pg_stat_statements)
#   - Configuración de locale UTF-8
#   - Scripts de inicialización copiados a /docker-entrypoint-initdb.d/
#
# Uso:
#   docker build -t bc-sql-postgres ./scripts
#   docker compose -f scripts/docker-compose.yml up -d --build
# ──────────────────────────────────────────────────────────────────
# REGLA DE ORO: FROM siempre con digest SHA256 exacto (nunca tag flotante)
# ──────────────────────────────────────────────────────────────────

FROM postgres:16-alpine@sha256:20edbde7749f822887a1a022ad526fde0a47d6b2be9a8364433605cf65099416

LABEL maintainer="ergrato-dev"
LABEL description="PostgreSQL 16 configurado para el Bootcamp bc-sql (semanas 13-24)"
LABEL version="16.13"

# Variables de entorno con valores por defecto (sobrescribibles en compose)
ENV POSTGRES_USER=bootcamp
ENV POSTGRES_PASSWORD=bootcamp123
ENV POSTGRES_DB=bootcamp_db
ENV POSTGRES_INITDB_ARGS="--encoding=UTF8 --locale=en_US.UTF-8"

# Copiar scripts de inicialización SQL
# Postgres los ejecuta en orden alfabético en el primer arranque
COPY init/ /docker-entrypoint-initdb.d/

# Copiar configuración personalizada de PostgreSQL
COPY postgresql.conf /etc/postgresql/postgresql.conf

# Puerto estándar de PostgreSQL
EXPOSE 5432

# Usar nuestra configuración personalizada al arrancar
CMD ["postgres", "-c", "config_file=/etc/postgresql/postgresql.conf"]
