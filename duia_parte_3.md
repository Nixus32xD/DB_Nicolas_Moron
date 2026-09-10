# DUIA — Parte 3: Lectura crítica

**Alumno:** Nicolás Moron

| Campo | Contenido |
|---|---|
| Herramienta | ChatGPT / IA utilizada por el alumno |
| Prompt utilizado | Ver debajo |
| Qué generó | Análisis de efecto real y corrección de dos scripts |
| Qué se aceptó | El diagnóstico del `UPDATE` sin `WHERE` y la recomendación de `NOT EXISTS` |
| Qué se modificó o descartó | No se inventó la columna necesaria para corregir el Script 1 porque la guía no especifica el esquema |
| Verificación realizada | Revisión manual; no se ejecutaron los scripts peligrosos sobre datos importantes |

## Prompt registrado

> Analizá los dos scripts SQL del ejercicio de lectura crítica. Para cada uno indicá qué filas afectaría realmente, por qué no coincide con la intención declarada y cómo debería corregirse. No inventes columnas que no aparezcan en la consigna. En el caso de `NOT IN`, explicá el impacto de valores NULL y proponé una alternativa segura.

## Decisión humana

El Script 1 no puede recibir una condición concreta sin conocer la columna real que representa que una función fue retirada. Se conserva un marcador explícito en lugar de inventar el esquema.

El Script 2 se reescribe con `NOT EXISTS`. Para Food Store, además, se documenta que una baja lógica sería más consistente con el modelo de la Semana 1.
