# TP3 - Lectura crítica de un plan interpretado por IA

## Plan analizado

Consulta de pedidos recientes después de aplicar `idx_tp3_pedido_fecha_desc`:

```text
Index Scan using idx_tp3_pedido_fecha_desc on pedido
Index Cond: (fecha >= (now() - '30 days'::interval))
Execution Time: 1.638 ms
```

## Explicación generada y contraste

| Afirmación de la IA | ¿Correcta? | Corrección o evidencia del plan real |
|---|---|---|
| El `Index Scan` evita recorrer los 200.002 pedidos para localizar los recientes. | Sí | El plan posterior usa `idx_tp3_pedido_fecha_desc` con `Index Cond` por fecha; el plan anterior tenía `Parallel Seq Scan` y descartó 183.560 filas. |
| El índice también entrega las filas en orden descendente de fecha, por lo que desaparece el `Gather Merge` y el `Sort`. | Sí | El plan posterior no contiene `Sort` ni `Gather Merge`; usa un único `Index Scan` y tarda 1,638 ms. |
| El costo `0.42..389.25` significa que la consulta tarda 389,25 ms. | No | `cost` es una estimación interna sin unidad temporal. El tiempo real que vale para la comparación es `Execution Time: 1.638 ms`. |
| El plan es un `Index Only Scan`, por lo que no necesita leer la tabla. | No | El nodo real dice `Index Scan`, no `Index Only Scan`; además devuelve columnas que no están todas en el índice. |

## Conclusión

La IA identificó correctamente el índice y la eliminación del ordenamiento, pero confundió costo estimado con milisegundos y afirmó un tipo de nodo inexistente. Ambas imprecisiones se detectaron al leer el plan real.
