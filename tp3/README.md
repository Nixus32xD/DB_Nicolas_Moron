# TP3 - Optimización de consultas

Este TP se ejecuta exclusivamente sobre la base aislada `foodstore_tp3`.

## Orden de ejecución

1. Crear la estructura con `schema.sql` y los datos mínimos de `sql/00_datos_iniciales.sql`.
2. Ejecutar `tp3/sql/01_carga_masiva.sql`.
3. Ejecutar `ANALYZE` (incluido en la carga) y medir `tp3/sql/02_consultas_base.sql`.
4. Aplicar los índices de `tp3/sql/03_indices_optimizacion.sql`.
5. Volver a ejecutar las mismas consultas y registrar los planes reales.
6. Verificar las consultas equivalentes de `tp3/sql/04_consultas_equivalentes.sql`.

Los planes y resultados reales se documentan en `tp3/informe_optimizacion.md` y `tp3/evidencias/`.
