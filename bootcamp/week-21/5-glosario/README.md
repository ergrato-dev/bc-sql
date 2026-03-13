# Glosario — Semana 21: Full-Text Search

Términos SQL y PostgreSQL ordenados alfabéticamente.

---

## @@

Operador de coincidencia entre `tsvector` y `tsquery`.  
Retorna `TRUE` si el vector contiene los lexemas de la query.

```sql
SELECT 'datos relacionales'::tsvector @@ 'dato'::tsquery;
-- TRUE
```

---

## GIN (Generalized Inverted Index)

Tipo de índice optimizado para búsquedas en estructuras compuestas como
`tsvector`, arrays y `JSONB`. Mapea cada lexema al conjunto de filas que
lo contienen.

```sql
CREATE INDEX idx_articles_sv ON articles USING GIN (search_vector);
```

---

## lexema

Forma canónica de una palabra después de aplicar stemming y eliminar
stopwords. Múltiples palabras pueden reducirse al mismo lexema.

Ejemplo: `'indexing'`, `'indexes'`, `'indexed'` → lexema `'index'`.

---

## plainto_tsquery

Convierte texto libre en `tsquery` aplicando AND implícito entre términos.
Más seguro y legible que `to_tsquery` para inputs de usuarios.

```sql
SELECT plainto_tsquery('spanish', 'base de datos');
-- 'bas' & 'dat'
```

---

## setweight

Asigna peso (A, B, C o D) a un `tsvector` para que `ts_rank` priorice
coincidencias en columnas más importantes (A es el mayor peso).

```sql
setweight(to_tsvector('spanish', title), 'A') ||
setweight(to_tsvector('spanish', body),  'B')
```

---

## stemming

Proceso de reducir una palabra a su raíz morfológica (stem).  
Permite que la búsqueda de `'consultas'` también encuentre `'consultar'`.  
PostgreSQL usa diccionarios de stemming configurables por idioma.

---

## stopword

Palabra de alta frecuencia y escaso valor semántico que se elimina durante
la conversión a `tsvector` (artículos, preposiciones, etc.).

Ejemplo en español: `'de'`, `'la'`, `'en'` son stopwords.

---

## to_tsquery

Convierte una expresión con operadores explícitos (`&`, `|`, `!`, `<->`)
en `tsquery`. Los términos deben estar ya lematizados o ser válidos.

```sql
SELECT to_tsquery('spanish', 'base & dato & !trigger');
```

---

## to_tsvector

Normaliza texto a `tsvector`: tokeniza, elimina stopwords y aplica stemming.

```sql
SELECT to_tsvector('spanish', 'Las bases de datos son esenciales');
-- 'bas':2 'dat':4 'esencial':6
```

---

## ts_headline

Genera un fragmento del texto original resaltando las coincidencias con
la `tsquery`. Acepta opciones para controlar longitud y marcadores HTML.

```sql
ts_headline('spanish', body, query, 'StartSel=<b>, StopSel=</b>')
```

---

## ts_rank

Calcula la relevancia de una fila en función de la frecuencia y distribución
de los lexemas coincidentes. Retorna valor entre 0 y 1.

```sql
ts_rank(search_vector, plainto_tsquery('spanish', 'índice'))
```

---

## tsquery

Tipo de dato que representa una expresión de búsqueda con operadores
lógicos aplicados sobre lexemas. Se construye con `to_tsquery` o
`plainto_tsquery`.

---

## tsvector

Tipo de dato que representa un documento preprocesado: lista de lexemas
con sus posiciones en el texto original. Se construye con `to_tsvector`.
