# Ejercicio 01 — Indexación y búsqueda básica FTS

## Tema

Crear columnas `tsvector`, índices GIN y buscar documentos
con `to_tsquery` y `plainto_tsquery`.

## Cómo ejecutar

1. Levanta el contenedor:
   ```bash
   docker compose -f _scripts/docker-compose.yml up -d
   ```
2. Carga el esquema:
   ```bash
   docker compose -f _scripts/docker-compose.yml exec -T postgres \
     psql -U bootcamp -d bootcamp_db < bootcamp/week-21/2-practicas/ejercicio-01/starter/setup.sql
   ```
3. Conéctate:
   ```bash
   docker compose -f _scripts/docker-compose.yml exec postgres \
     psql -U bootcamp -d bootcamp_db
   ```
4. Abre `starter/ejercicio.sql` y sigue los pasos.

---

## Esquema de trabajo

Tabla `articles` con columnas `title`, `body` y `search_vector`.

### Paso 1: Inspeccionar tsvector

Observa cómo `to_tsvector` normaliza el texto.

```sql
SELECT to_tsvector('spanish',
    'Las bases de datos relacionales permiten consultas SQL complejas');

-- Compara con 'english'
SELECT to_tsvector('english',
    'Relational databases allow complex SQL queries');
```

**Abre `starter/ejercicio.sql`** y descomenta "PASO 1".

---

### Paso 2: Agregar columna tsvector y su índice GIN

```sql
ALTER TABLE articles
ADD COLUMN search_vector TSVECTOR
    GENERATED ALWAYS AS (
        to_tsvector('spanish',
            COALESCE(title, '') || ' ' || COALESCE(body, ''))
    ) STORED;

CREATE INDEX idx_articles_search
    ON articles USING GIN (search_vector);
```

**Descomenta "PASO 2".**

---

### Paso 3: Búsqueda básica con @@

```sql
SELECT id, title
FROM articles
WHERE search_vector @@ plainto_tsquery('spanish', 'base datos');

-- Con operadores explícitos
SELECT id, title
FROM articles
WHERE search_vector @@ to_tsquery('spanish', 'base & datos');
```

**Descomenta "PASO 3".**

---

### Paso 4: Operadores OR y NOT en tsquery

```sql
-- Artículos sobre 'transacción' o 'índice' pero no 'trigger'
SELECT id, title
FROM articles
WHERE search_vector @@
    to_tsquery('spanish', '(transacción | índice) & !trigger')
ORDER BY id;
```

**Descomenta "PASO 4".**
