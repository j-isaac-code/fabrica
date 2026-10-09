---
description: Dónde quedó el trabajo de este repo y cuál es la siguiente tarea
allowed-tools: Bash(git:*), Bash(gh issue list:*), Bash(gh pr list:*), Bash(gh project:*), Read, Grep, Glob
---

## Contexto

- Repo: !`git remote get-url origin 2>/dev/null || echo "sin remoto"`
- Rama actual: !`git branch --show-current 2>/dev/null`
- Últimos commits: !`git log --oneline -5 2>/dev/null`
- Issues abiertos: !`gh issue list --state open --limit 30 --json number,title,labels --jq '.[] | "#\(.number) \(.title) [\([.labels[].name] | join(", "))]"' 2>/dev/null || echo "no se pudieron leer los issues"`
- PRs abiertos: !`gh pr list --state open --json number,title,headRefName,reviewDecision --jq '.[] | "#\(.number) \(.title) (\(.headRefName)) \(.reviewDecision)"' 2>/dev/null || echo "no se pudieron leer los PRs"`

## Tu tarea

Sigue el método (skill `metodo`). Con lo de arriba y el contexto de la empresa que cargó el hook de inicio:

1. Di en **3 líneas** dónde quedó esta app: lo hecho, lo que espera al dueño (PRs o OK pendientes) y lo bloqueado.
2. Propón **la siguiente tarea**: la de mayor prioridad que no esté bloqueada, con su número de issue. Si la app no está como activa en el Project, dilo.
3. **No arranques** hasta que el dueño diga "dale". No saltes a otra app.

Si no hay issues porque la app todavía usa otro sistema de tareas, dilo y usa lo que diga el contexto de la empresa.
