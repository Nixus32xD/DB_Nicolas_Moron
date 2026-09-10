# Informe de concurrencia

**Alumno:** Nicolás Moron  
**Motor:** PostgreSQL  
**Base de trabajo:** `foodstore_tp2`

> Este informe está preparado para completar con la salida real obtenida en las dos sesiones. No presentar como reales resultados que no hayan sido ejecutados.

---

## Escenario 1 — Lectura no repetible

### Cómo se reprodujo

Archivo utilizado:

`concurrencia/lectura_no_repetible.sql`

Se abrió una transacción en la Sesión A con `READ COMMITTED` y se consultó el precio del producto `id = 1`.  
Mientras la transacción seguía abierta, la Sesión B modificó ese precio y confirmó la operación.

### Comandos de Sesión A

```sql
BEGIN;
SET TRANSACTION ISOLATION LEVEL READ COMMITTED;

SELECT id, nombre, precio
FROM producto
WHERE id = 1;

-- después del COMMIT de B

SELECT id, nombre, precio
FROM producto
WHERE id = 1;

COMMIT;
```

### Comandos de Sesión B

```sql
BEGIN;

UPDATE producto
SET precio = precio + 100
WHERE id = 1;

COMMIT;
```

### Qué se observó

**EVIDENCIA REAL A COMPLETAR**

Primera lectura:

```text
PEGAR SALIDA REAL
```

Segunda lectura:

```text
PEGAR SALIDA REAL
```

### Explicación de la IA

En PostgreSQL, `READ COMMITTED` toma un snapshot nuevo al comienzo de cada sentencia. Por eso dos `SELECT` ejecutados dentro de la misma transacción pueden observar versiones distintas de una fila si otra transacción confirma una modificación entre ambas consultas.

### Verificación en el motor

Se repite el experimento utilizando:

```sql
SET TRANSACTION ISOLATION LEVEL REPEATABLE READ;
```

**EVIDENCIA REAL A COMPLETAR**

```text
PEGAR SALIDA REAL DE LA REPETICIÓN
```

### Conclusión

Completar después de verificar en PostgreSQL:

```text
¿La explicación se confirmó?:
Nivel/mecanismo que evitó el fenómeno:
```

---

## Escenario 2 — Lectura fantasma

### Cómo se reprodujo

Archivo:

`concurrencia/lectura_fantasma.sql`

La Sesión A ejecuta un `COUNT` de productos activos de una categoría. La Sesión B inserta una nueva fila que cumple la misma condición y confirma.

### Sesión A

```sql
BEGIN;
SET TRANSACTION ISOLATION LEVEL READ COMMITTED;

SELECT COUNT(*)
FROM producto
WHERE categoria_id = 1 AND activo = TRUE;

-- después del INSERT + COMMIT de B

SELECT COUNT(*)
FROM producto
WHERE categoria_id = 1 AND activo = TRUE;

COMMIT;
```

### Sesión B

```sql
BEGIN;

INSERT INTO producto
    (categoria_id, nombre, descripcion, precio, stock)
VALUES
    (1, 'Fugazzeta TP2', 'Fila creada para el laboratorio', 1600.00, 20);

COMMIT;
```

### Qué se observó

**EVIDENCIA REAL A COMPLETAR**

```text
COUNT inicial:
COUNT posterior:
```

### Explicación de la IA

Con `READ COMMITTED`, cada sentencia puede observar un snapshot distinto. Una fila insertada y confirmada por otra sesión puede aparecer en una consulta posterior que utiliza el mismo predicado.

### Verificación en el motor

Repetir con:

```sql
SET TRANSACTION ISOLATION LEVEL REPEATABLE READ;
```

**EVIDENCIA REAL A COMPLETAR**

```text
PEGAR RESULTADOS
```

### Conclusión

```text
¿La explicación se confirmó?:
Nivel/mecanismo que evitó el fenómeno:
```

---

## Escenario 3 — Espera por bloqueo

### Cómo se reprodujo

Archivo:

`concurrencia/espera_por_bloqueo.sql`

Dos sesiones intentan bloquear la misma fila con `SELECT ... FOR UPDATE`.

### Sesión A

```sql
BEGIN;

SELECT id, nombre, stock
FROM producto
WHERE id = 1
FOR UPDATE;
```

### Sesión B

```sql
BEGIN;

SELECT id, nombre, stock
FROM producto
WHERE id = 1
FOR UPDATE;
```

### Qué se observó

**EVIDENCIA REAL A COMPLETAR**

```text
Hora aproximada de inicio:
Tiempo que B permaneció esperando:
Qué ocurrió después del COMMIT/ROLLBACK de A:
```

### Explicación de la IA

`FOR UPDATE` adquiere un bloqueo de fila incompatible con otro intento de bloqueo para actualización sobre la misma versión lógica. La segunda sesión debe esperar a que la primera termine.

### Verificación en el motor

En la Sesión A:

```sql
COMMIT;
```

La Sesión B debería continuar después de liberarse el bloqueo.

**EVIDENCIA REAL A COMPLETAR**

```text
PEGAR RESULTADO REAL
```

### Conclusión

```text
¿La explicación se confirmó?:
Mecanismo involucrado:
```

---

## Síntesis

La conclusión definitiva debe completarse después de ejecutar los tres experimentos.

```text
EVIDENCIA REAL A COMPLETAR
```
