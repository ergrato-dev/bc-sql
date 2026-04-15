# Setup Local — Windows

> Dos opciones: instalador oficial (más simple) o WSL 2 + Docker (más cercano
> al entorno de producción).

## Opción A — Instalador oficial de PostgreSQL (más simple)

1. Descarga el instalador desde
   [postgresql.org/download/windows](https://www.postgresql.org/download/windows/)
   → selecciona versión **16.x**
2. Ejecuta el instalador como administrador
3. Durante la instalación:
   - Marca: **PostgreSQL Server**, **pgAdmin 4**, **Command Line Tools**
   - Puerto: `5432` (por defecto)
   - Contraseña del superusuario `postgres`: elige una segura

4. Al terminar, abre **pgAdmin 4** o **SQL Shell (psql)** desde el menú Inicio

### Crear usuario y base de datos del bootcamp

Abre **SQL Shell (psql)** e ingresa la contraseña del superusuario:

```sql
CREATE USER bootcamp WITH PASSWORD 'bootcamp123';
CREATE DATABASE bootcamp_db OWNER bootcamp
  ENCODING 'UTF8';
GRANT ALL PRIVILEGES ON DATABASE bootcamp_db TO bootcamp;
```

### Conectarse desde la terminal (PowerShell)

```powershell
& "C:\Program Files\PostgreSQL\16\bin\psql.exe" -h localhost -U bootcamp -d bootcamp_db
```

Agrega `C:\Program Files\PostgreSQL\16\bin` a tu PATH para usar `psql` directamente.

### Ejecutar un archivo .sql

```powershell
psql -h localhost -U bootcamp -d bootcamp_db -f starter\setup.sql
```

---

## Opción B — WSL 2 + Docker (recomendado para desarrollo)

WSL 2 permite correr Linux dentro de Windows y usar Docker nativo.

1. Habilita WSL 2:
   ```powershell
   wsl --install
   ```
2. Instala **Docker Desktop** con integración WSL 2 habilitada
3. Abre la terminal de Ubuntu (WSL) y sigue la
   [guía Docker](01-docker.md) del bootcamp

Esta opción produce exactamente el mismo entorno que Linux/macOS.

---

## Cliente gráfico recomendado en Windows

**DBeaver Community** — gratuito, multiplataforma, excelente para SQL.
Descarga: [dbeaver.io](https://dbeaver.io/download/)

Conexión: host `localhost` · puerto `5432` · usuario `bootcamp` · db `bootcamp_db`

---

> Si tienes conflictos de puerto (otro servicio en 5432), cambia el puerto
> en el instalador a `5433` y ajusta la conexión en consecuencia.
