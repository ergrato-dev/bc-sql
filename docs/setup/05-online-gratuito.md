# PostgreSQL Online — Opciones Gratuitas

> Útil cuando no puedes instalar software, quieres una demo rápida o
> necesitas compartir una consulta con compañeros.

## Comparativa

| Servicio | PostgreSQL | Persistencia | Sin registro | Límite gratuito |
|---|---|---|---|---|
| [db-fiddle](#db-fiddle) | ✅ 15 / 16 | ❌ por sesión | ✅ | Sin límite |
| [Neon](#neon) | ✅ 16 | ✅ permanente | ❌ requiere cuenta | 0.5 GB, 1 proyecto |
| [Supabase](#supabase) | ✅ 15 | ✅ permanente | ❌ requiere cuenta | 500 MB, pausa tras 1 semana inactivo |
| [Railway](#railway) | ✅ 16 | ✅ permanente | ❌ requiere cuenta | 5 USD de crédito/mes |
| [ElephantSQL](#elephantsql) | ✅ 13 | ✅ permanente | ❌ requiere cuenta | 20 MB (plan Tiny Turtle) |

---

## db-fiddle

**Ideal para**: probar queries rápidas, compartir ejemplos sin cuenta.

1. Ve a [db-fiddle.com](https://www.db-fiddle.com/)
2. Selecciona **PostgreSQL** y elige la versión (15 o 16)
3. Panel izquierdo → `setup.sql` (CREATE TABLE + INSERT)
4. Panel derecho → tu query
5. Botón **Run** — resultado aparece abajo

> No requiere registro. Los fiddles son públicos y se pueden compartir por URL.

---

## Neon

**Ideal para**: práctica persistente sin instalar nada.

1. Regístrate en [neon.tech](https://neon.tech/) (plan gratuito disponible)
2. Crea un proyecto → se provisiona PostgreSQL 16 automáticamente
3. Copia la **connection string** que aparece en el dashboard:
   ```
   postgresql://user:password@ep-xxx.us-east-2.aws.neon.tech/neondb
   ```
4. Conéctate desde psql:
   ```bash
   psql "postgresql://user:password@ep-xxx.us-east-2.aws.neon.tech/neondb"
   ```
5. O usa el **SQL Editor** integrado en el dashboard web

Crea la base del bootcamp:
```sql
CREATE USER bootcamp WITH PASSWORD 'bootcamp123';
CREATE DATABASE bootcamp_db OWNER bootcamp;
```

---

## Supabase

**Ideal para**: práctica con PostgreSQL + explorador visual de tablas.

1. Regístrate en [supabase.com](https://supabase.com/) (plan gratuito)
2. Crea un nuevo proyecto → elige región más cercana
3. Espera ~2 minutos a que el proyecto se aprovisione
4. Ve a **SQL Editor** en el panel lateral y ejecuta tus queries
5. La connection string está en **Settings → Database**

> El proyecto se pausa automáticamente tras **7 días de inactividad**.
> Reactivarlo toma ~30 segundos.

---

## Railway

**Ideal para**: proyectos con más necesidades, crédito mensual automático.

1. Regístrate en [railway.app](https://railway.app/)
2. Nuevo proyecto → **Add Service** → **Database** → **PostgreSQL**
3. Railway provee PostgreSQL 16 en segundos
4. En la sección **Variables** encontrarás `DATABASE_URL` con la connection string

> Incluye 5 USD de crédito mensual gratuito. Para el bootcamp es más que suficiente.

---

## ElephantSQL

**Ideal para**: plan muy pequeño para consultas de estudio sencillas.

1. Regístrate en [elephantsql.com](https://www.elephantsql.com/)
2. Crea una instancia en el plan **Tiny Turtle** (gratuito, 20 MB)
3. Usa el **Browser** integrado para ejecutar queries
4. La connection string está en el dashboard del proyecto

> Límite de 20 MB: suficiente para los datos de prueba del bootcamp
> (semanas 13–22), insuficiente para la semana 23 (EXPLAIN ANALYZE con
> miles de filas).

---

## Recomendación según caso de uso

| Situación | Opción |
|---|---|
| Probar una query puntual sin registrarse | db-fiddle |
| Práctica regular sin instalar nada | Neon |
| Quiero explorar las tablas visualmente | Supabase |
| Necesito más espacio o mayor rendimiento | Railway |
