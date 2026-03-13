# Política de Seguridad

## 🔒 Versiones Soportadas

| Versión | Soportada |
| ------- | --------- |
| main    | ✅        |
| develop | ✅        |
| < 1.0   | ❌        |

---

## 🐛 Reportar una Vulnerabilidad

La seguridad de nuestros estudiantes y contribuidores es nuestra prioridad.
Si descubres una vulnerabilidad en el bootcamp, repórtala de manera responsable.

### ¿Qué consideramos una vulnerabilidad?

#### 🚨 Críticas

- Credenciales reales o claves API expuestas en el código SQL
- Ejemplos de SQL Injection sin advertencia educativa clara
- Configuraciones Docker inseguras que puedan ser copiadas a producción
- Dependencias con vulnerabilidades conocidas

#### ⚠️ Moderadas

- Prácticas de SQL inseguras en ejemplos sin contextualizar el riesgo
- Queries que construyen SQL por concatenación de strings (sin advertencia)
- Configuraciones de PostgreSQL con permisos excesivos

#### ℹ️ Informativas

- Mejoras en la enseñanza de seguridad SQL (SQL Injection, permisos)
- Sugerencias de mejores prácticas de base de datos
- Actualizaciones de documentación de seguridad

---

## 📧 Cómo Reportar

### Opción 1: GitHub Security Advisory (Preferido)

1. Ve a la pestaña **Security** del repositorio
2. Haz clic en **"Report a vulnerability"**
3. Completa el formulario con los detalles

### Opción 2: Issue con etiqueta `security`

Para problemas de menor severidad:

1. Crea un issue con la etiqueta `security`
2. **No incluyas credenciales reales** en el título o cuerpo
3. Describe el problema de forma general

---

## ⏱️ Tiempo de Respuesta

| Severidad | Respuesta | Resolución |
| --- | --- | --- |
| Crítica   | 24 horas  | 48–72 horas    |
| Moderada  | 48 horas  | 1–2 semanas    |
| Baja      | 1 semana  | Próximo release |

---

## 🛡️ Mejores Prácticas de Seguridad SQL para Estudiantes

### Nunca construyas queries con concatenación de strings

```sql
-- ❌ VULNERABLE a SQL Injection
-- query = "SELECT * FROM users WHERE id = " + userId

-- ✅ Usar parámetros preparados (en código de aplicación)
-- query = "SELECT * FROM users WHERE id = $1"
-- execute(query, [userId])
```

### Credenciales de desarrollo en Docker

Las credenciales de `_scripts/docker-compose.yml` son **exclusivamente para
entorno local de aprendizaje**. Nunca uses `bootcamp123` en producción.

```bash
# Para producción, usa variables de entorno:
POSTGRES_PASSWORD=$(openssl rand -base64 32)
```

### Principio de mínimo privilegio

```sql
-- ✅ Crea roles con solo los permisos necesarios
CREATE ROLE readonly_user LOGIN PASSWORD 'strong_password';
GRANT CONNECT ON DATABASE bootcamp_db TO readonly_user;
GRANT SELECT ON ALL TABLES IN SCHEMA public TO readonly_user;
```

### Enmascara datos sensibles

```sql
-- ✅ Nunca almacenar contraseñas en texto plano
-- Usar extensión pgcrypto para hashing:
CREATE EXTENSION IF NOT EXISTS pgcrypto;
INSERT INTO users (email, password_hash)
VALUES ('user@example.com', crypt('password', gen_salt('bf')));
```

---

## 📚 Recursos de Seguridad

- [OWASP Top 10](https://owasp.org/www-project-top-ten/)
- [PostgreSQL Security](https://www.postgresql.org/docs/16/security.html)
- [SQL Injection Prevention — OWASP](https://cheatsheetseries.owasp.org/cheatsheets/SQL_Injection_Prevention_Cheat_Sheet.html)

---

## 🙏 Agradecimientos

Agradecemos a todos los investigadores de seguridad y contribuidores que
ayudan a mantener este proyecto seguro para nuestra comunidad de estudiantes.

---

_Última actualización: Marzo 2026_
_Versión: 1.0_
