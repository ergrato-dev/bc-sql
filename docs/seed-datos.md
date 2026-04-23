# Cómo obtener datos de prueba para tu proyecto

> **⚠️ LEER ANTES DE EMPEZAR CUALQUIER PROYECTO SEMANAL**
>
> Las consultas SQL no se evalúan en el vacío. Sin datos suficientes,
> un `GROUP BY` siempre devuelve 1 fila, un `HAVING` nunca filtra nada,
> y un `JOIN` parece funcionar aunque esté mal escrito.
> **El volumen de datos es parte del requisito de entrega.**

---

## Volumen mínimo obligatorio por etapa

| Semanas | Tabla principal | Tablas secundarias | Motor |
|---------|----------------|--------------------|-------|
| 01–03   | 15 filas       | 5 filas c/u        | SQLite |
| 04–08   | 30 filas       | 10 filas c/u       | SQLite |
| 09–12   | 80 filas       | 20 filas c/u       | SQLite |
| 13–24   | 200 filas      | 50 filas c/u       | PostgreSQL 16 |

**Regla de oro**: si tu consulta más exigente del proyecto devuelve
exactamente 1 fila o 0 filas, tus datos son insuficientes.

---

## Opción 1 — Mockaroo (recomendada para semanas 01–12)

**[mockaroo.com](https://mockaroo.com)** — gratuito, sin registro, genera
hasta 1.000 filas por descarga en formato SQL directo.

### Pasos

1. Ve a [mockaroo.com](https://mockaroo.com)
2. Define las columnas según tu dominio (nombre, tipo, rango)
3. En **Format** selecciona `SQL`
4. En **Table Name** escribe el nombre exacto de tu tabla (`boats`, `patients`, etc.)
5. Ajusta el número de filas según la tabla mínimo de arriba
6. Clic en **Download Data** → obtienes un `.sql` listo para ejecutar

### Tipos de dato más útiles en Mockaroo

| Tipo Mockaroo | Cuándo usarlo |
|--------------|---------------|
| `Full Name` | nombres de personas |
| `First Name` / `Last Name` | columnas separadas |
| `Company Name` | nombres de empresas |
| `Number` (min/max) | salarios, precios, cantidades |
| `Date` (from/to) | fechas de registro, citas |
| `Boolean` | columnas `is_active`, `is_paid` |
| `Custom List` | estados fijos: `'active','inactive','pending'` |
| `Row Number` | IDs si no usas autoincrement |
| `Foreign Key` | referencia a otra tabla ya generada |

> **Tip**: genera primero las tablas padre (sin FK), descárgalas,
> luego genera las tablas hijo con FK apuntando a los IDs generados.

---

## Opción 2 — GitHub Copilot / ChatGPT como generador

Pide directamente al asistente que genere los `INSERT`:

```
Dame 50 INSERT INTO realistas para una tabla SQLite con esta estructura:

CREATE TABLE boats (
    id          INTEGER PRIMARY KEY,
    name        TEXT    NOT NULL,
    type        TEXT    NOT NULL,   -- 'sailboat','motorboat','yacht'
    length_m    REAL    NOT NULL,
    capacity    INTEGER NOT NULL,
    owner_id    INTEGER NOT NULL
);

Requisitos:
- Nombres de embarcaciones reales y variados
- Distribución desigual de tipos (más sailboats que yachts)
- length_m entre 6.0 y 25.0
- capacity entre 4 y 20
- owner_id entre 1 y 15 (referencia a tabla owners ya existente)
```

**Qué pedir explícitamente:**

- Distribuciones **desiguales** (evita que todos los registros sean idénticos)
- Valores **edge**: algún NULL donde la columna lo permita, algún valor mínimo y máximo
- Rango de fechas **amplio** (varios años, no todo el mismo mes)

---

## Opción 3 — `generate_series` en PostgreSQL (semanas 13–24)

Para semanas 13 en adelante (PostgreSQL), puedes generar miles de filas
directamente en SQL sin herramientas externas:

```sql
-- Genera 500 filas en una sola sentencia
INSERT INTO appointments (patient_id, doctor_id, scheduled_at, status)
SELECT
    (g % 80) + 1,                                   -- patient_id 1–80
    (g % 10) + 1,                                   -- doctor_id 1–10
    NOW() - (INTERVAL '1 day' * (g % 365)),         -- último año
    CASE (g % 4)
        WHEN 0 THEN 'completed'
        WHEN 1 THEN 'scheduled'
        WHEN 2 THEN 'cancelled'
        ELSE 'no_show'
    END
FROM generate_series(1, 500) AS g;
```

Ajusta los módulos (`% 80`, `% 10`) según cuántos pacientes y médicos
tienes en las tablas padre.

---

## Verificación antes de entregar

Ejecuta estas consultas sobre tus datos **antes de escribir la solución**:

```sql
-- 1. Conteo por tabla — ninguna debe tener menos del mínimo
SELECT COUNT(*) FROM tu_tabla_principal;

-- 2. Distribución — si todos los grupos tienen el mismo COUNT, los datos son artificiales
SELECT categoria, COUNT(*) FROM tu_tabla_principal GROUP BY categoria;

-- 3. NULLs — verifica que existen casos con NULL donde aplica
SELECT COUNT(*) FROM tu_tabla_principal WHERE columna_opcional IS NULL;
```

Si el conteo de algún grupo es igual para todos, vuelve a generar
con distribución desigual.

---

## Referencias

- [Mockaroo — generador de datos falsos](https://mockaroo.com)
- [generatedata.com — alternativa open source](https://generatedata.com)
- [PostgreSQL — generate_series](https://www.postgresql.org/docs/16/functions-srf.html)
