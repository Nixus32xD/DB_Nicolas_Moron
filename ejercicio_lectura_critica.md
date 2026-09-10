# Ejercicio de lectura crítica

**Alumno:** Nicolás Moron

## Script 1

Script original:

```sql
UPDATE funcion
SET activa = FALSE;
```

### Qué filas afectaría realmente

Afectaría **todas las filas** existentes en la tabla `funcion`, porque el `UPDATE` no contiene cláusula `WHERE`.

### Por qué no coincide con la consigna

La intención indicada es dar de baja únicamente funciones correspondientes a películas retiradas de cartel. El script no limita la operación a ese subconjunto.

### Versión corregida

La guía no proporciona el esquema completo de `funcion` ni el atributo exacto que identifica una función retirada. Por eso no corresponde inventar una columna concreta.

La forma correcta es:

```sql
UPDATE funcion
SET activa = FALSE
WHERE <condición_real_que_identifica_funciones_retiradas>;
```

Antes de ejecutarlo se debe reemplazar el marcador por la condición real del esquema y comprobarla primero con un `SELECT`.

Ejemplo de validación:

```sql
SELECT *
FROM funcion
WHERE <condición_real_que_identifica_funciones_retiradas>;
```

---

## Script 2

Script original:

```sql
DELETE FROM categoria
WHERE id NOT IN (
    SELECT categoria_id
    FROM producto
);
```

### Qué filas intenta afectar

Busca eliminar categorías cuyo `id` no aparezca como `categoria_id` en `producto`.

### Riesgo

Si la subconsulta devuelve algún `NULL`, `NOT IN` puede producir `UNKNOWN` en las comparaciones debido a la lógica ternaria de SQL. Eso puede impedir que el filtro seleccione las filas esperadas.

### Versión corregida

```sql
DELETE FROM categoria c
WHERE NOT EXISTS (
    SELECT 1
    FROM producto p
    WHERE p.categoria_id = c.id
);
```

### Por qué es preferible

`NOT EXISTS` expresa directamente la regla: eliminar la categoría solamente cuando no existe ningún producto que la referencie.

En el proyecto Food Store del TP1 se prefiere la baja lógica de categorías, por lo que, si se adaptara este ejemplo al esquema propio, sería más coherente utilizar:

```sql
UPDATE categoria c
SET activo = FALSE
WHERE NOT EXISTS (
    SELECT 1
    FROM producto p
    WHERE p.categoria_id = c.id
);
```

Así se conserva el historial.
