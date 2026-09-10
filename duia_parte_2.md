# DUIA — Parte 2: Concurrencia

**Alumno:** Nicolás Moron

| Campo | Contenido |
|---|---|
| Herramienta | Codex (ChatGPT) para la explicación; PostgreSQL 18.6 para la verificación. |
| Prompt utilizado | Ver debajo |
| Qué generó | Explicaciones sobre MVCC, snapshots y bloqueos |
| Qué se aceptó | La explicación de snapshots por sentencia en `READ COMMITTED`, el snapshot estable de `REPEATABLE READ` y el bloqueo de `FOR UPDATE`. |
| Qué se modificó o descartó | No se registraron valores de referencia como si fueran evidencia. Se conservaron solo las salidas obtenidas en las dos conexiones. |
| Verificación realizada | Tres experimentos con dos conexiones `psql` contra `foodstore_tp2` el 10/09/2026. |

## Prompt propuesto

> Estoy reproduciendo un escenario de concurrencia en PostgreSQL con dos sesiones. Voy a pegar los comandos exactos y la salida real. Explicá qué ocurrió, qué mecanismo de MVCC o bloqueo intervino y qué nivel de aislamiento o mecanismo evitaría el fenómeno. No des por confirmado nada que no se pueda contrastar con la salida del motor.

## Escenarios

1. Lectura no repetible.
2. Lectura fantasma.
3. Espera por bloqueo.

## Registro de verificación

| Escenario | ¿La IA acertó? | Comprobación en PostgreSQL |
|---|---|---|
| Lectura no repetible | Sí | En `READ COMMITTED`, el precio fue de `1050.00` a `1150.00`; en `REPEATABLE READ` permaneció en `1050.00`. |
| Lectura fantasma | Sí | En `READ COMMITTED`, el `COUNT` pasó de `2` a `3`; en `REPEATABLE READ` permaneció en `3` aunque otra sesión insertó una fila. |
| Espera por bloqueo | Sí | La segunda sesión pidió el lock a las `08:53:23.855485-03` y lo obtuvo a las `08:53:25.887246-03`, después del `COMMIT` de la primera. |
