-- TP3 - Parte 4: dos pares de consultas equivalentes.

-- Consulta resumen A: categorías vigentes con su cantidad de productos vigentes.
WITH consulta_a AS (
    SELECT c.id, c.nombre, COUNT(p.id) AS cantidad_productos
    FROM categoria c
    LEFT JOIN producto p
        ON p.categoria_id = c.id
       AND p.activo = TRUE
    WHERE c.activo = TRUE
    GROUP BY c.id, c.nombre
),
consulta_b AS (
    SELECT c.id, c.nombre,
        (SELECT COUNT(*)
         FROM producto p
         WHERE p.categoria_id = c.id
           AND p.activo = TRUE) AS cantidad_productos
    FROM categoria c
    WHERE c.activo = TRUE
)
SELECT 'A_MINUS_B' AS verificacion, * FROM (
    SELECT * FROM consulta_a
    EXCEPT
    SELECT * FROM consulta_b
) AS diferencias
UNION ALL
SELECT 'B_MINUS_A' AS verificacion, * FROM (
    SELECT * FROM consulta_b
    EXCEPT
    SELECT * FROM consulta_a
) AS diferencias;

-- Consulta con subconsulta A y join B: clientes con pedidos en los últimos 30 días.
WITH consulta_a AS (
    SELECT c.id, c.nombre, c.apellido
    FROM cliente c
    WHERE EXISTS (
        SELECT 1
        FROM pedido p
        WHERE p.cliente_id = c.id
          AND p.fecha >= now() - interval '30 days'
    )
),
consulta_b AS (
    SELECT DISTINCT c.id, c.nombre, c.apellido
    FROM cliente c
    INNER JOIN pedido p ON p.cliente_id = c.id
    WHERE p.fecha >= now() - interval '30 days'
)
SELECT 'A_MINUS_B' AS verificacion, * FROM (
    SELECT * FROM consulta_a
    EXCEPT
    SELECT * FROM consulta_b
) AS diferencias
UNION ALL
SELECT 'B_MINUS_A' AS verificacion, * FROM (
    SELECT * FROM consulta_b
    EXCEPT
    SELECT * FROM consulta_a
) AS diferencias;
