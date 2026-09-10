# DUIA — Parte 1: Integridad versionada

**Alumno:** Nicolás Moron

| Campo | Contenido |
|---|---|
| Herramienta | OpenCode / modelo configurado por el alumno |
| Spec o prompt utilizado | Ver prompt propuesto debajo |
| Qué generó | Restricciones declarativas sobre `pedido_detalle` y casos de prueba |
| Qué se aceptó | Completar después de revisar el diff real |
| Qué se modificó o descartó, y por qué | Completar después de revisar el diff real |
| Verificación realizada | Completar con INSERT válidos e inválidos ejecutados realmente |

## Prompt propuesto para usar textualmente en OpenCode

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

Resultado real:

```text
EVIDENCIA REAL A COMPLETAR
```

### Cantidad inválida

```sql
INSERT INTO pedido_detalle
    (pedido_id, producto_id, cantidad, precio_unitario)
VALUES
    (2, 3, 0, 800.00);
```

Resultado real:

```text
EVIDENCIA REAL A COMPLETAR
```

### Precio inválido

```sql
INSERT INTO pedido_detalle
    (pedido_id, producto_id, cantidad, precio_unitario)
VALUES
    (2, 3, 1, -50.00);
```

Resultado real:

```text
EVIDENCIA REAL A COMPLETAR
```

### Producto duplicado

```sql
INSERT INTO pedido_detalle
    (pedido_id, producto_id, cantidad, precio_unitario)
VALUES
    (1, 1, 1, 1050.00);
```

Resultado real:

```text
EVIDENCIA REAL A COMPLETAR
```
