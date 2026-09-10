# Informe de concurrencia

**Alumno:** Nicolás Moron  
**Motor:** PostgreSQL  
**Base de trabajo:** `foodstore_tp2`

> Ejecución real: 10/09/2026, PostgreSQL 18.6, dos conexiones `psql` independientes con el usuario `postgres`.

---

## Escenario 1 — Lectura no repetible

### Cómo se reprodujo

Archivo utilizado:

`sql/03_laboratorio_concurrencia.sql`

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

Primera lectura:

```text
precio = 1050.00
```

Segunda lectura:

```text
precio = 1150.00
```

### Explicación de la IA

En PostgreSQL, `READ COMMITTED` toma un snapshot nuevo al comienzo de cada sentencia. Por eso dos `SELECT` ejecutados dentro de la misma transacción pueden observar versiones distintas de una fila si otra transacción confirma una modificación entre ambas consultas.

### Verificación en el motor

Se repite el experimento utilizando:

```sql
SET TRANSACTION ISOLATION LEVEL REPEATABLE READ;
```

```text
Sesión A, primera lectura:  precio = 1050.00
Sesión B: UPDATE 1; COMMIT
Sesión A, segunda lectura:  precio = 1050.00
```

### Conclusión

```text
La explicación se confirmó. `REPEATABLE READ` conservó el snapshot de la transacción A y evitó que la segunda lectura viera el `COMMIT` de B.

---

## Escenario 2 — Lectura fantasma

### Cómo se reprodujo

Archivo:

`sql/03_laboratorio_concurrencia.sql`

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

```text
COUNT inicial:   2
COUNT posterior: 3
```

### Explicación de la IA

Con `READ COMMITTED`, cada sentencia puede observar un snapshot distinto. Una fila insertada y confirmada por otra sesión puede aparecer en una consulta posterior que utiliza el mismo predicado.

### Verificación en el motor

Repetir con:

```sql
SET TRANSACTION ISOLATION LEVEL REPEATABLE READ;
```

```text
Sesión A, COUNT inicial:   3
Sesión B: INSERT 0 1; COMMIT
Sesión A, COUNT posterior: 3
```

### Conclusión

La explicación se confirmó. `REPEATABLE READ` mantuvo el mismo snapshot aunque B insertó `Especial TP2 RR` y confirmó la operación.

---

## Escenario 3 — Espera por bloqueo

### Cómo se reprodujo

Archivo:

`sql/03_laboratorio_concurrencia.sql`

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

```text
Sesión A obtuvo el lock sobre producto id=1 y mantuvo la transacción abierta.
Sesión B intentó obtenerlo a las 08:53:23.855485-03.
Sesión B lo obtuvo a las 08:53:25.887246-03, luego del COMMIT de A.
Espera observada: aproximadamente 2.032 segundos.
```

### Explicación de la IA

`FOR UPDATE` adquiere un bloqueo de fila incompatible con otro intento de bloqueo para actualización sobre la misma versión lógica. La segunda sesión debe esperar a que la primera termine.

### Verificación en el motor

En la Sesión A:

```sql
COMMIT;
```

La Sesión B debería continuar después de liberarse el bloqueo.

```text
La consulta `SELECT ... FOR UPDATE` de B devolvió la fila id=1, stock=20 y luego pudo hacer COMMIT.
```

### Conclusión

La explicación se confirmó. El mecanismo involucrado fue el bloqueo de fila adquirido por `SELECT ... FOR UPDATE`; el `COMMIT` de A lo liberó.

---

## Síntesis

Los tres escenarios fueron reproducidos en el motor real. `READ COMMITTED` permitió la lectura no repetible y la aparición de una fila fantasma entre sentencias; `REPEATABLE READ` estabilizó el snapshot. `SELECT ... FOR UPDATE` hizo que la segunda sesión esperara la liberación del lock.
