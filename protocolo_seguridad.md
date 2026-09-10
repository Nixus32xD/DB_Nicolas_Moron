# Protocolo de seguridad

Este protocolo se aplica antes de ejecutar scripts propios o generados por IA.

## 1. Copia

Las pruebas se realizan exclusivamente sobre una base local de trabajo.

Ejemplo:

```bash
createdb foodstore_tp2
psql -d foodstore_tp2 -f sql/schema.sql
psql -d foodstore_tp2 -f sql/datos_iniciales.sql
```

Si se parte de una base plantilla local:

```bash
createdb -T foodstore foodstore_tp2
```

Nunca se realizan estas pruebas directamente sobre producción.

## 2. Transacción

Todo script que escriba datos se prueba inicialmente dentro de una transacción.

```sql
BEGIN;

-- script a probar

ROLLBACK;
```

Una vez verificado el resultado:

```sql
BEGIN;

-- script validado

COMMIT;
```

Para DDL que se desea inspeccionar sin confirmar:

```sql
BEGIN;

-- ALTER TABLE / CREATE TRIGGER / etc.

-- ejecutar pruebas

ROLLBACK;
```

## 3. Respaldo

Antes de cambios estructurales:

```bash
pg_dump foodstore_tp2 > backup_foodstore_tp2.sql
```

Restauración de ejemplo:

```bash
dropdb foodstore_tp2
createdb foodstore_tp2
psql -d foodstore_tp2 < backup_foodstore_tp2.sql
```

## Verificación previa

Antes de ejecutar cualquier script:

```sql
SELECT current_database(), current_user;
```

Esto reduce el riesgo de ejecutar accidentalmente un script sobre otra base.
