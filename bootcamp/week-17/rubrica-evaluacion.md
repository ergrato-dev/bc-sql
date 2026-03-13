# Rúbrica de Evaluación — Semana 17

## Transacciones y propiedades ACID

| # | Criterio | Indicadores de logro | Puntos |
|---|----------|----------------------|--------|
| 1 | **Propiedades ACID** | Explica cada propiedad (Atomicidad, Consistencia, Aislamiento, Durabilidad) con un ejemplo concreto de su dominio | 25 |
| 2 | **BEGIN / COMMIT / ROLLBACK** | Ejecuta una transacción multi-sentencia con commit exitoso y otra con rollback que no deja cambios | 25 |
| 3 | **SAVEPOINT** | Usa SAVEPOINT + ROLLBACK TO para deshacer parte de una transacción sin perder todo el trabajo | 25 |
| 4 | **Estilo y documentación** | Keywords UPPERCASE, comentarios que explican por qué se hace el rollback, una sentencia por bloque | 25 |
| **Total** | | | **100** |

## Niveles de desempeño

| Nivel | Rango | Descripción |
|-------|-------|-------------|
| Sobresaliente | 90–100 | Todos los criterios cumplidos; incluye manejo de error con EXCEPTION en el proyecto |
| Satisfactorio | 70–89 | BEGIN/COMMIT/ROLLBACK funcionales; SAVEPOINT con errores menores |
| En proceso | 50–69 | Transacciones básicas; no usa SAVEPOINT |
| Insuficiente | < 50 | No logra ejecutar una transacción sin error |

## Distribución de evidencias

| Tipo          | Porcentaje | Descripción                               |
|---------------|------------|-------------------------------------------|
| Conocimiento  | 30%        | Checklist conceptual sobre ACID           |
| Desempeño     | 40%        | Ejercicios 01 y 02 ejecutados             |
| Producto      | 30%        | Proyecto adaptado al dominio asignado     |
