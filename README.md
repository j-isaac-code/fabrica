# Fábrica

Mi método para trabajar con Claude Code como una fábrica de software: **la tarea es la unidad** (issue → rama → PR), el dueño aprueba lo mínimo y **todo lo que aprendemos vuelve al método**.

Este repo es personal y portable: no contiene nada de ninguna empresa. Lo propio de cada empresa vive en su repo `fabrica-config`.

## Cómo está armado

```
fabrica (este repo, mío)                 fabrica-config (de cada empresa)
├── método genérico (skill metodo)       ├── CONTEXTO.md   apps, servidores, reglas
├── lecciones genéricas                  ├── lecciones.md  lo aprendido en esa empresa
├── /retomar /cerrar /bandeja /estado    ├── decisiones/   lo que decidió el dueño
│   /aprender /consolidar /revisar       └── historial/
├── agente explorador (modelo barato)
└── hook de inicio ───── lee ──────────► CONTEXTO.md
```

## Instalar en una máquina nueva

1. Clonar los dos repos en `~/Documents/GitHub/` (o definir `FABRICA_REPO` y `FABRICA_CONFIG` con otra ruta).
2. En Claude Code:
   ```
   /plugin marketplace add j-isaac-code/fabrica
   /plugin install fabrica@fabrica
   ```
3. Abrir una sesión en cualquier repo y correr `/fabrica:retomar`.

## El tablero: un GitHub Project

El dashboard de la fábrica **no es una página aparte**: es un GitHub Project con una vista de tablero ("Esta semana": columnas por `Status`, filtro `is:open prioridad:"🟢 Activa"`). Se abre con un link, también desde el celular. `/estado` lee la misma consulta con `scripts/tablero.sh activas`.

### Crear el tablero en otra cuenta

Desde un Project plantilla (una copia vacía de un tablero que ya funciona):

```bash
gh auth refresh -s project
FABRICA_PROJECT_OWNER=<dueño-plantilla> FABRICA_PROJECT_NUMBER=<número> \
  plugins/fabrica/scripts/tablero.sh copiar <cuenta-u-organización-destino> "<título>"
```

Usa la mutación `copyProjectV2` con `includeDraftIssues: false` y verifica que la copia quede con 0 ítems. Si la plantilla es privada, la cuenta que copia tiene que ser colaboradora (al menos lectora).

| `copyProjectV2` copia | No copia |
|---|---|
| Campos propios con sus opciones (`Prioridad`, `App`, `Nivel`, `Requiere OK`) y las de `Status` | Ítems (issues y PRs) |
| Vistas (tabla y tablero, con su filtro) | Borradores (con `includeDraftIssues: false`) |
| Workflows configurados, **en el mismo estado que en la plantilla** | Workflows de auto-agregar, colaboradores y repos vinculados |

### A mano, después de copiar (la API no lo permite)

1. **Workflows** (menú `…` → Workflows): activar **Item closed → `Hecha`** y **Pull request linked to issue → `En revisión`**. La API no deja activarlos ni elegir el estado destino.
2. **Vista "Esta semana"** (tablero): en `View` → Fields, mostrar **Labels**, para que la tarjeta muestre `espera-ok` y `🤖 trabajando`. Revisar que las columnas sean por `Status`.
3. Opciones del campo `App`: dejar las apps de la empresa nueva (se copian las de la plantilla).
4. Sumar los issues con `gh project item-add` o con `/bandeja`.

### Ver en vivo qué trabaja Claude

En el workflow de la Action de Claude de cada repo, un paso al inicio pone la etiqueta `🤖 trabajando` al issue o PR y otro, con `if: always()`, la quita. Con el campo Labels visible, la tarjeta lo muestra mientras corre. Necesita `permissions: issues: write`; la App de Claude no puede editar workflows, así que el cambio lo sube una persona.

```yaml
    steps:
      - name: Marcar 🤖 trabajando
        continue-on-error: true
        env:
          GH_TOKEN: ${{ github.token }}
          NUMERO: ${{ github.event.issue.number || github.event.pull_request.number }}
        run: |
          gh label create "🤖 trabajando" -R "$GITHUB_REPOSITORY" --force --color 5319e7
          gh api "repos/$GITHUB_REPOSITORY/issues/$NUMERO/labels" -f "labels[]=🤖 trabajando" --silent
      # … checkout, dependencias y la Action de Claude …
      - name: Quitar 🤖 trabajando
        if: always()
        env:
          GH_TOKEN: ${{ github.token }}
          NUMERO: ${{ github.event.issue.number || github.event.pull_request.number }}
        run: |
          gh api -X DELETE --silent \
            "repos/$GITHUB_REPOSITORY/issues/$NUMERO/labels/$(jq -rn '"🤖 trabajando" | @uri')" || true
```

## Cómo se mejora solo

```
trabajo → algo falla, cuesta caro o el dueño corrige
       → /aprender (o al /cerrar una tarea)
       → ¿genérico?  sí → PR a fabrica        (sube la versión)
                     no → PR a fabrica-config
       → el dueño hace merge → la siguiente sesión ya trabaja con la regla nueva
cada semana → /consolidar: junta duplicados, quita lo viejo y sube a regla lo que se repite
```

Para recibir la versión nueva en una máquina: `/plugin marketplace update fabrica`.

## Reglas de este repo

- Nada de empresas: ni nombres de servidores, IPs, dominios, apps, personas ni datos.
- Nunca secretos.
- Ningún cambio entra sin PR aprobado por el dueño.
