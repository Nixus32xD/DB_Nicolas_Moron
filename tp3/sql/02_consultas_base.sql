-- TP3 - Ejecutar antes y después de los índices.
-- Mantener exactamente las mismas consultas para una comparación válida.

-- Consulta 1: productos de una categoría, rango de precios y orden.
EXPLAIN (ANALYZE, BUFFERS)
SELECT id, nombre, precio
FROM producto
WHERE categoria_id = 1
  AND activo = TRUE
  AND precio BETWEEN 1000 AND 3500
ORDER BY precio DESC
LIMIT 1000;

-- Consulta 2: pedidos recientes ordenados por fecha.
EXPLAIN (ANALYZE, BUFFERS)
SELECT id, cliente_id, fecha, forma_pago
FROM pedido
WHERE fecha >= now() - interval '30 days'
ORDER BY fecha DESC
LIMIT 1000;

-- Consulta 3: búsqueda por prefijo de producto.
EXPLAIN (ANALYZE, BUFFERS)
SELECT id, nombre, precio
FROM producto
WHERE nombre LIKE 'Producto masivo 499%'
ORDER BY nombre;
