-- ESCENARIO 1: LECTURA NO REPETIBLE
-- Requiere dos sesiones abiertas.
--
-- PRUEBA A: READ COMMITTED
--
-- SESIÓN A
BEGIN;
SET TRANSACTION ISOLATION LEVEL READ COMMITTED;
SELECT id, nombre, precio FROM producto WHERE id = 1;
-- PAUSAR AQUÍ y ejecutar SESIÓN B.
--
-- SESIÓN B
-- BEGIN;
-- UPDATE producto SET precio = precio + 100 WHERE id = 1;
-- COMMIT;
--
-- VOLVER A SESIÓN A
SELECT id, nombre, precio FROM producto WHERE id = 1;
COMMIT;
--
-- En READ COMMITTED, la segunda lectura puede observar el nuevo precio.
--
-- PRUEBA B: REPEATABLE READ
--
-- SESIÓN A
-- BEGIN;
-- SET TRANSACTION ISOLATION LEVEL REPEATABLE READ;
-- SELECT id, nombre, precio FROM producto WHERE id = 1;
-- PAUSAR.
--
-- SESIÓN B
-- BEGIN;
-- UPDATE producto SET precio = precio + 100 WHERE id = 1;
-- COMMIT;
--
-- SESIÓN A
-- SELECT id, nombre, precio FROM producto WHERE id = 1;
-- COMMIT;
--
-- En REPEATABLE READ la transacción conserva su snapshot.
--
-- EVIDENCIA REAL A COMPLETAR:
-- Copiar aquí o en evidencias/concurrencia/ la salida exacta de ambas pruebas.


-- ESCENARIO 2: LECTURA FANTASMA
-- Dos sesiones.
--
-- PRUEBA A: READ COMMITTED
--
-- SESIÓN A
BEGIN;
SET TRANSACTION ISOLATION LEVEL READ COMMITTED;
SELECT COUNT(*) AS productos_pizzas
FROM producto
WHERE categoria_id = 1 AND activo = TRUE;
-- PAUSAR AQUÍ.
--
-- SESIÓN B
-- BEGIN;
-- INSERT INTO producto (categoria_id, nombre, descripcion, precio, stock)
-- VALUES (1, 'Fugazzeta TP2', 'Fila creada para el laboratorio', 1600.00, 20);
-- COMMIT;
--
-- SESIÓN A
SELECT COUNT(*) AS productos_pizzas
FROM producto
WHERE categoria_id = 1 AND activo = TRUE;
COMMIT;
--
-- PRUEBA B: REPEATABLE READ
--
-- Repetir usando:
-- SET TRANSACTION ISOLATION LEVEL REPEATABLE READ;
--
-- Usar otro producto de prueba para no chocar con la fila anterior:
-- 'Especial TP2'
--
-- EVIDENCIA REAL A COMPLETAR:
-- Registrar ambos COUNT y la repetición con REPEATABLE READ.


-- ESCENARIO 3: ESPERA POR BLOQUEO
--
-- SESIÓN A
BEGIN;
SELECT id, nombre, stock
FROM producto
WHERE id = 1
FOR UPDATE;
-- NO hacer COMMIT todavía.
--
-- SESIÓN B
-- BEGIN;
-- SELECT id, nombre, stock
-- FROM producto
-- WHERE id = 1
-- FOR UPDATE;
--
-- La Sesión B debe quedar esperando.
--
-- SESIÓN A
-- COMMIT;
--
-- La Sesión B puede continuar una vez liberado el bloqueo.
--
-- SESIÓN B
-- COMMIT;
--
-- EVIDENCIA REAL A COMPLETAR:
-- Capturar/registrar que la Sesión B permaneció bloqueada hasta el COMMIT/ROLLBACK de A.
