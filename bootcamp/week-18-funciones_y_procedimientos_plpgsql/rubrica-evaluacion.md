# Rúbrica de Evaluación — Semana 18

## Funciones y Procedimientos en PL/pgSQL

| # | Criterio | Indicadores de logro | Puntos |
|---|----------|----------------------|--------|
| 1 | **CREATE FUNCTION** | Crea al menos una función escalar y una que retorna tabla (`RETURNS TABLE`). Ambas ejecutan sin error | 25 |
| 2 | **Variables y control de flujo** | Usa variables declaradas en `DECLARE`, al menos un `IF` y al menos un `FOR` o `LOOP` dentro de una función | 25 |
| 3 | **CREATE PROCEDURE + CALL** | Implementa un procedimiento que encapsula una transacción con `BEGIN`/`COMMIT` y lo llama con `CALL` | 25 |
| 4 | **Manejo de EXCEPTION** | El procedimiento o función captura al menos un tipo de excepción con `EXCEPTION WHEN` y produce un mensaje descriptivo | 25 |
| **Total** | | | **100** |

## Niveles de desempeño

| Nivel | Rango | Descripción |
|-------|-------|-------------|
| Sobresaliente | 90–100 | Función y procedimiento sin errores; excepción con `SQLSTATE` específico; bloque `DO` en el proyecto |
| Satisfactorio | 70–89 | Funciones funcionales; procedimiento correcto; excepción genérica |
| En proceso | 50–69 | Funciones simples sin control de flujo; no implementa procedimiento |
| Insuficiente | < 50 | No logra crear una función ejecutable |

## Distribución de evidencias

| Tipo          | Porcentaje | Descripción                               |
|---------------|------------|-------------------------------------------|
| Conocimiento  | 30%        | Checklist conceptual sobre PL/pgSQL       |
| Desempeño     | 40%        | Ejercicios 01 y 02 ejecutados             |
| Producto      | 30%        | Proyecto adaptado al dominio asignado     |
