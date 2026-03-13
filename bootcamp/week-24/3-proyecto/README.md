# Proyecto Semana 24 — Proyecto Integrador Final

## Descripción

Diseña, implementa y documenta un esquema de base de datos completo
para tu dominio asignado, incorporando todos los conceptos del bootcamp.

## Cómo ejecutar

1. Asegúrate de tener Docker corriendo:
   ```bash
   docker compose -f _scripts/docker-compose.yml up -d
   ```
2. Carga el esquema e implementa tus TODOs:
   ```bash
   docker compose -f _scripts/docker-compose.yml exec -T postgres \
     psql -U bootcamp -d bootcamp_db < starter/proyecto.sql
   ```
3. Conecta para interactuar:
   ```bash
   docker compose -f _scripts/docker-compose.yml exec postgres \
     psql -U bootcamp -d bootcamp_db
   ```

---

## Dominios de ejemplo (NO usar estos en tu implementación)

```
Museo        → artifacts, exhibitions, visitors, loans
Planetario   → shows, telescopes, members, reservations
Acuario      → species, tanks, tickets, staff
```

Tu dominio asignado es diferente — usa exclusivamente ese dominio.

---

## Requisitos mínimos

### 1. Esquema normalizado (5+ tablas)

- Al menos 5 tablas con relaciones mediante `FOREIGN KEY`
- Tipos de datos apropiados por columna
- `NOT NULL`, `CHECK`, `UNIQUE`, `DEFAULT` donde corresponda
- Al menos una columna `JSONB` para atributos variables
- Al menos una columna `TSVECTOR` para búsqueda de texto

### 2. Datos de prueba realistas

- Mínimo 3–5 filas por tabla
- Los datos deben reflejar tu dominio real

### 3. Trigger de auditoría

- Tabla `audit_log` con campos: `table_name`, `action`, `record_id`, `changed_at`
- Trigger `AFTER INSERT OR UPDATE OR DELETE` en al menos 2 tablas

### 4. Consulta analítica

- Usar CTEs y/o window functions
- Producir un reporte útil para el negocio de tu dominio

### 5. Full-Text Search o JSONB avanzado

- FTS: `search_vector` con `setweight` + índice GIN + consulta con `ts_rank`
- O JSONB: `@>`, `jsonb_set`, `jsonb_agg` con propósito claro

### 6. Índice con evidencia de mejora

- `CREATE INDEX` con propósito justificado
- `EXPLAIN ANALYZE` antes y después del índice

---

## Entrega

- Archivo `proyecto.sql` ejecutable de inicio a fin sin errores
- Comentarios en español explicando cada sección
- El archivo se ejecuta con Docker como se indica arriba

---

## Criterios de evaluación

| Criterio | Puntos |
|----------|--------|
| Esquema normalizado 5+ tablas | 10 |
| Trigger de auditoría funcional | 10 |
| Consulta analítica (CTE / window) | 10 |
| FTS o JSONB con GIN index | 10 |
| EXPLAIN ANALYZE + índice | 10 |
| **Total Producto** | **50** |
