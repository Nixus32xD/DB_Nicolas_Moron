# DUIA — Parte 1: Integridad versionada

**Alumno:** Nicolás Moron

| Campo | Contenido |
|---|---|
| Herramienta | Codex (ChatGPT) para la propuesta y PostgreSQL 18.6 para la verificación. OpenCode no estaba instalado durante esta ejecución. |
| Spec o prompt utilizado | Ver prompt registrado debajo. |
| Qué generó | Restricciones declarativas sobre `pedido_detalle`, datos mínimos reproducibles y casos de prueba. |
| Qué se aceptó | Los dos `CHECK` y el `UNIQUE (pedido_id, producto_id)`. |
| Qué se modificó o descartó, y por qué | Se agregó `sql/00_datos_iniciales.sql` porque el esquema no cargaba los IDs que requerían las pruebas. No se agregaron triggers ni cambios destructivos. |
| Verificación realizada | Aplicación dentro de `BEGIN ... ROLLBACK`, aplicación final sobre la copia y cuatro casos ejecutados realmente. |

## Prompt registrado

> Revisá el esquema PostgreSQL del proyecto Food Store. Trabajá primero en modo Plan y no modifiques archivos todavía. Necesito garantizar en el motor estas tres reglas sobre `pedido_detalle`: `cantidad` debe ser mayor a cero, `precio_unitario` no puede ser negativo y dentro de un mismo `pedido_id` no puede repetirse el mismo `producto_id`. Proponé restricciones declarativas, evitá cambios destructivos y agregá casos de prueba válidos e inválidos. Después del plan voy a revisar el diff antes de aplicar nada.

## Verificación

Ejecutar dentro de una copia y una transacción.

### Caso válido

```sql
INSERT INTO pedido_detalle
    (pedido_id, producto_id, cantidad, precio_unitario)
VALUES
    (2, 1, 1, 1050.00);
```

Resultado observado el 10/09/2026 en `foodstore_tp2`:

```text
INSERT 0 1
id=2, pedido_id=2, producto_id=1, cantidad=1, precio_unitario=1050.00
ROLLBACK
```

### Cantidad inválida

```sql
INSERT INTO pedido_detalle
    (pedido_id, producto_id, cantidad, precio_unitario)
VALUES
    (2, 3, 0, 800.00);
```

Resultado observado:

```text
ERROR: el nuevo registro para la relación «pedido_detalle» viola la restricción
«chk_pedido_detalle_cantidad_positiva»
DETAIL: La fila que falla contiene (3, 2, 3, 0, 800.00).
ROLLBACK
```

### Precio inválido

```sql
INSERT INTO pedido_detalle
    (pedido_id, producto_id, cantidad, precio_unitario)
VALUES
    (2, 3, 1, -50.00);
```

Resultado observado:

```text
ERROR: el nuevo registro para la relación «pedido_detalle» viola la restricción
«chk_pedido_detalle_precio_no_negativo»
DETAIL: La fila que falla contiene (4, 2, 3, 1, -50.00).
ROLLBACK
```

### Producto duplicado

```sql
INSERT INTO pedido_detalle
    (pedido_id, producto_id, cantidad, precio_unitario)
VALUES
    (1, 1, 1, 1050.00);
```

Resultado observado:

```text
ERROR: llave duplicada viola restricción de unicidad
«uq_pedido_detalle_pedido_producto»
DETAIL: Ya existe la llave (pedido_id, producto_id)=(1, 1).
ROLLBACK
```
