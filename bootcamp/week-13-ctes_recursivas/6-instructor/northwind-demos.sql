-- ============================================================
-- DEMOS INSTRUCTOR — Semana 13: CTEs Recursivas
-- Base de datos: northwind (PostgreSQL 16 · Docker)
-- ⚠️  SOLO USO INTERNO — No compartir con aprendices
-- ============================================================
-- Conectar al contenedor:
--   docker compose -f scripts/docker-compose.yml exec postgres \
--     psql -U bootcamp -d northwind
-- ============================================================
-- Northwind tiene employees.reports_to — jerarquía perfecta
-- para demostrar WITH RECURSIVE con datos reales.
-- ============================================================


-- ── 0. Ver la jerarquía plana primero ────────────────────────
SELECT employee_id, first_name, last_name, reports_to
FROM employees
ORDER BY reports_to NULLS FIRST;


-- ── 1. CTE RECURSIVA — recorrer la jerarquía desde la raíz ───
WITH RECURSIVE jerarquia AS (

    -- Caso base: el/los empleados sin jefe (nivel 0 = raíz)
    SELECT
        employee_id,
        first_name || ' ' || last_name  AS nombre,
        title,
        reports_to,
        0                               AS nivel,
        ARRAY[employee_id]              AS path_ids,
        first_name || ' ' || last_name  AS path_nombre
    FROM employees
    WHERE reports_to IS NULL

    UNION ALL

    -- Paso recursivo: empleados que reportan al nivel anterior
    SELECT
        e.employee_id,
        e.first_name || ' ' || e.last_name,
        e.title,
        e.reports_to,
        j.nivel + 1,
        j.path_ids   || e.employee_id,
        j.path_nombre || ' → ' || e.first_name || ' ' || e.last_name
    FROM employees e
    INNER JOIN jerarquia j ON e.reports_to = j.employee_id
)
SELECT
    repeat('    ', nivel) || nombre  AS organigrama,
    title,
    nivel,
    path_nombre                      AS cadena_de_mando
FROM jerarquia
ORDER BY path_ids;


-- ── 2. Subordinados directos e indirectos de un manager ───────
-- ¿Quiénes reportan (directa o indirectamente) a Andrew Fuller (id=2)?
WITH RECURSIVE subordinados AS (
    SELECT employee_id, first_name || ' ' || last_name AS nombre, reports_to, 1 AS nivel
    FROM employees
    WHERE reports_to = 2  -- Andrew Fuller

    UNION ALL

    SELECT e.employee_id, e.first_name || ' ' || e.last_name, e.reports_to, s.nivel + 1
    FROM employees e
    INNER JOIN subordinados s ON e.reports_to = s.employee_id
)
SELECT nombre, nivel FROM subordinados ORDER BY nivel, nombre;


-- ── 3. Profundidad máxima de la jerarquía ────────────────────
WITH RECURSIVE profundidad AS (
    SELECT employee_id, 0 AS nivel FROM employees WHERE reports_to IS NULL
    UNION ALL
    SELECT e.employee_id, p.nivel + 1
    FROM employees e
    INNER JOIN profundidad p ON e.reports_to = p.employee_id
)
SELECT MAX(nivel) AS niveles_jerarquia FROM profundidad;


-- ── 4. Detección de ciclos (precaución en datos reales) ───────
-- Northwind no tiene ciclos, pero mostrar la técnica preventiva:
WITH RECURSIVE seguro AS (
    SELECT employee_id, reports_to, ARRAY[employee_id] AS visitados, FALSE AS ciclo
    FROM employees
    WHERE reports_to IS NULL

    UNION ALL

    SELECT
        e.employee_id,
        e.reports_to,
        s.visitados || e.employee_id,
        e.employee_id = ANY(s.visitados)   -- detectar si ya aparece
    FROM employees e
    INNER JOIN seguro s ON e.reports_to = s.employee_id
    WHERE NOT s.ciclo
)
SELECT employee_id, ciclo FROM seguro ORDER BY employee_id;
