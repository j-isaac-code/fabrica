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

## Deploy y servidores

- **Deploy en un solo comando** (2026-10). Es lo que el dueño prefiere: respaldo → acción → verificación → instrucciones de reversa. El health debe decir el commit desplegado.
- **`pm2 update` puede vaciar la lista de procesos** (2026-10). Un front quedó caído unos minutos. Regla: después de `pm2 update` o de reiniciar pm2, revisar `pm2 ls` y, si está vacío, correr `pm2 resurrect` y luego `pm2 save`.
- **Subir Node rompe módulos nativos** (2026-10). `better-sqlite3` 11 abortó en bucle con Node 24 aunque la prueba de carga pasaba. Regla: antes de subir Node en un servidor, subir los módulos nativos y correr los tests con la versión nueva.
- **`set -e` y `c=$(curl …)` cortan los scripts de verificación** (2026-10). Regla: no combinarlos en verificaciones remotas que reintentan.
- **`docker build` se cuelga bajando la imagen base** en servidores chicos (2026-10). Regla: `docker pull` antes del build y `set -o pipefail`.
- **`pkill -f` con un patrón que aparece en el propio comando lo mata a sí mismo** (2026-10). Regla: usar el PID o un patrón que no esté en el comando.
- **Los túneles rápidos exponen servicios sin autenticación** (2026-10). Uno publicó una app interna sin login. Regla: nada público sin la capa de acceso de la empresa; revisar túneles en cada inventario.
