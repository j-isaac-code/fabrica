#!/usr/bin/env bash
# Imprime el contexto de la empresa para que Claude lo tenga desde el inicio.
# Busca fabrica-config en: $FABRICA_CONFIG, ./fabrica-config (checkout en CI), ~/Documents/GitHub/fabrica-config.
set -u

buscar() {
  for d in "${FABRICA_CONFIG:-}" "${GITHUB_WORKSPACE:-.}/fabrica-config" "$HOME/Documents/GitHub/fabrica-config"; do
    if [ -n "$d" ] && [ -f "$d/CONTEXTO.md" ]; then
      echo "$d"
      return 0
    fi
  done
  return 1
}

if dir=$(buscar); then
  echo "# Fábrica · contexto de la empresa (de $dir)"
  echo "Método: skill fabrica:metodo. Lecciones de la empresa: $dir/lecciones.md. Decisiones: $dir/decisiones/."
  echo
  # Límite para no inflar el contexto de cada sesión.
  head -c 12000 "$dir/CONTEXTO.md"
else
  echo "# Fábrica: no encontré fabrica-config (CONTEXTO.md)."
  echo "Pregúntale al dueño dónde está o define FABRICA_CONFIG. Mientras tanto aplica solo el método genérico (skill fabrica:metodo)."
fi
exit 0
