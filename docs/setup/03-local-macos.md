# Setup Local — macOS

> Dos opciones: Homebrew (recomendado) o Postgres.app (instalador gráfico).

## Opción A — Homebrew (recomendado)

```bash
# Instalar Homebrew si no lo tienes
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Instalar PostgreSQL 16
brew install postgresql@16

# Agregar al PATH (zsh)
echo 'export PATH="/opt/homebrew/opt/postgresql@16/bin:$PATH"' >> ~/.zshrc
source ~/.zshrc

# Iniciar el servicio
brew services start postgresql@16
```

Verificar:

```bash
psql --version   # psql (PostgreSQL) 16.x
```

## Opción B — Postgres.app (instalador gráfico)

1. Descarga desde [postgresapp.com](https://postgresapp.com/)
2. Arrastra a `/Applications`
3. Abre la app y haz clic en **Initialize**
4. Agrega el CLI al PATH según las instrucciones de la app

## Crear usuario y base de datos del bootcamp

```bash
psql postgres << 'EOF'
CREATE USER bootcamp WITH PASSWORD 'bootcamp123';
CREATE DATABASE bootcamp_db OWNER bootcamp
  ENCODING 'UTF8'
  LC_COLLATE 'en_US.UTF-8'
  LC_CTYPE 'en_US.UTF-8';
GRANT ALL PRIVILEGES ON DATABASE bootcamp_db TO bootcamp;
EOF
```

## Conectarse

```bash
psql -h localhost -U bootcamp -d bootcamp_db
```

## Ejecutar un archivo .sql

```bash
psql -h localhost -U bootcamp -d bootcamp_db \
  -f bootcamp/week-13-ctes_recursivas/2-practicas/ejercicio-01/starter/setup.sql
```

## Gestión del servicio (Homebrew)

```bash
brew services start   postgresql@16
brew services stop    postgresql@16
brew services restart postgresql@16
```

## Cliente gráfico recomendado en macOS

**TablePlus** — nativo para macOS, gratuito con límites razonables.
Descarga: [tableplus.com](https://tableplus.com/)

Conexión: `localhost:5432` · usuario `bootcamp` · db `bootcamp_db`
