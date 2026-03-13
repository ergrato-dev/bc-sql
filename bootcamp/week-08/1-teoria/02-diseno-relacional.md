# Diseño Relacional con ER

## Objetivos

- Identificar entidades y relaciones en un dominio real
- Modelar un esquema de 3 tablas con cardinalidades correctas
- Aplicar normalización básica para evitar redundancia

## Recurso visual

![Esquema ER](../0-assets/01-er-esquema-completo.svg)

---

## 1. Entidades y atributos

Cada "cosa" del mundo real que tiene datos propios es una **entidad** y
se convierte en una tabla:

```
Dominio: Biblioteca
→ books   (isbn, title, year, genre_id)
→ genres  (id, name)
→ members (id, name, email, joined_at)
```

## 2. Relaciones y cardinalidades

| Tipo | Ejemplo | Implementación |
|------|---------|----------------|
| 1:N | Un departamento tiene muchos empleados | FK en el lado "muchos" |
| N:M | Un empleado participa en muchos proyectos | Tabla intermedia |

```sql
-- Relación 1:N (FK en employees)
CREATE TABLE employees (
    department_id INTEGER REFERENCES departments(id)
);

-- Relación N:M (tabla intermedia)
CREATE TABLE employee_projects (
    employee_id INTEGER REFERENCES employees(id),
    project_id  INTEGER REFERENCES projects(id),
    PRIMARY KEY (employee_id, project_id)
);
```

## 3. Normas básicas para el capstone

1. **Cada tabla tiene PK** — sin excepción
2. **FKs con nombres descriptivos** — `department_id`, no `dept`
3. **Una columna, un dato** — no almacenar "Juan, María" en una celda
4. **Evita redundancia** — si el nombre del departamento está en
   `departments`, no lo repitas en `employees`

---

## ✅ Checklist

- [ ] ¿Identificaste al menos 3 entidades en tu dominio?
- [ ] ¿Las relaciones 1:N tienen FK en el lado "muchos"?
- [ ] ¿Los atributos multivaluados tienen tabla propia?
- [ ] ¿Hay datos que se repiten que podrían ir en una tabla separada?

## Referencias

- https://www.sqlite.org/foreignkeys.html
- https://mode.com/sql-tutorial/sql-data-types/
