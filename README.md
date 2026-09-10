# DB_Nicolas_Moron

Repositorio de trabajos prácticos de Base de Datos sobre el proyecto integrador **Food Store**.

**Alumno:** Nicolás Moron  
**Carrera:** Tecnicatura Universitaria en Programación a Distancia  
**Universidad:** Universidad Tecnológica Nacional  

## Contenido actual

### TP1 — Modelo y esquema
- `schema.sql`: esquema PostgreSQL base de Food Store.

### TP2 — Integridad, transacciones y concurrencia
- `protocolo_seguridad.md`
- `duia_parte_1.md`
- `duia_parte_2.md`
- `duia_parte_3.md`
- `informe_concurrencia.md`
- `ejercicio_lectura_critica.md`

Scripts:

```text
sql/
├── 00_datos_iniciales.sql
├── 01_restricciones_integridad.sql
├── 02_pruebas_restricciones.sql
└── 03_laboratorio_concurrencia.sql
```

Evidencias:

```text
evidencias/
└── README.md
```

## Flujo de trabajo

1. Trabajar sobre una copia local de la base.
2. Crear la estructura con `psql -d foodstore_tp2 -f schema.sql` y cargar los datos de laboratorio con `psql -d foodstore_tp2 -f sql/00_datos_iniciales.sql`.
3. Verificar la base activa con `SELECT current_database(), current_user;`.
4. Generar respaldo antes de cambios estructurales.
5. Revisar cualquier script generado por IA antes de ejecutarlo.
6. Probar cambios dentro de una transacción.
7. Ejecutar los escenarios de concurrencia con dos sesiones PostgreSQL.
8. Registrar únicamente resultados reales.
9. Revisar `git diff` antes de cada commit.

## Contexto de IA

`AGENTS.md` y `.kiro/steering/food-store.md` versionan las convenciones del esquema. Para este TP se utilizó Codex como agente de código, siguiendo el flujo de planificar, revisar el diff y verificar en PostgreSQL antes de confirmar cambios.

## Estado

Las restricciones y los tres escenarios obligatorios se ejecutaron realmente en PostgreSQL 18.6 el 10/09/2026. Las salidas resumidas están en `informe_concurrencia.md`, las DUIA y `evidencias/`.

El escenario de interbloqueo permanece opcional y no se declara como ejecutado ni versionado hasta contar con su evidencia real.
