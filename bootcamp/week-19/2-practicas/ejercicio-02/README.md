# Ejercicio 02 — Trigger BEFORE con validación y transformación

## Tema

Usar triggers `BEFORE INSERT OR UPDATE` para validar datos,
normalizar texto y rechazar operaciones inválidas antes de
que lleguen a disco.

## Cómo ejecutar

1. Asegúrate de tener Docker corriendo:
   ```bash
   docker compose -f _scripts/docker-compose.yml up -d
   ```
2. Carga el esquema:
   ```bash
   docker compose -f _scripts/docker-compose.yml exec -T postgres \
     psql -U bootcamp -d bootcamp_db < bootcamp/week-19/2-practicas/ejercicio-02/starter/setup.sql
   ```
3. Conecta e interactúa:
   ```bash
   docker compose -f _scripts/docker-compose.yml exec postgres \
     psql -U bootcamp -d bootcamp_db
   ```
4. Abre `starter/ejercicio.sql` y sigue los pasos.

---

## Esquema de trabajo

Tabla `products` y tabla `price_history`.

### Paso 1: Trigger BEFORE — normalizar nombre

Crea `fn_normalize_product` que convierte `NEW.name`
a mayúsculas y elimina espacios extra antes del INSERT.

```sql
CREATE OR REPLACE FUNCTION fn_normalize_product()
RETURNS TRIGGER
LANGUAGE plpgsql
AS $$
BEGIN
    NEW.name := TRIM(UPPER(NEW.name));
    RETURN NEW;
END;
$$;

CREATE TRIGGER trg_normalize_before_insert
BEFORE INSERT ON products
FOR EACH ROW EXECUTE FUNCTION fn_normalize_product();

INSERT INTO products (name, price, stock, category)
VALUES ('  laptop mini  ', 499.00, 3, 'electronics');

SELECT id, name FROM products WHERE name LIKE '%LAPTOP%';
```

**Abre `starter/ejercicio.sql`** y descomenta la sección "PASO 1".

---

### Paso 2: Trigger BEFORE — rechazar precio negativo

Agrega una segunda función `fn_validate_price` que lanza
excepción si el precio es cero o negativo.

```sql
CREATE OR REPLACE FUNCTION fn_validate_price()
RETURNS TRIGGER
LANGUAGE plpgsql
AS $$
BEGIN
    IF NEW.price <= 0 THEN
        RAISE EXCEPTION
            'El precio debe ser positivo; recibido: %', NEW.price;
    END IF;
    RETURN NEW;
END;
$$;

CREATE TRIGGER trg_validate_price
BEFORE INSERT OR UPDATE ON products
FOR EACH ROW EXECUTE FUNCTION fn_validate_price();

INSERT INTO products (name, price, stock, category)
VALUES ('Artículo inválido', 0, 1, 'test');  -- Debe fallar
```

**Descomenta la sección "PASO 2".**

---

### Paso 3: Trigger AFTER — historial de precios

Crea un trigger `AFTER UPDATE` que registra en `price_history`
cada vez que el precio de un producto cambia.

```sql
CREATE OR REPLACE FUNCTION fn_log_price_change()
RETURNS TRIGGER
LANGUAGE plpgsql
AS $$
BEGIN
    IF NEW.price <> OLD.price THEN
        INSERT INTO price_history (product_id, old_price, new_price)
        VALUES (OLD.id, OLD.price, NEW.price);
    END IF;
    RETURN NULL;
END;
$$;

CREATE TRIGGER trg_price_history
AFTER UPDATE ON products
FOR EACH ROW EXECUTE FUNCTION fn_log_price_change();

UPDATE products SET price = 1199.00 WHERE id = 1;
SELECT * FROM price_history ORDER BY id DESC LIMIT 3;
```

**Descomenta la sección "PASO 3".**

---

### Paso 4: DROP TRIGGER y DROP FUNCTION

Elimina los triggers creados y sus funciones asociadas.
Verifica que ya no existen en `pg_trigger`.

```sql
DROP TRIGGER IF EXISTS trg_normalize_before_insert ON products;
DROP TRIGGER IF EXISTS trg_validate_price ON products;
DROP TRIGGER IF EXISTS trg_price_history ON products;

DROP FUNCTION IF EXISTS fn_normalize_product();
DROP FUNCTION IF EXISTS fn_validate_price();
DROP FUNCTION IF EXISTS fn_log_price_change();

SELECT tgname FROM pg_trigger
WHERE tgrelid = 'products'::REGCLASS;
```

**Descomenta la sección "PASO 4".**
