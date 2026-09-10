-- TP2 - Parte 1
-- Pruebas de restricciones de integridad
-- Ejecutar sobre una COPIA de la base.
-- Antes de correr: SELECT current_database(), current_user;

-- IMPORTANTE:
-- Se recomienda ejecutar cada bloque por separado porque una violación de constraint
-- deja abortada la transacción actual hasta hacer ROLLBACK.

-- =========================================================
-- CASO 1: válido
-- =========================================================
BEGIN;

INSERT INTO pedido_detalle
    (pedido_id, producto_id, cantidad, precio_unitario)
VALUES
    (2, 1, 1, 1050.00);

SELECT *
FROM pedido_detalle
WHERE pedido_id = 2 AND producto_id = 1;

ROLLBACK;

-- =========================================================
-- CASO 2: cantidad inválida
-- Debe fallar por CHECK (cantidad > 0)
-- =========================================================
BEGIN;

INSERT INTO pedido_detalle
    (pedido_id, producto_id, cantidad, precio_unitario)
VALUES
    (2, 3, 0, 800.00);

-- Después del error:
ROLLBACK;

-- =========================================================
-- CASO 3: precio inválido
-- Debe fallar por CHECK (precio_unitario >= 0)
-- =========================================================
BEGIN;

INSERT INTO pedido_detalle
    (pedido_id, producto_id, cantidad, precio_unitario)
VALUES
    (2, 3, 1, -50.00);

-- Después del error:
ROLLBACK;

-- =========================================================
-- CASO 4: producto repetido en el mismo pedido
-- Debe fallar por UNIQUE (pedido_id, producto_id)
-- =========================================================
BEGIN;

INSERT INTO pedido_detalle
    (pedido_id, producto_id, cantidad, precio_unitario)
VALUES
    (1, 1, 1, 1050.00);

-- Después del error:
ROLLBACK;

-- EVIDENCIA REAL A COMPLETAR:
-- Guardar capturas o salida real de PostgreSQL para cada caso.
