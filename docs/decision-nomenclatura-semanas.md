# ADR-001: Esquema de Nomenclatura de Carpetas por Semana

**Fecha**: 2026-03-21
**Estado**: Aceptado

---

## Contexto

Las carpetas de semanas del bootcamp usaban el esquema `week-XX` (ej: `week-01`,
`week-14`). Este esquema no comunicaba el contenido de la semana al explorar el
repositorio en el sistema de archivos o en GitHub.

## Decisión

Se adopta el esquema `week-XX-tema_principal`, donde:

- `XX` es el número de semana con cero a la izquierda (dos dígitos).
- `tema_principal` es el tema central de la semana en **snake_case ASCII**,
  derivado exclusivamente del título del `README.md` de la semana.

## Mapeo completo

| Carpeta anterior | Carpeta nueva |
|---|---|
| `week-01` | `week-01-introduccion_bases_de_datos_relacionales` |
| `week-02` | `week-02-ddl_diseno_de_esquemas` |
| `week-03` | `week-03-dml_manipulacion_de_datos` |
| `week-04` | `week-04-consultas_basicas_select` |
| `week-05` | `week-05-operadores_y_filtros` |
| `week-06` | `week-06-funciones_de_agregacion` |
| `week-07` | `week-07-null_y_constraints` |
| `week-08` | `week-08-proyecto_integrador_etapa_0` |
| `week-09` | `week-09-joins_inner_join_y_left_join` |
| `week-10` | `week-10-cross_join_y_self_join` |
| `week-11` | `week-11-subqueries` |
| `week-12` | `week-12-ctes_y_case_when` |
| `week-13` | `week-13-ctes_recursivas` |
| `week-14` | `week-14-window_functions_ranking` |
| `week-15` | `week-15-window_functions_navegacion_y_vistas` |
| `week-16` | `week-16-indices_y_funciones_integradas` |
| `week-17` | `week-17-transacciones_y_acid` |
| `week-18` | `week-18-funciones_y_procedimientos_plpgsql` |
| `week-19` | `week-19-triggers_automatizacion` |
| `week-20` | `week-20-lateral_joins_y_funciones_en_from` |
| `week-21` | `week-21-full_text_search` |
| `week-22` | `week-22-json_y_jsonb` |
| `week-23` | `week-23-optimizacion_de_consultas_explain_analyze` |
| `week-24` | `week-24-proyecto_integrador_final` |

## Reglas para nuevas semanas

1. El `tema_principal` se extrae **únicamente** del título `h1` del `README.md`
   de la semana (primera línea del archivo).
2. Se convierte a **snake_case** usando solo caracteres ASCII (sin tildes).
3. Se usa **minúsculas** en todo el sufijo.
4. Los separadores entre palabras son guiones bajos (`_`).
5. El separador entre el número y el tema es un guión (`-`).

**Ejemplo:** Si el README dice `# Semana 25 — Particionamiento de Tablas`,
la carpeta sería `week-25-particionamiento_de_tablas`.

## Consecuencias

- **Positivo**: El nombre de la carpeta comunica su contenido de forma inmediata
  en el explorador de archivos y en GitHub.
- **Positivo**: Facilita la navegación sin necesidad de abrir el README.
- **A tener en cuenta**: Al crear pull requests o ramas, usar el nombre completo
  de la carpeta: `feat(week-05-operadores_y_filtros): ...`
