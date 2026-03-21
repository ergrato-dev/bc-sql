# Proyecto Semanal — DML: Manipulación de Datos

## Semana 03 — Evidencia de Producto (30%)

Aplica `INSERT INTO`, `UPDATE` y `DELETE` sobre el esquema diseñado en la Semana 02,
adaptado a tu **dominio asignado**.

---

## Instrucciones

1. Abre `starter/proyecto.sql`
2. Cambia los nombres de tablas y columnas al vocabulario de tu dominio
3. Implementa cada `TODO` con SQL funcional
4. Ejecuta el archivo completo en SQLite para verificar que no hay errores

---

## Requisitos mínimos

| Requisito | Descripción |
|-----------|-------------|
| INSERT bulk | Al menos **2 tablas** con mínimo **5 filas** cada una |
| FK correcta | Los inserts respetan el orden padre → hijo |
| UPDATE seguro | Mínimo **2 sentencias UPDATE** con `WHERE` usando PK |
| UPDATE condicional | Al menos **1 UPDATE** sobre múltiples filas por condición |
| DELETE seguro | Mínimo **1 DELETE** precedido de un `SELECT` de verificación |

---

## Dominios de ejemplo

- Biblioteca → `books`, `members`, `loans`
- Farmacia → `medicines`, `suppliers`, `sales`
- Gimnasio → `members`, `plans`, `attendance`
- Restaurante → `dishes`, `tables`, `orders`

---

## Criterios de evaluación

- **Funcionalidad** (50%): todos los scripts se ejecutan sin error
- **Integridad de datos** (25%): FKs respetadas, constraints satisfechos
- **Buenas prácticas** (25%): `WHERE` en UPDATE/DELETE, comentarios en español
