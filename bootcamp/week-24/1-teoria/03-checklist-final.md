# 3. Checklist de entrega final

## Objetivo

Verificar que el proyecto integrador cumple todos los requisitos antes
de la entrega y la presentación final.

---

## 1. Checklist de diseño

Antes de escribir la primera línea de SQL, verificar:

```
[ ] ¿El esquema tiene al menos 5 tablas con relaciones claras?
[ ] ¿Todas las claves foráneas tienen su restricción REFERENCES?
[ ] ¿Las columnas de texto tienen NOT NULL donde corresponde?
[ ] ¿Los tipos de datos son los más apropiados?
     - amount → NUMERIC(10,2)
     - flags  → BOOLEAN
     - fechas → DATE o TIMESTAMP
     - ids    → SERIAL o BIGSERIAL
```

---

## 2. Checklist de funcionalidad

```
[ ] ¿El arquivo setup.sql ejecuta desde cero sin errores?
[ ] ¿El trigger de auditoría inserta en audit_log correctamente?
[ ] ¿La consulta con window function retorna el resultado esperado?
[ ] ¿La búsqueda FTS o la consulta JSONB con @> funciona?
[ ] ¿El índice convierte un Seq Scan en Index Scan o Index Only Scan?
```

---

## 3. Checklist de calidad de código

```sql
-- ✅ Keywords en UPPERCASE
-- ✅ Identificadores en snake_case en inglés
-- ✅ Comentarios en español
-- ✅ Cada cláusula en su propia línea
-- ✅ Sin SELECT *  en código de producción
-- ✅ Sin concatenación de cadenas para construir queries
```

---

## 4. Verificación final de rendimiento

```sql
-- Ejecutar antes de entregar:
VACUUM ANALYZE;

SELECT tablename, n_live_tup, n_dead_tup
FROM pg_stat_user_tables
WHERE schemaname = 'public'
ORDER BY n_live_tup DESC;

SELECT indexname, tablename FROM pg_indexes
WHERE schemaname = 'public'
ORDER BY tablename;
```

---

## Referencias

- https://www.postgresql.org/docs/16/
- https://use-the-index-luke.com/
- https://mode.com/sql-tutorial/
