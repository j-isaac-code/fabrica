---
description: Revisión de código según el método — hallazgos verificados, sin cambiar código
argument-hint: "[ID de la revisión] [carpeta o tema]"
---

Revisión: $ARGUMENTS

Sigue la sección "Revisiones de código" de la skill `metodo`:

- No cambies código: solo lees, verificas y reportas.
- Usa el agente `explorador` para barrer el código si es grande; tú confirmas cada hallazgo leyendo el código relacionado o corriéndolo.
- Cada hallazgo: título, `archivo:línea`, qué pasa, qué podría pasar, qué propones, severidad (alta, media o baja), esfuerzo (S, M o L) y si quedó verificado.
- Mejor 10 sólidos que 40 dudosos.
- Entrega una tabla ordenada por severidad. Con el OK del dueño, crea un issue por hallazgo (etiqueta `hallazgo`) en el repo, con el ID de la revisión en el título.
