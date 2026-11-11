#!/usr/bin/env bash
# frag.sh – Schnellsuche im Second Brain. Die Ordner 70–79 werden NIE durchsucht.
#
#   frag.sh begriff [begriff …]   Zeilen in den Gedächtnis-Dateien, die ALLE Begriffe enthalten
#   frag.sh -a begriff …          zusätzlich alle Markdown-Dateien (Kapitel, Vorlagen, Entwürfe …)
#   frag.sh -x begriff …          wie -a, aber einschließlich 90_Archiv
#   frag.sh -t                    alle Tags mit Häufigkeit
#   frag.sh -o                    Cockpit: offene Aufgaben, überfällige und kommende Fristen (60 Tage)
#
# Groß/klein egal, ä=ae, ö=oe, ü=ue, ß=ss.
set -euo pipefail

SYS="$(cd "$(dirname "$0")" && pwd)"
ROOT="$(dirname "$SYS")"
# Dateinamen, die als Gedächtnis gelten (Standardsuche)
GEDAECHTNIS=(EINGANG.md UEBERSICHT.md AUFGABEN.md FRISTEN.md RUECKBLICK.md NOTIZEN.md KONTAKTE.md WISSEN.md PROJEKT.md PROJEKTE.md)

usage() { sed -n '2,10p' "$0" | sed 's/^# \{0,1\}//'; exit 1; }

# ä/ae, ö/oe, ü/ue, ß/ss in beide Richtungen gleich behandeln
muster() {
  local s
  s="$(printf '%s' "$1" | tr '[:upper:]ÄÖÜ' '[:lower:]äöü')"
  s="$(printf '%s' "$s" | sed -E 's/ae|ä/(ae|ä)/g; s/oe|ö/(oe|ö)/g; s/ue|ü/(ue|ü)/g; s/ss|ß/(ss|ß)/g')"
  printf '%s' "$s"
}

# Oberste Ordner des Second Brain. Ausgeschlossen: 70–79 (Sperrbereich), 99_Aussortiert,
# versteckte Ordner (.git, .claude); 90_Archiv nur mit $1 = 1.
ordner() {
  local mit_archiv=$1 d name
  for d in "$ROOT"/*/; do
    name="$(basename "$d")"
    case "$name" in
      7[0-9]*) continue ;;
      99_*) continue ;;
      90_*) [[ $mit_archiv == 1 ]] || continue ;;
    esac
    printf '%s\n' "${d%/}"
  done
}

# Dateiliste: $1 = gedaechtnis | alle | archiv
dateien() {
  local art=$1 namen=() n
  local mit_archiv=0
  [[ $art == archiv ]] && mit_archiv=1
  mapfile -t dirs < <(ordner "$mit_archiv")
  if [[ $art == gedaechtnis ]]; then
    for n in "${GEDAECHTNIS[@]}"; do namen+=(-o -name "$n"); done
    find "${dirs[@]}" -type f \( "${namen[@]:1}" \) -not -path '*/Word/*' | sort
  else
    find "$ROOT" -maxdepth 1 -type f -name '*.md' | sort
    find "${dirs[@]}" -type f -name '*.md' -not -path '*/Word/*' | sort
  fi
}

[[ $# -eq 0 ]] && usage

case $1 in
  -h|--help) usage ;;
  -t)
    mapfile -t FILES < <(dateien gedaechtnis)
    grep -ohE '(^|[ (])#[a-zäöüß][a-zäöüß0-9-]*' "${FILES[@]}" | sed 's/^[ (]//' | sort | uniq -c | sort -rn
    exit 0 ;;
  -o)
    heute="$(date +%F)"; bis="$(date -d '+60 days' +%F 2>/dev/null || date -v+60d +%F)"
    echo "── Offene Aufgaben (01_Cockpit/AUFGABEN.md)"
    grep -E '^- \[ \]' "$ROOT/01_Cockpit/AUFGABEN.md" || echo "   keine"
    echo
    echo "── Fristen bis $bis (01_Cockpit/FRISTEN.md, ⚠ = überfällig)"
    awk -v h="$heute" -v b="$bis" '
      /^## Erledigt/ {exit}
      /^[0-9]{4}-[0-9]{2}-[0-9]{2} / { d=substr($0,1,10); if (d < h) print "⚠ " $0; else if (d <= b) print "  " $0 }
    ' "$ROOT/01_Cockpit/FRISTEN.md"
    echo
    n="$(grep -cE '^[0-9]{4}-[0-9]{2}-[0-9]{2} \|' "$ROOT/00_Eingang/EINGANG.md" || true)"
    m="$(find "$ROOT/00_Eingang" -type f -not -name 'EINGANG.md' -not -name '.gitkeep' | wc -l)"
    echo "── Eingang: $n Notiz(en), $m Datei(en) warten aufs Einsortieren"
    exit 0 ;;
  -a) art=alle; shift ;;
  -x) art=archiv; shift ;;
  *)  art=gedaechtnis ;;
esac

[[ $# -eq 0 ]] && usage
mapfile -t FILES < <(dateien "$art")

treffer="$(grep -HinE -- "$(muster "$1")" "${FILES[@]}" || true)"
shift
for begriff in "$@"; do
  treffer="$(grep -iE -- "$(muster "$begriff")" <<<"$treffer" || true)"
done

if [[ -z $treffer ]]; then
  if [[ $art == gedaechtnis ]]; then
    echo "Kein Treffer im Gedächtnis. Tipp: -a durchsucht alle Dateien, -t zeigt die Tags." >&2
  else
    echo "Kein Treffer. Tipp: weniger Begriffe, -t zeigt die Tags." >&2
  fi
  exit 1
fi
sed "s|$ROOT/||" <<<"$treffer"
