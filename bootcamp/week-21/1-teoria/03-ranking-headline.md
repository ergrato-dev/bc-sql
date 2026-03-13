# 03 — Ranking y resaltado de resultados

## Objetivos

1. Calcular puntuación de relevancia con `ts_rank()` y `ts_rank_cd()`.
2. Resaltar coincidencias en el texto original con `ts_headline()`.
3. Combinar pesos de columnas usando `setweight()`.

---

## 1. ts_rank() — relevancia por frecuencia

```sql
SELECT
    title,
    ts_rank(search_vector, query) AS rank
FROM articles,
     plainto_tsquery('spanish', 'base datos') query
WHERE search_vector @@ query
ORDER BY rank DESC
LIMIT 10;
```

`ts_rank` retorna un valor entre 0 y 1.
Mayor frecuencia del lexema en el documento → mayor rank.

---

## 2. setweight() — ponderar columnas

Los títulos deben pesar más que el cuerpo del artículo:

```sql
-- Peso A (mayor) para título, peso B para cuerpo
UPDATE articles
SET search_vector =
    setweight(to_tsvector('spanish', COALESCE(title, '')), 'A') ||
    setweight(to_tsvector('spanish', COALESCE(body,  '')), 'B');
```

Pesos disponibles: `A` (más alto) → `B` → `C` → `D` (más bajo).

---

## 3. ts_headline() — resaltar coincidencias

```sql
SELECT
    title,
    ts_headline(
        'spanish',
        body,
        plainto_tsquery('spanish', 'base datos'),
        'StartSel=<b>, StopSel=</b>, MaxWords=20'
    ) AS extracto
FROM articles
WHERE search_vector @@ plainto_tsquery('spanish', 'base datos');
```

`ts_headline` retorna un fragmento del texto con las coincidencias
envueltas en las etiquetas que indiques.
