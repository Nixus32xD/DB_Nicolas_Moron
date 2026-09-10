# Commits a realizar

La idea es que el historial muestre el proceso del TP, no un único commit con todo terminado.

## 0. Inicializar el repositorio

```bash
git init
git branch -M main
```

Si ya creaste el repositorio vacío en GitHub:

```bash
git remote add origin https://github.com/TU_USUARIO/DB_Nicolas_Moron.git
```

## 1. Esquema base del proyecto

```bash
git add README.md .gitignore AGENTS.md schema.sql
git commit -m "chore: inicializar repositorio y esquema Food Store"
```

## 2. Protocolo de seguridad

```bash
git add protocolo_seguridad.md
git commit -m "docs: agregar protocolo de copia transaccion y respaldo"
```

## 3. Restricciones de integridad

Primero:

```bash
git diff
```

Después:

```bash
git add sql/01_restricciones_integridad.sql sql/02_pruebas_restricciones.sql duia_parte_1.md
git commit -m "feat: agregar restricciones de integridad de Food Store"
```

## 4. Laboratorio de concurrencia

Después de ejecutar las pruebas y completar los resultados reales:

```bash
git add sql/03_laboratorio_concurrencia.sql informe_concurrencia.md duia_parte_2.md
git commit -m "test: documentar escenarios de concurrencia en PostgreSQL"
```

## 5. Lectura crítica

```bash
git add ejercicio_lectura_critica.md duia_parte_3.md
git commit -m "docs: analizar y corregir scripts SQL peligrosos"
```

## 6. Interbloqueo opcional

Solo si realmente lo ejecutás:

```bash
git add sql/04_interbloqueo_opcional.sql
git commit -m "test: agregar escenario opcional de interbloqueo"
```

## 7. Evidencias finales

Una vez que tengas capturas/salidas reales:

```bash
git add evidencias/
git commit -m "docs: agregar evidencias reales de ejecucion del TP2"
```

## 8. Comprobación

```bash
git status
git log --oneline --decorate
```

El repositorio debería quedar sin cambios pendientes.

## 9. Subir a GitHub

```bash
git push -u origin main
```

## Historial esperado aproximado

```text
xxxxxxx docs: agregar evidencias reales de ejecucion del TP2
xxxxxxx docs: analizar y corregir scripts SQL peligrosos
xxxxxxx test: documentar escenarios de concurrencia en PostgreSQL
xxxxxxx feat: agregar restricciones de integridad de Food Store
xxxxxxx docs: agregar protocolo de copia transaccion y respaldo
xxxxxxx chore: inicializar repositorio y esquema Food Store
```

El commit del interbloqueo aparecería únicamente si realizás el ejercicio opcional.
