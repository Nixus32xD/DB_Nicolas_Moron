-- TP3 - Índices aceptados después de revisar los planes antes de medir.
-- Aplicar sobre foodstore_tp3 y volver a ejecutar 02_consultas_base.sql.

CREATE INDEX idx_tp3_producto_categoria_precio_activo
    ON producto (categoria_id, precio DESC)
    WHERE activo = TRUE;

CREATE INDEX idx_tp3_pedido_fecha_desc
    ON pedido (fecha DESC);

CREATE INDEX idx_tp3_producto_nombre_pattern
    ON producto (nombre text_pattern_ops);

ANALYZE producto;
ANALYZE pedido;
