# DUIA - TP3: Optimización de consultas

| Uso | Herramienta | Prompt o spec resumido | Decisión y verificación |
|---|---|---|---|
| Carga masiva | Codex (como agente de código) | Generar datos reproducibles con `generate_series`: 50.000 productos, 20.000 clientes y 200.000 pedidos con detalle, sin tocar otra base. | Se aceptó el uso de `generate_series` y se revisaron FK, `UNIQUE`, `CHECK` e IDs. Se ejecutó en `foodstore_tp3`, dentro de una transacción, y luego `ANALYZE`. |
| Optimización | Codex (como agente de código) | A partir de los planes reales, proponer índices mínimos para categoría/rango/orden, fecha descendente y búsqueda por prefijo. | Se aceptaron tres índices explicables. `EXPLAIN ANALYZE` confirmó mejoras de 18,17x, 99,16x y 26,72x. |
| Lectura crítica | Codex (como asistente de análisis) | Explicar nodo por nodo el plan posterior de pedidos recientes. | Se aceptó la explicación sobre el índice y el orden; se rechazaron dos afirmaciones imprecisas: costo no es tiempo real e `Index Scan` no es `Index Only Scan`. |
| Equivalencia | Codex (como agente de código) | Proponer una variante `LEFT JOIN`/subconsulta y otra `EXISTS`/`JOIN` para las mismas specs. | Se verificó formalmente con `EXCEPT` en ambas direcciones: 0 filas en los dos pares. |

## Flujo aplicado

Codex asumió el rol de agente de código elegido por el alumno. Se mantuvo el flujo de planificar, revisar el diff, ejecutar en una copia, medir en PostgreSQL y documentar el resultado real. `.kiro/steering/food-store.md` conserva las convenciones para Kiro.
