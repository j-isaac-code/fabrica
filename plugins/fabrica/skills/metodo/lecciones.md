# Lecciones genéricas

Lo que aprendimos trabajando y sirve en cualquier empresa. Cada lección dice **qué pasó**, **la regla** y **desde cuándo**. Lo específico de una empresa (servidores, apps, nombres) va en `fabrica-config/lecciones.md`, no aquí.

Para agregar una: `/aprender`. Para depurar: `/consolidar`.

## Costo y contexto

- **Lo caro es el historial, no la salida** (2026-10). En un día de trabajo, la lectura de caché pesó cientos de veces más que lo escrito, y más del 90% del uso fue con más de 150k de contexto. Regla: tareas cortas que arrancan limpias; cambiar de sesión antes de ~100-150k; el estado siempre en el issue.
- **Muchos subagentes en paralelo agotan el plan** (2026-09). Unos 15 subagentes con el modelo caro acabaron con el límite en horas, y cada uno arranca en frío y relee todo. Regla: de uno en uno, el modelo barato para lo mecánico, y lo chico sin subagente.
- **Varias sesiones de código a la vez multiplican el costo** (2026-10). Regla: máximo 3 sesiones de código simultáneas.
- **Los worktrees sin explicar confunden al dueño** (2026-09). Aparecieron carpetas sueltas en su Finder. Regla: avisar antes de crearlos y borrarlos después del merge.

## Trabajo con el dueño

- **No repetir lo que ya pasó** (2026-10). Se le volvió a explicar un deploy que otra sesión ya había hecho. Regla: antes de explicar o pedir algo, revisar el issue, el PR y las otras sesiones.
- **Una conversación por app agota; un solo chat para todo pierde contexto** (2026-09). Regla: la tarea es la unidad (issue → rama → PR); las conversaciones son desechables.
- **Un editor abierto trabó un deploy** (2026-09). Regla: los merges que se le pasan al dueño llevan `--no-edit`.

## Datos

- **Una sola implementación de cada consulta** (2026-10). Tener el código duplicado por motor de base de datos divergió, y dos bases vivas en producción se desfasaron semanas sin que nadie lo notara. Regla: una capa de datos (p. ej. un query builder), un solo motor en producción, y tests también contra el motor de producción antes del merge.

## GitHub

- **El `Status` de un Project no se renombra y cambiarle opciones borra valores** (2026-10). `updateProjectV2Field` aceptó las opciones nuevas pero ignoró el nombre, y el script falló al buscar "Estado". Regla: usar `Status` como campo de estado; cambiar las opciones de un campo de selección solo antes de poner valores, y en scripts idempotentes no volver a tocarlas si ya están.
- **Las vistas de un Project sí se crean por API, el agrupado no** (2026-10). `createProjectV2View` + `updateProjectV2View` (con `filter`) crean tablas y tableros; agrupar o elegir las columnas del tablero se hace a mano. Regla: crear las vistas por script y dejarle al dueño solo el agrupado, dicho en el PR.
- **Copiar un Project privado pide rol Write** (2026-10). Con el colaborador en Read, `copyProjectV2` respondió "You do not have permission to copy this project"; con Write funcionó. Regla: dar Write temporal a la cuenta que copia y quitarlo (rol `NONE`) en el mismo comando.
- **La copia de un Project trae todos sus workflows encendidos y con la configuración por omisión** (2026-10), aunque en el origen estén apagados o configurados. Regla: después de copiar, revisar a mano cada workflow (estado destino) y apagar los que no se usan; la API no deja configurarlos.

## Action de Claude en GitHub

- **El token de `claude setup-token` sale partido en dos renglones** (2026-10). Se pegó con el salto en medio y la primera corrida falló en 2 s, sin gastar tokens y sin mostrar el error. Regla: al guardarlo, quitarle los espacios y saltos (`pbpaste | tr -d '[:space:]'`) y probarlo antes con `CLAUDE_CODE_OAUTH_TOKEN=… claude -p "ok"`.
- **La App de Claude no puede tocar `.github/workflows`** (2026-10). Claude intentó agregar un paso al CI y el push fue rechazado. Regla: los cambios de workflow los hace una sesión, no la Action; si un issue los necesita, que la Action lo diga y se detenga.
- **El prompt de la Action debe nombrar los comandos exactos permitidos** (2026-10). Claude corrió `cd … && npm test` y `npm ci`, fuera de `--allowedTools`, y no abrió el PR. Regla: comandos sin `cd`, uno por línea (`uv run --directory <dir> …`, `npm --prefix <dir> run …`), los mismos en `--allowedTools` y en el prompt, y abrir siempre el PR (borrador si una prueba falla).
- **Un CI verde no prueba nada si no corre los tests** (2026-10). Un PR de tests nuevos salió verde porque el CI solo hacía lint y build. Regla: antes de aceptar el verde, revisar que el CI ejecute los tests del lado que se tocó.
- **Las tareas chicas por Action salen baratas** (2026-10). Tres issues de nivel A costaron ~US$ 0.84 equivalentes en total (10-24 turnos, menos de 2 min cada uno). Regla: lo chico y bien escrito va por Action; las sesiones largas, solo para lo que no cabe en un issue.

## Deploy y servidores

- **Deploy en un solo comando** (2026-10). Es lo que el dueño prefiere: respaldo → acción → verificación → instrucciones de reversa. El health debe decir el commit desplegado.
- **`pm2 update` puede vaciar la lista de procesos** (2026-10). Un front quedó caído unos minutos. Regla: después de `pm2 update` o de reiniciar pm2, revisar `pm2 ls` y, si está vacío, correr `pm2 resurrect` y luego `pm2 save`.
- **Subir Node rompe módulos nativos** (2026-10). `better-sqlite3` 11 abortó en bucle con Node 24 aunque la prueba de carga pasaba. Regla: antes de subir Node en un servidor, subir los módulos nativos y correr los tests con la versión nueva.
- **`set -e` y `c=$(curl …)` cortan los scripts de verificación** (2026-10). Regla: no combinarlos en verificaciones remotas que reintentan.
- **`docker build` se cuelga bajando la imagen base** en servidores chicos (2026-10). Regla: `docker pull` antes del build y `set -o pipefail`.
- **`pkill -f` con un patrón que aparece en el propio comando lo mata a sí mismo** (2026-10). Regla: usar el PID o un patrón que no esté en el comando.
- **Los túneles rápidos exponen servicios sin autenticación** (2026-10). Uno publicó una app interna sin login. Regla: nada público sin la capa de acceso de la empresa; revisar túneles en cada inventario.
