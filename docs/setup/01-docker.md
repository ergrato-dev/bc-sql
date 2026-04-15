# Setup con Docker — Opción oficial del bootcamp

> **Requisitos**: Docker Desktop (Windows/macOS) o Docker Engine (Linux)
> instalado y corriendo.

## 1. Instalar Docker

- **Windows / macOS**: descarga [Docker Desktop](https://www.docker.com/products/docker-desktop/)
- **Linux (Ubuntu/Debian)**:
  ```bash
  curl -fsSL https://get.docker.com | sh
  sudo usermod -aG docker $USER   # reinicia sesión después
  ```

## 2. Levantar el contenedor

Desde la raíz del repositorio:

```bash
docker compose -f scripts/docker-compose.yml up -d
```

Verifica que el contenedor está saludable:

```bash
docker compose -f scripts/docker-compose.yml ps
```

Debes ver `STATUS: healthy`.

## 3. Conectarse a PostgreSQL

```bash
docker compose -f scripts/docker-compose.yml exec postgres \
  psql -U bootcamp -d bootcamp_db
```

Para salir del cliente: `\q`

## 4. Ejecutar un archivo .sql

```bash
docker compose -f scripts/docker-compose.yml exec -T postgres \
  psql -U bootcamp -d bootcamp_db < ruta/al/archivo.sql
```

Ejemplo para cargar el setup de la semana 13:

```bash
docker compose -f scripts/docker-compose.yml exec -T postgres \
  psql -U bootcamp -d bootcamp_db \
  < bootcamp/week-13-ctes_recursivas/2-practicas/ejercicio-01/starter/setup.sql
```

## 5. Conectar desde un cliente gráfico

| Campo | Valor |
|---|---|
| Host | `localhost` |
| Puerto | `5432` |
| Usuario | `bootcamp` |
| Contraseña | `bootcamp123` |
| Base de datos | `bootcamp_db` |

Compatible con: **DBeaver**, **TablePlus**, **DataGrip**, **pgAdmin**.

## 6. Gestión del contenedor

```bash
# Detener (conserva los datos)
docker compose -f scripts/docker-compose.yml down

# Reset completo — elimina todos los datos
docker compose -f scripts/docker-compose.yml down -v

# Ver logs en tiempo real
docker compose -f scripts/docker-compose.yml logs -f postgres
```

## Scripts de conveniencia

El repositorio incluye scripts en `scripts/`:

```bash
./scripts/pause.sh    # detiene el contenedor
./scripts/resume.sh   # lo reanuda
./scripts/restore.sh  # reset completo + levanta de nuevo
```

## Imagen utilizada

```
postgres:16-alpine@sha256:20edbde7749f822887a1a022ad526fde0a47d6b2be9a8364433605cf65099416
```

PostgreSQL **16.13** / Alpine Linux **3.23.3** · Auditada 2026-04-04
Ver auditoría CVE completa en [`docs/security-cve-audit.md`](../security-cve-audit.md)
