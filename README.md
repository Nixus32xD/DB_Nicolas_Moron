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
├── 01_restricciones_integridad.sql
├── 02_pruebas_restricciones.sql
├── 03_laboratorio_concurrencia.sql
└── 04_interbloqueo_opcional.sql
```

Evidencias:

```text
evidencias/
└── README.md
```

## Flujo de trabajo

1. Trabajar sobre una copia local de la base.
2. Verificar la base activa con `SELECT current_database(), current_user;`.
3. Generar respaldo antes de cambios estructurales.
4. Revisar cualquier script generado por IA antes de ejecutarlo.
5. Probar cambios dentro de una transacción.
6. Ejecutar los escenarios de concurrencia con dos sesiones PostgreSQL.
7. Registrar únicamente resultados reales.
8. Revisar `git diff` antes de cada commit.

## Estado

La estructura y los scripts están preparados.  
Las secciones marcadas como `EVIDENCIA REAL A COMPLETAR` deben completarse con resultados obtenidos realmente en PostgreSQL antes de la entrega.
