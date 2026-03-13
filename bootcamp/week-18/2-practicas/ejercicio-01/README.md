# Ejercicio 01 — Funciones escalares y RETURNS TABLE

## Tema

Crear funciones PL/pgSQL que retornan un valor escalar
y funciones que retornan conjuntos de filas con `RETURNS TABLE`.

## Cómo ejecutar

1. Asegúrate de tener Docker corriendo:
   ```bash
   docker compose -f _scripts/docker-compose.yml up -d
   ```
2. Carga el esquema:
   ```bash
   docker compose -f _scripts/docker-compose.yml exec -T postgres \
     psql -U bootcamp -d bootcamp_db < bootcamp/week-18/2-practicas/ejercicio-01/starter/setup.sql
   ```
3. Conecta e interactúa:
   ```bash
   docker compose -f _scripts/docker-compose.yml exec postgres \
     psql -U bootcamp -d bootcamp_db
   ```
4. Abre `starter/ejercicio.sql` y sigue los pasos.

---

## Esquema de trabajo

Tabla `products` con nombre, precio, stock y categoría.

### Paso 1: Función escalar con IF

Crea `fn_price_category` que recibe un precio `NUMERIC`
y retorna `'expensive'`, `'standard'` o `'cheap'` según rangos.

```sql
CREATE OR REPLACE FUNCTION fn_price_category(p_price NUMERIC)
RETURNS TEXT
LANGUAGE plpgsql
AS $$
BEGIN
    IF p_price >= 500 THEN
        RETURN 'expensive';
    ELSIF p_price >= 100 THEN
        RETURN 'standard';
    ELSE
        RETURN 'cheap';
    END IF;
END;
$$;

SELECT name, price, fn_price_category(price) AS category
FROM products
ORDER BY price DESC;
```

**Abre `starter/ejercicio.sql`** y descomenta la sección "PASO 1".

---

### Paso 2: Función escalar con SELECT INTO

Crea `fn_total_stock_by_category` que recibe un nombre de categoría
y retorna el stock total de esa categoría.

```sql
CREATE OR REPLACE FUNCTION fn_total_stock_by_category(p_cat TEXT)
RETURNS INT
LANGUAGE plpgsql
AS $$
DECLARE
    v_total INT;
BEGIN
    SELECT COALESCE(SUM(stock), 0)
    INTO v_total
    FROM products
    WHERE category = p_cat;

    RETURN v_total;
END;
$$;

SELECT fn_total_stock_by_category('electronics') AS total_electronics;
```

**Descomenta la sección "PASO 2".**

---

### Paso 3: RETURNS TABLE con RETURN QUERY

Crea `fn_low_stock` que retorna todos los productos con stock
por debajo de un umbral dado.

```sql
CREATE OR REPLACE FUNCTION fn_low_stock(p_min INT)
RETURNS TABLE(id INT, name TEXT, stock INT, category TEXT)
LANGUAGE plpgsql
AS $$
BEGIN
    RETURN QUERY
        SELECT p.id, p.name, p.stock, p.category
        FROM products p
        WHERE p.stock < p_min
        ORDER BY p.stock;
END;
$$;

SELECT * FROM fn_low_stock(10);
```

**Descomenta la sección "PASO 3".**

---

### Paso 4: Función con bucle FOR

Crea `fn_apply_discount` que itera sobre los productos de una
categoría y retorna el precio con descuento del 10%.

```sql
CREATE OR REPLACE FUNCTION fn_apply_discount(p_cat TEXT)
RETURNS TABLE(id INT, name TEXT, original NUMERIC, discounted NUMERIC)
LANGUAGE plpgsql
AS $$
DECLARE
    rec RECORD;
BEGIN
    FOR rec IN
        SELECT p.id, p.name, p.price FROM products p WHERE p.category = p_cat
    LOOP
        RETURN QUERY
            SELECT rec.id, rec.name, rec.price,
                   ROUND(rec.price * 0.90, 2);
    END LOOP;
END;
$$;

SELECT * FROM fn_apply_discount('electronics');
```

**Descomenta la sección "PASO 4".**
