---
description: Estado de las apps activas del Project — qué avanzó, qué espera al dueño y qué está bloqueado
allowed-tools: Bash(gh project item-list:*), Bash(gh project list:*), Bash(gh issue list:*), Bash(gh pr list:*), Read
---

## Tu tarea

Sigue el método (skill `metodo`). Es solo lectura: no cambies issues ni el Project.

1. Toma del contexto de la empresa el **Project** (dueño y número). Si no está, dilo y detente.
2. Lee los items activos sin volcar JSON al chat, filtrando con `--jq`:
   `gh project item-list <número> --owner <dueño> --limit 500 --format json --query 'is:open prioridad:"🟢 Activa"'`
   (los campos del Project llegan como llaves en minúscula: `prioridad`, `estado`, `app`; si cambian, míralas una vez con `--jq '.items[0]'`).
3. Para cada repo de esas apps, mira lo de los **últimos 7 días**:
   - PRs fusionados: `gh pr list -R <repo> --state merged --search "merged:>=<fecha>"`
   - Issues cerrados: `gh issue list -R <repo> --state closed --search "closed:>=<fecha>"`
   - PRs abiertos: `gh pr list -R <repo> --state open`
4. Responde con **una tabla**, una fila por app activa:

   | App | Avanzó (7 días) | Espera al dueño | Bloqueado |
   |---|---|---|---|

   - **Avanzó:** PRs fusionados e issues cerrados, con su número.
   - **Espera al dueño:** issues con la etiqueta `espera-ok` o en estado "En revisión", y PRs abiertos listos para revisar. Di qué tiene que hacer (merge, OK, decisión).
   - **Bloqueado:** estado "Bloqueada", con el motivo en pocas palabras.
   - Celda vacía = `—`. Referencias como `repo#n`.
5. Debajo, **dos líneas como máximo**: si hay más de 3 apps activas, dilo; y qué conviene que el dueño apruebe primero (lo que destraba más trabajo).
