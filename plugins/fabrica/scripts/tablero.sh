#!/usr/bin/env bash
# El tablero de la fábrica es un GitHub Project. Este script es la única
# implementación de sus consultas: la usan /estado y la receta del README.
#
#   tablero.sh activas                    ítems abiertos con prioridad "🟢 Activa"
#                                         (lo mismo que la vista "Esta semana"), uno por línea en JSON
#   tablero.sh copiar [destino] [título]  copia vacía del tablero (sin ítems ni borradores)
#                                         en la cuenta u organización destino (por omisión, la tuya)
#   tablero.sh contar <dueño> <número>    cuántos ítems tiene un Project (para verificar una copia)
#
# Variables: FABRICA_PROJECT_OWNER y FABRICA_PROJECT_NUMBER = el Project de origen.
# Requiere gh con el permiso "project" (gh auth refresh -s project).
set -euo pipefail

# La misma consulta que el filtro de la vista "Esta semana". Si cambia, cambia aquí.
FILTRO_ACTIVAS='is:open prioridad:"🟢 Activa"'

falta() { echo "tablero.sh: $1" >&2; exit 1; }

origen() {
  [ -n "${FABRICA_PROJECT_OWNER:-}" ] || falta "define FABRICA_PROJECT_OWNER (dueño del Project)"
  [ -n "${FABRICA_PROJECT_NUMBER:-}" ] || falta "define FABRICA_PROJECT_NUMBER (número del Project)"
}

# Id del Project <dueño> <número>, sea el dueño una cuenta de usuario o una organización.
id_project() {
  gh api graphql -f login="$1" -F n="$2" -f query='
    query($login: String!, $n: Int!) {
      repositoryOwner(login: $login) {
        ... on User { projectV2(number: $n) { id } }
        ... on Organization { projectV2(number: $n) { id } }
      }
    }' --jq '.data.repositoryOwner.projectV2.id // empty'
}

activas() {
  origen
  gh project item-list "$FABRICA_PROJECT_NUMBER" --owner "$FABRICA_PROJECT_OWNER" \
    --limit 500 --format json --query "$FILTRO_ACTIVAS" \
    --jq '.items[] | {
      ref: "\(.content.repository)#\(.content.number)",
      titulo: .content.title,
      tipo: .content.type,
      estado: .status,
      app: .app,
      etiquetas: (.labels // []),
      url: .content.url
    }'
}

contar() {
  gh api graphql -f login="$1" -F n="$2" -f query='
    query($login: String!, $n: Int!) {
      repositoryOwner(login: $login) {
        ... on User { projectV2(number: $n) { items { totalCount } } }
        ... on Organization { projectV2(number: $n) { items { totalCount } } }
      }
    }' --jq '.data.repositoryOwner.projectV2.items.totalCount'
}

copiar() {
  origen
  local destino="${1:-}" titulo="${2:-Fábrica}"
  [ -n "$destino" ] || destino=$(gh api user --jq .login)

  local id_origen id_destino
  id_origen=$(id_project "$FABRICA_PROJECT_OWNER" "$FABRICA_PROJECT_NUMBER")
  [ -n "$id_origen" ] || falta "no veo el Project $FABRICA_PROJECT_OWNER/$FABRICA_PROJECT_NUMBER con esta cuenta (¿es privado y no eres colaborador?)"
  id_destino=$(gh api graphql -f login="$destino" -f query='
    query($login: String!) { repositoryOwner(login: $login) { id } }' --jq '.data.repositoryOwner.id // empty')
  [ -n "$id_destino" ] || falta "no encuentro la cuenta u organización '$destino'"

  # copyProjectV2 copia campos, vistas y workflows (salvo los auto-add);
  # no copia ítems, colaboradores ni repos vinculados. Sin borradores.
  local nuevo
  nuevo=$(gh api graphql -f p="$id_origen" -f o="$id_destino" -f t="$titulo" -f query='
    mutation($p: ID!, $o: ID!, $t: String!) {
      copyProjectV2(input: {projectId: $p, ownerId: $o, title: $t, includeDraftIssues: false}) {
        projectV2 { number url }
      }
    }' --jq '.data.copyProjectV2.projectV2 | "\(.number) \(.url)"')
  local numero="${nuevo%% *}" url="${nuevo#* }"

  local items
  items=$(contar "$destino" "$numero")
  echo "Copia creada: $url (número $numero, $items ítems)"
  [ "$items" = "0" ] || falta "la copia tiene $items ítems: revísala antes de usarla"

  echo "Workflows de la copia (actívalos a mano en Settings → Workflows, ver README):"
  gh api graphql -f login="$destino" -F n="$numero" -f query='
    query($login: String!, $n: Int!) {
      repositoryOwner(login: $login) {
        ... on User { projectV2(number: $n) { workflows(first: 20) { nodes { name enabled } } } }
        ... on Organization { projectV2(number: $n) { workflows(first: 20) { nodes { name enabled } } } }
      }
    }' --jq '.data.repositoryOwner.projectV2.workflows.nodes[] | "  \(if .enabled then "✓" else "·" end) \(.name)"'
}

case "${1:-}" in
  activas) activas ;;
  copiar) shift; copiar "$@" ;;
  contar) [ $# -eq 3 ] || falta "uso: tablero.sh contar <dueño> <número>"; contar "$2" "$3" ;;
  *) sed -n '2,13p' "$0" | sed 's/^# \{0,1\}//'; exit 1 ;;
esac
