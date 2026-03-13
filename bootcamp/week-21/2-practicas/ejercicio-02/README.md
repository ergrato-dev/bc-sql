# Ejercicio 02 — Ranking, setweight y ts_headline

## Tema

Calcular relevancia con `ts_rank()`, ponderar columnas con `setweight()`
y resaltar coincidencias con `ts_headline()`.

## Cómo ejecutar

1. Levanta el contenedor:
   ```bash
   docker compose -f _scripts/docker-compose.yml up -d
   ```
2. Carga el esquema:
   ```bash
   docker compose -f _scripts/docker-compose.yml exec -T postgres \
     psql -U bootcamp -d bootcamp_db < bootcamp/week-21/2-practicas/ejercicio-02/starter/setup.sql
   ```
3. Conéctate:
   ```bash
   docker compose -f _scripts/docker-compose.yml exec postgres \
     psql -U bootcamp -d bootcamp_db
   ```
4. Abre `starter/ejercicio.sql` y sigue los pasos.

---

## Esquema de trabajo

Tabla `articles` (con columna `search_vector` ponderada por `setweight`).

### Paso 1: Ranking con ts_rank()

Retorna los resultados ordenados por relevancia descendente:

```sql
SELECT
    id,
    title,
    ts_rank(search_vector, query) AS rank
FROM articles,
     plainto_tsquery('spanish', 'índice consulta') AS query
WHERE search_vector @@ query
ORDER BY rank DESC;
```

**Descomenta "PASO 1".**

---

### Paso 2: setweight — título pesa más que el cuerpo

Recalcula `search_vector` con pesos distintos para `title` (A) y `body` (B):

```sql
UPDATE articles
SET search_vector =
    setweight(to_tsvector('spanish', COALESCE(title, '')), 'A') ||
    setweight(to_tsvector('spanish', COALESCE(body,  '')), 'B');
```

**Descomenta "PASO 2".**

---

### Paso 3: ts_headline — resaltar fragmentos

Muestra el fragmento más relevante con las coincidencias marcadas:

```sql
SELECT
    title,
    ts_headline(
        'spanish',
        body,
        plainto_tsquery('spanish', 'índice GIN'),
        'StartSel=[, StopSel=], MaxWords=25, MinWords=10'
    ) AS extracto
FROM articles
WHERE search_vector @@ plainto_tsquery('spanish', 'índice GIN');
```

**Descomenta "PASO 3".**

---

### Paso 4: Búsqueda con frase (operador <->)

Busca palabras que aparecen en secuencia:

```sql
SELECT id, title
FROM articles
WHERE search_vector @@
    to_tsquery('spanish', 'text <-> search')
ORDER BY id;

-- También: buscar 'base' seguida inmediatamente de 'datos'
SELECT id, title
FROM articles
WHERE search_vector @@
    to_tsquery('spanish', 'base <-> dato')
ORDER BY id;
```

**Descomenta "PASO 4".**
