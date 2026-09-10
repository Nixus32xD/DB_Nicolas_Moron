# Food Store - convenciones de steering

## Esquema

- Motor: PostgreSQL.
- Tablas y columnas en `snake_case` y nombres en singular.
- Claves primarias: `BIGINT GENERATED ALWAYS AS IDENTITY`.
- Relaciones explícitas mediante claves foráneas con `ON DELETE RESTRICT`.
- Las bajas se representan con `activo`; no se elimina información histórica sin una revisión explícita.

## Trabajo seguro con IA

1. Antes de escribir, describir el plan y los archivos a modificar.
2. Revisar el diff completo antes de aplicar DDL o DML.
3. Ejecutar sobre una copia de trabajo, dentro de una transacción.
4. Crear respaldo antes de cambios estructurales.
5. Registrar solo resultados confirmados por PostgreSQL.

## Contexto de uso

Este archivo deja disponibles las convenciones para Kiro. En este TP, el usuario eligió Codex como agente de código para aplicar el mismo flujo de planificación, revisión y verificación.
