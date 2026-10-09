---
name: aprender
description: Ciclo de mejora de la fábrica. Úsalo cuando algo falló, costó más de lo esperado, el dueño corrigió tu forma de trabajar, descubriste algo no obvio de un sistema, o al cerrar una tarea; también con /aprender y /consolidar. Convierte lo aprendido en un PR al repo correcto (método genérico o configuración de la empresa).
---

# Aprender: lo que descubrimos vuelve al método

```
algo pasó (falla, costo, corrección del dueño, dato no obvio)
   │
   ▼
¿Serviría en OTRA empresa, sin nombres, IPs ni datos de esta?
   ├── sí → repo fabrica          (método genérico, del dueño)
   └── no → repo fabrica-config   (contexto de la empresa)
   │
   ▼
rama claude/aprender-<tema> → editar → PR → el dueño hace merge
   │
   ▼
desde la siguiente sesión o Action, todos trabajan con la regla nueva
```

## Dónde están los repos

| Repo | Ruta local (por defecto) | Variable para cambiarla |
|---|---|---|
| `fabrica` (método) | `~/Documents/GitHub/fabrica` | `FABRICA_REPO` |
| `fabrica-config` (empresa) | `~/Documents/GitHub/fabrica-config` | `FABRICA_CONFIG` |

El plugin instalado es una copia en caché: **no edites `${CLAUDE_PLUGIN_ROOT}`**, edita el clon del repo.

## Qué escribir y dónde

| Tipo de aprendizaje | Archivo |
|---|---|
| Lección genérica (deploy, costo, datos, trato con el dueño) | `fabrica/plugins/fabrica/skills/metodo/lecciones.md` |
| Cambia una regla del método | `fabrica/plugins/fabrica/skills/metodo/SKILL.md` (edita la regla; no agregues otra que la contradiga) |
| Mejora un comando o el agente | `fabrica/plugins/fabrica/commands/…` o `agents/…` |
| Dato o regla propia de la empresa | `fabrica-config/lecciones.md` o `fabrica-config/CONTEXTO.md` |
| Decisión importante del dueño | `fabrica-config/decisiones/AAAA-MM-DD-<tema>.md` |

Formato de una lección: **qué pasó** (una línea, con el hecho concreto) · **regla** (qué hacer distinto) · **(AAAA-MM)**.

## Pasos

1. Escribe la lección en una o dos líneas y clasifícala (genérica o de la empresa). Si dudas, pregunta.
2. Revisa que no exista ya. Si existe, mejórala en lugar de duplicarla; si la contradice, cambia la vieja.
3. En el clon correcto: actualiza la rama principal, crea `claude/aprender-<tema>`, edita y haz commit (`aprender: <tema>`).
4. Si tocaste el plugin, sube la versión de parche en `plugins/fabrica/.claude-plugin/plugin.json` y agrega una línea en `CHANGELOG.md`, para que las instalaciones vean la actualización.
5. Haz push y abre el PR con `gh` usando la cuenta que tiene acceso a ese repo. **No hagas merge**: lo hace el dueño.
6. Dile al dueño en una línea qué aprendimos y dónde quedó el PR.

## Reglas

- **Nada de la empresa en `fabrica`**: ni nombres de servidores, IPs, dominios, apps, personas ni datos. Si la lección los necesita, va en `fabrica-config`.
- **Nunca secretos** en ninguno de los dos repos.
- Una lección vale si cambia lo que se hace. "Hay que tener cuidado" no es una regla.
- Mejor una lección corta y concreta que un párrafo.
