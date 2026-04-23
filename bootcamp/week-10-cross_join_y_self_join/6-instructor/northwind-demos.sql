-- ============================================================
-- DEMOS INSTRUCTOR — Semana 10: CROSS JOIN y SELF JOIN
-- Base de datos: northwind (PostgreSQL 16 · Docker)
-- ⚠️  SOLO USO INTERNO — No compartir con aprendices
-- ============================================================
-- Conectar al contenedor:
--   docker compose -f scripts/docker-compose.yml exec postgres \
--     psql -U bootcamp -d northwind
-- ============================================================


-- ── 1. SELF JOIN — jerarquía de reportes en employees ────────
-- Northwind tiene employees.reports_to → auto-referencia perfecta.

-- Ver la jerarquía: quién reporta a quién
SELECT
    emp.employee_id,
    emp.first_name || ' ' || emp.last_name    AS empleado,
    emp.title,
    mgr.first_name || ' ' || mgr.last_name    AS reporta_a,
    mgr.title                                  AS cargo_jefe
FROM employees emp
LEFT JOIN employees mgr ON emp.reports_to = mgr.employee_id
ORDER BY mgr.last_name NULLS FIRST, emp.last_name;


-- ── 2. SELF JOIN — compañeros de equipo (mismo jefe) ─────────
-- ¿Quiénes comparten el mismo manager directo?
SELECT
    mgr.first_name || ' ' || mgr.last_name    AS jefe,
    e1.first_name  || ' ' || e1.last_name     AS empleado_a,
    e2.first_name  || ' ' || e2.last_name     AS empleado_b
FROM employees mgr
INNER JOIN employees e1 ON e1.reports_to = mgr.employee_id
INNER JOIN employees e2 ON e2.reports_to = mgr.employee_id
WHERE e1.employee_id < e2.employee_id   -- evitar duplicados y autocomparaciones
ORDER BY jefe, empleado_a;


-- ── 3. SELF JOIN — encontrar la cadena de mando ──────────────
-- Para un empleado dado, mostrar su manager y el manager del manager:
SELECT
    e.first_name   || ' ' || e.last_name    AS empleado,
    m1.first_name  || ' ' || m1.last_name   AS manager_directo,
    m2.first_name  || ' ' || m2.last_name   AS director
FROM employees e
LEFT JOIN employees m1 ON e.reports_to   = m1.employee_id
LEFT JOIN employees m2 ON m1.reports_to  = m2.employee_id
ORDER BY e.last_name;


-- ── 4. CROSS JOIN — producto cartesiano controlado ───────────
-- Caso de uso real: generar todas las combinaciones posibles
-- de categoría × shipper para un reporte de cobertura.

-- ⚠️ Preguntar: ¿cuántas filas esperan?
-- categories: 8 filas · shippers: 3 filas → 8 × 3 = 24 combinaciones

SELECT
    c.category_name,
    s.company_name AS shipper
FROM categories c
CROSS JOIN shippers s
ORDER BY c.category_name, s.company_name;


-- ── 5. CROSS JOIN — caso: calendario de turnos ───────────────
-- Empleados × días de la semana (demo conceptual):
SELECT
    e.first_name || ' ' || e.last_name  AS empleado,
    d.dia
FROM employees e
CROSS JOIN (
    VALUES ('Lunes'), ('Martes'), ('Miércoles'), ('Jueves'), ('Viernes')
) AS d(dia)
ORDER BY empleado, d.dia;
