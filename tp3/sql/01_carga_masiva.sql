-- TP3 - Carga masiva reproducible para PostgreSQL.
-- Requiere una base nueva creada con schema.sql y sql/00_datos_iniciales.sql.
-- Ejecutar solo sobre foodstore_tp3.

BEGIN;

-- 20.000 clientes adicionales; el email único evita duplicados accidentales.
INSERT INTO cliente (nombre, apellido, email, telefono)
SELECT
    'Cliente',
    'Masivo ' || gs,
    'cliente.' || gs || '.tp3@example.test',
    '11-5000-' || lpad(gs::text, 4, '0')
FROM generate_series(1, 20000) AS gs;

-- 50.000 productos, repartidos entre las dos categorías existentes.
INSERT INTO producto (categoria_id, nombre, descripcion, precio, stock, activo)
SELECT
    CASE WHEN gs % 2 = 0 THEN 1 ELSE 2 END,
    'Producto masivo ' || gs,
    'Producto generado para medir planes de ejecución',
    (500 + (gs % 4501))::numeric(12, 2),
    gs % 201,
    TRUE
FROM generate_series(1, 50000) AS gs;

-- 200.000 pedidos distribuidos entre los clientes masivos y a lo largo de un año.
INSERT INTO pedido (cliente_id, fecha, forma_pago)
SELECT
    ((gs - 1) % 20000) + 3,
    now() - ((gs % 365) || ' days')::interval - ((gs % 86400) || ' seconds')::interval,
    (CASE gs % 3
        WHEN 0 THEN 'EFECTIVO'
        WHEN 1 THEN 'TARJETA'
        ELSE 'TRANSFERENCIA'
    END)::forma_pago
FROM generate_series(1, 200000) AS gs;

-- Un detalle por pedido. La combinación pedido/producto es única por construcción.
INSERT INTO pedido_detalle (pedido_id, producto_id, cantidad, precio_unitario)
SELECT
    gs + 2,
    ((gs - 1) % 50000) + 4,
    ((gs - 1) % 5) + 1,
    (500 + (gs % 4501))::numeric(12, 2)
FROM generate_series(1, 200000) AS gs;

COMMIT;

ANALYZE categoria;
ANALYZE cliente;
ANALYZE producto;
ANALYZE pedido;
ANALYZE pedido_detalle;
