# AGENTS.md

## Proyecto
Trabajo Práctico N.º 2 de Base de Datos II — Food Store.

## Convenciones
- Motor: PostgreSQL.
- Tablas y columnas: `snake_case`.
- PK: `BIGINT GENERATED ALWAYS AS IDENTITY`.
- FK explícitas con `REFERENCES`.
- Datos históricos: no alterar silenciosamente información facturada.
- Bajas lógicas: usar columna `activo`.
- Antes de DDL o DML generado por IA: copia + transacción + respaldo.
- No ejecutar comandos destructivos sin revisar su `WHERE`.
- No asumir que una operación funcionó: verificar la salida del motor.

## Regla operativa
Primero planificar y revisar. Después modificar.
