# Cambios de la fábrica

Cada mejora del método sube la versión de `plugins/fabrica/.claude-plugin/plugin.json` y deja una línea aquí.

## 0.3.1 — 2026-10-10
- Lecciones (GitHub): copiar un Project privado pide rol Write; la copia trae los workflows encendidos con la configuración por omisión.

## 0.3.0 — 2026-10-10
- Script `scripts/tablero.sh`: única implementación de las consultas del Project. `activas` (la consulta de la vista "Esta semana", que ahora usa `/estado`), `copiar` (copia vacía del tablero con `copyProjectV2`, sin borradores, y verifica 0 ítems) y `contar`.
- README: el tablero es el GitHub Project; receta para crearlo en otra cuenta, qué copia `copyProjectV2` y qué se hace a mano (workflows, campo Labels), y el paso de la etiqueta `🤖 trabajando` para la Action de Claude.

## 0.2.2 — 2026-10-09
- Lecciones: sección "Action de Claude en GitHub" (token de setup-token en dos renglones, la App no toca workflows, comandos exactos en el prompt, CI que no corre tests, costo de las tareas chicas).

## 0.2.1 — 2026-10-09
- Lecciones: sección GitHub (el `Status` de un Project no se renombra; vistas por API sin agrupado).

## 0.2.0 — 2026-10-09
- Comando `/bandeja <idea>`: convierte una idea suelta en un issue armado con la plantilla, en el repo de su app (o en `fabrica-config` si no tiene), con la etiqueta `bandeja`, y lo suma al Project.
- Comando `/estado`: tabla de las apps activas del Project con lo que avanzó en 7 días, lo que espera al dueño y lo bloqueado.
- Método: sección "Project y etiquetas" (campos Prioridad, Estado, App, Nivel y Requiere OK; etiquetas `tarea`, `nivel-*`, `requiere-ok`, `espera-ok` y `bandeja`). `/cerrar` pone `espera-ok` cuando la tarea queda esperando merge.

## 0.1.0 — 2026-10-09
- Primera versión: skill `metodo` (principios, ciclo de tarea, OK por niveles, costo, producción, revisiones), lecciones genéricas, skill `aprender` (ciclo de mejora), comandos `/retomar`, `/cerrar`, `/aprender`, `/consolidar` y `/revisar`, agente `explorador`, hook que carga `fabrica-config` y plantillas (issue, AGENTS.md, scorecard).
