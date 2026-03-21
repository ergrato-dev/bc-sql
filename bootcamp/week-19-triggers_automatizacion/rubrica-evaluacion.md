# Rúbrica de Evaluación — Semana 19

## Triggers: Automatización de lógica en la base de datos

| # | Criterio | Indicadores de logro | Puntos |
|---|----------|----------------------|--------|
| 1 | **Trigger function** | Crea una función de trigger que use correctamente `NEW`, `OLD` y retorna `NEW` o `NULL` según el tipo de trigger | 25 |
| 2 | **Trigger AFTER** | Implementa un trigger `AFTER INSERT OR UPDATE OR DELETE` que registra cambios en una tabla de auditoría | 25 |
| 3 | **Trigger BEFORE** | Implementa un trigger `BEFORE INSERT OR UPDATE` que valida o transforma los datos antes de persistirlos | 25 |
| 4 | **Gestión del ciclo de vida** | Demuestra cómo deshabilitar (`DISABLE TRIGGER`), habilitar y eliminar (`DROP TRIGGER`) un trigger | 25 |
| **Total** | | | **100** |

## Niveles de desempeño

| Nivel | Rango | Descripción |
|-------|-------|-------------|
| Sobresaliente | 90–100 | Trigger function reutilizable para múltiples tablas; usa `TG_TABLE_NAME` y `TG_OP` |
| Satisfactorio | 70–89 | Triggers funcionales; auditoría y validación correctas |
| En proceso | 50–69 | Trigger de auditoría funciona; no implementa BEFORE |
| Insuficiente | < 50 | No logra crear un trigger ejecutable |

## Distribución de evidencias

| Tipo          | Porcentaje | Descripción                               |
|---------------|------------|-------------------------------------------|
| Conocimiento  | 30%        | Checklist conceptual sobre triggers       |
| Desempeño     | 40%        | Ejercicios 01 y 02 ejecutados             |
| Producto      | 30%        | Proyecto adaptado al dominio asignado     |
