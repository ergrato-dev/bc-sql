# Ejercicio 01 — Operadores de acceso JSONB

## Tema

Navegar documentos con `->`, `->>`, `#>>` y verificar existencia con `?`.

## Cómo ejecutar

1. Levanta el contenedor:
   ```bash
   docker compose -f scripts/docker-compose.yml up -d
   ```
2. Carga el esquema:
   ```bash
   docker compose -f scripts/docker-compose.yml exec -T postgres \
     psql -U bootcamp -d bootcamp_db < bootcamp/week-22-json_y_jsonb/2-practicas/ejercicio-01/starter/setup.sql
   ```
3. Conéctate:
   ```bash
   docker compose -f scripts/docker-compose.yml exec postgres \
     psql -U bootcamp -d bootcamp_db
   ```
4. Abre `starter/ejercicio.sql` y sigue los pasos.

---

## Esquema de trabajo

Tabla `products` con columna `attributes JSONB`.

---

### Paso 1: Inspecionar la columna JSONB

Observar el contenido de `attributes` en cada fila:

```sql
SELECT id, name, attributes
FROM products;
```

**Descomenta "PASO 1".**

---

### Paso 2: Acceso con `->` y `->>`

Extraer el campo `color` de cada fila:

```sql
SELECT
    name,
    attributes -> 'color'  AS color_jsonb,
    attributes ->> 'color' AS color_text
FROM products
WHERE attributes ? 'color';
```

**Descomenta "PASO 2".**

---

### Paso 3: Filtrar por valor de campo

Traer solo los productos con `color = 'silver'`:

```sql
SELECT id, name
FROM products
WHERE attributes ->> 'color' = 'silver';
```

**Descomenta "PASO 3".**

---

### Paso 4: Acceso anidado con `#>>`

Leer `sensor.megapixels` del documento anidado:

```sql
SELECT
    name,
    attributes #>> '{sensor, megapixels}' AS megapixels,
    attributes #>> '{sensor, type}'       AS sensor_type
FROM products
WHERE attributes ? 'sensor';
```

**Descomenta "PASO 4".**
