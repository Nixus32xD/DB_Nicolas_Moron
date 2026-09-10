-- Parte 1 — Integridad versionada
-- Revisar con git diff antes de aplicar.
-- Probar primero dentro de BEGIN ... ROLLBACK.

-- Regla 1:
-- Una línea de pedido debe tener al menos una unidad.
ALTER TABLE pedido_detalle
    ADD CONSTRAINT chk_pedido_detalle_cantidad_positiva
    CHECK (cantidad > 0);

-- Regla 2:
-- El precio histórico almacenado en la línea no puede ser negativo.
ALTER TABLE pedido_detalle
    ADD CONSTRAINT chk_pedido_detalle_precio_no_negativo
    CHECK (precio_unitario >= 0);

-- Regla 3:
-- Dentro de un mismo pedido, un producto no puede repetirse en más de una línea.
ALTER TABLE pedido_detalle
    ADD CONSTRAINT uq_pedido_detalle_pedido_producto
    UNIQUE (pedido_id, producto_id);

-- Casos de prueba sugeridos:
--
-- VÁLIDO:
-- INSERT INTO pedido_detalle (pedido_id, producto_id, cantidad, precio_unitario)
-- VALUES (2, 1, 1, 1050.00);
--
-- INVÁLIDO - cantidad:
-- INSERT INTO pedido_detalle (pedido_id, producto_id, cantidad, precio_unitario)
-- VALUES (2, 3, 0, 800.00);
--
-- INVÁLIDO - precio:
-- INSERT INTO pedido_detalle (pedido_id, producto_id, cantidad, precio_unitario)
-- VALUES (2, 3, 1, -50.00);
--
-- INVÁLIDO - duplicado:
-- INSERT INTO pedido_detalle (pedido_id, producto_id, cantidad, precio_unitario)
-- VALUES (1, 1, 1, 1050.00);
