# Ejercicio 02 — Procedimientos almacenados y EXCEPTION

## Tema

Crear procedimientos con `CREATE PROCEDURE`, llamarlos con `CALL`
y capturar errores en tiempo de ejecución con bloques `EXCEPTION`.

## Cómo ejecutar

1. Asegúrate de tener Docker corriendo:
   ```bash
   docker compose -f _scripts/docker-compose.yml up -d
   ```
2. Carga el esquema:
   ```bash
   docker compose -f _scripts/docker-compose.yml exec -T postgres \
     psql -U bootcamp -d bootcamp_db < bootcamp/week-18/2-practicas/ejercicio-02/starter/setup.sql
   ```
3. Conecta e interactúa:
   ```bash
   docker compose -f _scripts/docker-compose.yml exec postgres \
     psql -U bootcamp -d bootcamp_db
   ```
4. Abre `starter/ejercicio.sql` y sigue los pasos.

---

## Esquema de trabajo

Tabla `products` del ejercicio anterior + tabla `audit_log`.

### Paso 1: Procedimiento básico con CALL

Crea `sp_restock` que actualiza el stock de un producto
dado su id y la cantidad a añadir. Llámalo con `CALL`.

```sql
CREATE OR REPLACE PROCEDURE sp_restock(p_id INT, p_qty INT)
LANGUAGE plpgsql
AS $$
BEGIN
    UPDATE products
    SET stock = stock + p_qty
    WHERE id = p_id;
    COMMIT;
END;
$$;

CALL sp_restock(1, 10);
SELECT id, name, stock FROM products WHERE id = 1;
```

**Abre `starter/ejercicio.sql`** y descomenta la sección "PASO 1".

---

### Paso 2: Procedimiento con validación y EXCEPTION

Crea `sp_sell` que descuenta stock al vender. Si el stock
es insuficiente lanza una excepción en lugar de violar el CHECK.

```sql
CREATE OR REPLACE PROCEDURE sp_sell(p_id INT, p_qty INT)
LANGUAGE plpgsql
AS $$
DECLARE
    v_stock INT;
BEGIN
    SELECT stock INTO v_stock FROM products WHERE id = p_id;

    IF v_stock < p_qty THEN
        RAISE EXCEPTION
            'Stock insuficiente: disponible=% solicitado=%',
            v_stock, p_qty;
    END IF;

    UPDATE products SET stock = stock - p_qty WHERE id = p_id;
    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        RAISE EXCEPTION 'Error en sp_sell: %', SQLERRM;
END;
$$;

CALL sp_sell(4, 1);    -- OK (Escritorio, stock=3)
CALL sp_sell(4, 100);  -- Debe lanzar excepción
```

**Descomenta la sección "PASO 2".**

---

### Paso 3: Procedimiento con log de auditoría

Crea `sp_sell_audited` que además de vender registra la
operación en `audit_log`.

```sql
CREATE OR REPLACE PROCEDURE sp_sell_audited(p_id INT, p_qty INT)
LANGUAGE plpgsql
AS $$
DECLARE
    v_name  TEXT;
    v_stock INT;
BEGIN
    SELECT name, stock INTO v_name, v_stock
    FROM products WHERE id = p_id;

    IF v_stock < p_qty THEN
        INSERT INTO audit_log (action, detail)
        VALUES ('SELL_FAILED',
                FORMAT('id=%s qty_requested=%s stock=%s',
                       p_id, p_qty, v_stock));
        COMMIT;
        RAISE EXCEPTION 'Stock insuficiente para %', v_name;
    END IF;

    UPDATE products SET stock = stock - p_qty WHERE id = p_id;

    INSERT INTO audit_log (action, detail)
    VALUES ('SELL_OK',
            FORMAT('product=%s qty=%s', v_name, p_qty));
    COMMIT;
END;
$$;

CALL sp_sell_audited(2, 5);
SELECT * FROM audit_log ORDER BY id DESC LIMIT 5;
```

**Descomenta la sección "PASO 3".**

---

### Paso 4: Bloque DO anónimo

Usa un bloque `DO` para llamar `sp_restock` en todos los
productos con stock menor a 5.

```sql
DO $$
DECLARE
    rec RECORD;
BEGIN
    FOR rec IN SELECT id, name, stock FROM products WHERE stock < 5 LOOP
        CALL sp_restock(rec.id, 20);
        RAISE NOTICE 'Reabastecido: % (era %)', rec.name, rec.stock;
    END LOOP;
END;
$$;

SELECT id, name, stock FROM products ORDER BY stock;
```

**Descomenta la sección "PASO 4".**
