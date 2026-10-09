---
description: Convertir una idea suelta en un issue bien armado en el repo correcto
argument-hint: "<idea>"
allowed-tools: Bash(git remote:*), Bash(gh issue list:*), Bash(gh issue create:*), Bash(gh label list:*), Bash(gh label create:*), Bash(gh project item-add:*), Read, Grep, Glob
---

## Contexto

- Repo actual: !`git remote get-url origin 2>/dev/null || echo "sin remoto"`

## Tu tarea

Idea: $ARGUMENTS

Si no viene idea, pídela en una línea y detente. Sigue el método (skill `metodo`).

1. **Repo.** Elige dónde va con la tabla de apps del contexto de la empresa:
   - si la idea nombra una app (o se entiende cuál), el repo de esa app;
   - si no, y el repo actual es de una app, ese;
   - si no tiene app (infraestructura, varias apps, el método), el repo de configuración de la empresa (`fabrica-config`).
   Si dudas entre dos, pregunta antes de crear nada.
2. **Duplicados.** Busca en los issues abiertos de ese repo (`gh issue list --search "<palabras clave>"`). Si ya existe, muéstralo y no crees otro.
3. **Armar el issue** con la plantilla `plantillas/issue-tarea.md` de este plugin: por qué · hacer · listo cuando · cómo probar · requiere OK · nivel · depende de.
   - Lo que no se sepa, déjalo como pregunta para el dueño (`¿…?`). No inventes alcance.
   - Si no cabe en 5 viñetas de "hacer", propón dividirla en el cuerpo.
   - Título `<ID>: <qué se hace>`, con el siguiente ID libre del prefijo de la app (míralo en los títulos de los issues del repo, abiertos y cerrados). Si la app no tiene prefijo, sin ID.
4. **Etiquetas:** siempre `bandeja` y `tarea`; además `nivel-A`/`nivel-B`/`nivel-C` y `requiere-ok` si ya se sabe. Si una etiqueta no existe en el repo, créala.
5. **Crear y sumar al Project** de la empresa (dueño y número en el contexto) con `gh project item-add`. No le pongas prioridad: la decide el dueño.
6. Responde en **una línea**: repo, título y enlace al issue.

En el cuerpo, no escribas `@usuario` ni menciones a bots: una mención puede disparar una automatización.
