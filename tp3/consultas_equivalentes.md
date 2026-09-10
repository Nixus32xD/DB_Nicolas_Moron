# TP3 - Consultas resumen y subconsultas equivalentes

## Consulta 1 - Resumen por categoría

### Spec

Devolver para cada categoría activa su `id`, nombre y cantidad de productos activos, incluyendo las categorías sin productos. Usar `categoria` y `producto`, no usar `SELECT *` y ordenar por identificador.

### Versiones verificadas

La versión A usa `LEFT JOIN` y `GROUP BY`; la versión B usa una subconsulta correlacionada con `COUNT(*)`. Ambas están en `tp3/sql/04_consultas_equivalentes.sql`.

### Equivalencia

`consulta_a EXCEPT consulta_b` y `consulta_b EXCEPT consulta_a` devolvieron **0 filas**.

## Consulta 2 - Clientes con pedidos recientes

### Spec

Devolver `id`, nombre y apellido de cada cliente que tenga al menos un pedido en los últimos 30 días. No repetir clientes y usar `cliente` y `pedido`.

### Versiones verificadas

La versión A usa `EXISTS`; la versión B usa `INNER JOIN` con `DISTINCT`. Ambas están en `tp3/sql/04_consultas_equivalentes.sql`.

### Equivalencia

`consulta_a EXCEPT consulta_b` y `consulta_b EXCEPT consulta_a` devolvieron **0 filas**.
