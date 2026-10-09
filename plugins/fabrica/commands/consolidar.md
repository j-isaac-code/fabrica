---
description: Depurar las lecciones y el método — juntar duplicados, quitar lo viejo y subir a regla lo que se repite
---

Haz una pasada de limpieza sobre el conocimiento de la fábrica:

1. Lee `fabrica/plugins/fabrica/skills/metodo/SKILL.md`, `…/lecciones.md` y, si existe, `fabrica-config/lecciones.md` y `fabrica-config/CONTEXTO.md` (rutas en la skill `aprender`).
2. Busca:
   - lecciones duplicadas o que dicen lo mismo con otras palabras → júntalas;
   - lecciones que ya no aplican (la herramienta cambió, el problema se resolvió de raíz) → quítalas o márcalas;
   - lecciones que se repiten o son muy importantes → súbelas a regla en `SKILL.md`;
   - contenido de la empresa que se coló en `fabrica` → muévelo a `fabrica-config`;
   - reglas que se contradicen → propón cuál queda.
3. Muéstrale al dueño una tabla corta (qué cambia y por qué) **antes** de editar.
4. Con su "dale", abre un PR por repo (rama `claude/consolidar-AAAA-MM-DD`), con la versión del plugin subida si tocaste `fabrica`.
