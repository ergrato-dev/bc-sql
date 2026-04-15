# Guía de Setup — PostgreSQL para el Bootcamp

A partir de la **semana 13** el bootcamp migra a **PostgreSQL 16**.
Esta guía reúne todas las formas de tener PostgreSQL disponible para practicar.

## Comparativa rápida

| Opción | Dificultad | Costo | Sin internet | Recomendado para |
|---|---|---|---|---|
| [Docker](01-docker.md) | Media | Gratis | ✅ | **Opción oficial del bootcamp** |
| [Local Linux](02-local-linux.md) | Media | Gratis | ✅ | Usuarios de Ubuntu/Debian/Fedora |
| [Local macOS](03-local-macos.md) | Baja | Gratis | ✅ | Usuarios de Mac con Homebrew |
| [Local Windows](04-local-windows.md) | Baja | Gratis | ✅ | Usuarios de Windows sin WSL |
| [Online gratuito](05-online-gratuito.md) | Muy baja | Gratis* | ❌ | Entorno de prueba rápido o sin permisos de instalación |

## Opción recomendada

**Docker** es la opción oficial porque garantiza:

- La misma versión exacta (`16.13`) en todos los entornos
- Reset limpio en cualquier momento (`docker compose down -v`)
- Sin conflictos con PostgreSQL instalado previamente en el sistema
- Reproducibilidad idéntica entre Linux, macOS y Windows

## Credenciales del bootcamp

Todas las guías usan las mismas credenciales de desarrollo local:

| Variable | Valor |
|---|---|
| Usuario | `bootcamp` |
| Contraseña | `bootcamp123` |
| Base de datos | `bootcamp_db` |
| Puerto | `5432` |

> Estas credenciales son exclusivas para el entorno local de aprendizaje.

## Verificar la conexión

Una vez configurado cualquier entorno, ejecuta esta query para confirmar:

```sql
SELECT version();
```

Debes ver algo similar a:
```
PostgreSQL 16.x on x86_64-pc-linux-musl ...
```
