---
description: Cerrar la tarea actual — tests, PR, issue al día, resumen y lección
argument-hint: "[número de issue]"
allowed-tools: Bash(git:*), Bash(gh:*), Bash(npm test:*), Bash(npm run:*), Read, Grep, Glob
---

## Contexto

- Rama: !`git branch --show-current`
- Cambios contra la rama principal: !`git diff --stat origin/HEAD...HEAD 2>/dev/null | tail -15`
- Estado: !`git status --short | head -20`

## Tu tarea

Cierra la tarea del issue $ARGUMENTS siguiendo el método (skill `metodo`):

1. Corre los tests una vez. Si fallan, arréglalos o explica por qué; no abras un PR en rojo sin decirlo.
2. Haz commit y push de la rama `claude/…` y abre (o actualiza) el PR, enlazado al issue.
3. Comenta en el issue el resumen y deja su estado claro: "en revisión" si espera merge, o el bloqueo si no se pudo.
4. Dale al dueño el resumen en **5 líneas como máximo**: qué cambió (archivos clave) · cómo se probó · qué debe revisar · riesgos o pendientes · siguiente tarea sugerida.
5. Pregúntate si hubo una lección (algo que falló, costó caro, o un dato no obvio). Si la hubo, aplica la skill `aprender`.
