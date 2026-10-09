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
