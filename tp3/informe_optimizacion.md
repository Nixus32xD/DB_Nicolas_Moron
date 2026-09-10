# TP3 - Informe de optimización de consultas

**Alumno:** Nicolás Moron
**Motor:** PostgreSQL 18.6
**Base aislada:** `foodstore_tp3`
**Fecha de ejecución:** 10/09/2026

## Preparación

La base se creó desde `schema.sql`, `sql/00_datos_iniciales.sql` y las restricciones de TP2. Antes de la carga se creó `backups/foodstore_tp3_base_20260910.dump` y se verificó su contenido con `pg_restore -l`.

La carga de `tp3/sql/01_carga_masiva.sql` se ejecutó en una transacción y tardó **9,059 s**. Resultado final:

| Categorías | Clientes | Productos | Pedidos | Detalles |
|---:|---:|---:|---:|---:|
| 2 | 20.002 | 50.003 | 200.002 | 200.001 |

Luego se ejecutó `ANALYZE` sobre todas las tablas afectadas.

## Comparación de planes

| Consulta | Plan antes | Cambio aplicado | Plan después | Tiempo antes | Tiempo después | Mejora |
|---|---|---|---|---:|---:|---:|
| Productos por categoría, rango y orden | `Bitmap Heap Scan` + `Sort`; 13.758 filas y 11.244 descartadas por filtro | `idx_tp3_producto_categoria_precio_activo` sobre `(categoria_id, precio DESC) WHERE activo` | `Index Scan`; el rango de precio pasó a `Index Cond` y no hubo `Sort` | 11,849 ms | 0,652 ms | 18,17x |
| Pedidos recientes ordenados | `Parallel Seq Scan` + `Gather Merge`; 183.560 filas descartadas | `idx_tp3_pedido_fecha_desc` sobre `(fecha DESC)` | `Index Scan` con condición por fecha y orden aprovechado por el índice | 162,418 ms | 1,638 ms | 99,16x |
| Productos por prefijo | `Seq Scan` + `Sort`; 49.892 filas descartadas | `idx_tp3_producto_nombre_pattern` sobre `nombre text_pattern_ops` | `Index Scan` con rango de prefijo; el `Sort` final opera solo sobre 111 filas | 5,317 ms | 0,199 ms | 26,72x |

Los planes completos están en `tp3/evidencias/02_planes_antes.txt` y `tp3/evidencias/03_planes_despues.txt`.

## Decisiones de aceptación

Los tres índices se aceptaron porque atacan un costo observable en el plan: filtro y orden de precio, lectura masiva y orden de fechas, y búsqueda por prefijo. Los tiempos posteriores confirmaron la hipótesis. No se aplicaron índices redundantes ni cambios a la base de TP2.

## Conclusión

`EXPLAIN ANALYZE` mostró que el costo estimado no sustituye al tiempo real: la decisión se tomó con el nodo ejecutado, filas descartadas, buffers y `Execution Time`. La mejora más alta fue la consulta de pedidos recientes, que dejó de recorrer la tabla completa.
