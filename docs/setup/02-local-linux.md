# Setup Local — Linux (Ubuntu / Debian / Fedora)

> Instala PostgreSQL 16 directamente en tu sistema sin contenedores.

## Ubuntu 22.04 / 24.04 y Debian

```bash
# Agregar el repositorio oficial de PostgreSQL
sudo apt install -y curl gnupg
curl -fsSL https://www.postgresql.org/media/keys/ACCC4CF8.asc \
  | sudo gpg --dearmor -o /usr/share/keyrings/pgdg.gpg

echo "deb [signed-by=/usr/share/keyrings/pgdg.gpg] \
  https://apt.postgresql.org/pub/repos/apt $(lsb_release -cs)-pgdg main" \
  | sudo tee /etc/apt/sources.list.d/pgdg.list

sudo apt update && sudo apt install -y postgresql-16
```

## Fedora / RHEL / Rocky Linux

```bash
sudo dnf install -y https://download.postgresql.org/pub/repos/yum/reporpms/EL-9-x86_64/pgdg-redhat-repo-latest.noarch.rpm
sudo dnf -qy module disable postgresql
sudo dnf install -y postgresql16-server
sudo /usr/pgsql-16/bin/postgresql-16-setup initdb
sudo systemctl enable --now postgresql-16
```

## Verificar instalación

```bash
psql --version   # debe mostrar: psql (PostgreSQL) 16.x
sudo systemctl status postgresql
```

## Crear usuario y base de datos del bootcamp

```bash
sudo -u postgres psql << 'EOF'
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

## Gestión del servicio

```bash
sudo systemctl start   postgresql   # iniciar
sudo systemctl stop    postgresql   # detener
sudo systemctl restart postgresql   # reiniciar
```

> Para un reset completo de los datos del bootcamp, conecta y ejecuta
> `DROP DATABASE bootcamp_db;` seguido de los pasos de creación anteriores.
