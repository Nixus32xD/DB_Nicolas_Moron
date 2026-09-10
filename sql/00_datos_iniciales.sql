-- Food Store - datos mínimos y reproducibles para el TP2.
-- Ejecutar inmediatamente después de schema.sql sobre una base de trabajo nueva.
-- Los IDs 1, 2 y 3 se usan en los laboratorios y se obtienen al crear la base desde cero.

INSERT INTO categoria (nombre) VALUES
    ('Pizzas'),
    ('Bebidas');

INSERT INTO cliente (nombre, apellido, email, telefono) VALUES
    ('Nicolás', 'Moron', 'nicolas.moron.tp2@example.test', '0000-0000'),
    ('Cliente', 'Prueba', 'cliente.prueba.tp2@example.test', '0000-0001');

INSERT INTO producto (categoria_id, nombre, descripcion, precio, stock) VALUES
    (1, 'Muzzarella', 'Pizza de prueba para el laboratorio', 1050.00, 20),
    (1, 'Napolitana', 'Pizza de prueba para interbloqueo opcional', 1200.00, 15),
    (2, 'Gaseosa', 'Bebida de prueba para las restricciones', 800.00, 30);

INSERT INTO pedido (cliente_id, forma_pago) VALUES
    (1, 'EFECTIVO'),
    (2, 'TRANSFERENCIA');

-- Esta fila permite comprobar la restricción de producto repetido del pedido 1.
INSERT INTO pedido_detalle (pedido_id, producto_id, cantidad, precio_unitario) VALUES
    (1, 1, 1, 1050.00);
