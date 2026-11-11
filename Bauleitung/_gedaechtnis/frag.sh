#!/usr/bin/env bash
# Schnellabfrage des Bauleitungs-Gedächtnisses.
#
#   frag.sh unfall frist      Zeilen, die ALLE Begriffe enthalten (Groß/klein egal, ä=ae usw.)
#   frag.sh ABS-09            einen Fakt per ID
#   frag.sh BST-              alle Baustellen-Köpfe
#   frag.sh -a gerüst         zusätzlich alle Kapitel und Vorlagen durchsuchen
#   frag.sh -t                alle Tags mit Häufigkeit
set -euo pipefail

DIR="$(cd "$(dirname "$0")" && pwd)"
ROOT="$(dirname "$DIR")"
FILES=("$DIR/WISSEN.md" "$DIR/PROJEKTE.md" "$DIR/KONTAKTE.md" "$DIR/NOTIZEN.md")

usage() { sed -n '2,9p' "$0" | sed 's/^# \{0,1\}//'; exit 1; }

# ä/ae, ö/oe, ü/ue, ß/ss in beide Richtungen gleich behandeln
muster() {
  local s
  s="$(printf '%s' "$1" | tr '[:upper:]ÄÖÜ' '[:lower:]äöü')"
  s="$(printf '%s' "$s" | sed -E 's/ae|ä/(ae|ä)/g; s/oe|ö/(oe|ö)/g; s/ue|ü/(ue|ü)/g; s/ss|ß/(ss|ß)/g')"
  printf '%s' "$s"
}

[[ $# -eq 0 ]] && usage

if [[ $1 == -t ]]; then
  grep -oh '#[a-zäöü]\+' "$DIR/WISSEN.md" | sort | uniq -c | sort -rn
  exit 0
fi

if [[ $1 == -a ]]; then
  shift
  [[ $# -eq 0 ]] && usage
  mapfile -t FILES < <(find "$ROOT" -name '*.md' -not -path '*/Word/*' | sort)
fi

treffer="$(grep -HinE -- "$(muster "$1")" "${FILES[@]}" || true)"
shift
for begriff in "$@"; do
  treffer="$(grep -iE -- "$(muster "$begriff")" <<<"$treffer" || true)"
done

if [[ -z $treffer ]]; then
  echo "Kein Treffer. Tipp: weniger Begriffe, -a für alle Kapitel, -t für die Tag-Liste." >&2
  exit 1
fi
sed "s|$ROOT/||" <<<"$treffer"
