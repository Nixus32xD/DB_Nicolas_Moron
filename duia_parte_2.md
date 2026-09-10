# DUIA — Parte 2: Concurrencia

**Alumno:** Nicolás Moron

| Campo | Contenido |
|---|---|
| Herramienta | IA utilizada para explicar los escenarios; PostgreSQL para verificarlos |
| Prompt utilizado | Ver debajo |
| Qué generó | Explicaciones sobre MVCC, snapshots y bloqueos |
| Qué se aceptó | Solamente lo confirmado en el motor |
| Qué se modificó o descartó | Completar después de comparar explicación y resultado |
| Verificación realizada | Tres experimentos con dos sesiones concurrentes |

## Prompt propuesto

> Estoy reproduciendo un escenario de concurrencia en PostgreSQL con dos sesiones. Voy a pegar los comandos exactos y la salida real. Explicá qué ocurrió, qué mecanismo de MVCC o bloqueo intervino y qué nivel de aislamiento o mecanismo evitaría el fenómeno. No des por confirmado nada que no se pueda contrastar con la salida del motor.

## Escenarios

1. Lectura no repetible.
2. Lectura fantasma.
3. Espera por bloqueo.

## Registro de verificación

```text
EVIDENCIA REAL A COMPLETAR

Escenario 1:
¿La IA acertó?:
Qué comprobó PostgreSQL:

Escenario 2:
¿La IA acertó?:
Qué comprobó PostgreSQL:

Escenario 3:
¿La IA acertó?:
Qué comprobó PostgreSQL:
```
