#!/usr/bin/env bash
# pruefen.sh – Gesundheitscheck des Second Brain. Claude führt ihn vor jedem Commit aus.
#
#   pruefen.sh            alle Prüfungen, einschließlich Online-Prüfung „Repo öffentlich?“
#   pruefen.sh --offline  ohne Online-Prüfung
#   pruefen.sh --hook     wie --offline, zeigt nur FEHLER (so läuft es im git-Hook)
#
# FEHLER blockieren (Exit-Code 1), WARNUNG und HINWEIS nicht.
set -uo pipefail

SYS="$(cd "$(dirname "$0")" && pwd)"
ROOT="$(dirname "$SYS")"
cd "$ROOT" || exit 2

online=1; leise=0
case "${1:-}" in
  --offline) online=0 ;;
  --hook) online=0; leise=1 ;;
esac

fehler=0; warnungen=0
F() { echo "FEHLER:  $*"; fehler=$((fehler + 1)); }
W() { warnungen=$((warnungen + 1)); [[ $leise == 1 ]] || echo "WARNUNG: $*"; }
H() { [[ $leise == 1 ]] || echo "HINWEIS: $*"; }

heute="$(date +%F)"
vor7="$(date -d '-7 days' +%F 2>/dev/null || date -v-7d +%F)"

# Alle Dateien, die git kennt oder kennen würde (getrackt, vorgemerkt, neu und nicht ignoriert)
mapfile -t GIT_DATEIEN < <({ git ls-files --cached --others --exclude-standard; git diff --cached --name-only; } | sort -u)

# ── 1. Sperrbereich 70–79 ─────────────────────────────────────────
gesperrt="$(printf '%s\n' "${GIT_DATEIEN[@]}" | grep -E '^7[0-9]' || true)"
if [[ -n $gesperrt ]]; then
  F "Dateien aus dem Sperrbereich 70–79 sind in git. Entfernen mit: git rm -r --cached <ordner>"
  printf '         %s\n' $gesperrt
fi
grep -qxF '/7[0-9]*' .gitignore 2>/dev/null || F ".gitignore: Die Sperrregel '/7[0-9]*' fehlt."
for n in 0 1 2 3 4 5 6 7 8 9; do
  grep -qF "\"Read(/7$n*/**)\"" .claude/settings.json 2>/dev/null \
    || { F ".claude/settings.json: Zugriffssperre für Ordner 7$n fehlt."; break; }
done
# Verweise auf Sperrbereich-Ordner (z. B. ein Pfad „7x_Name“) in Second-Brain-Dateien
mapfile -t TEXT < <(printf '%s\n' "${GIT_DATEIEN[@]}" | grep -E '\.(md|json|html|py|sh|txt|csv)$' | grep -vE '^7[0-9]')
verweise="$( ((${#TEXT[@]})) && grep -nE '(^|[^0-9A-Za-z])7[0-9]_[A-Za-zÄÖÜäöü]' "${TEXT[@]}" 2>/dev/null || true)"
if [[ -n $verweise ]]; then
  F "Verweis auf einen Ordner im Sperrbereich 70–79 gefunden (Inhalte von dort gehören nicht ins Second Brain):"
  sed 's/^/         /' <<<"$verweise"
fi

# ── 2. Geheimnisse ────────────────────────────────────────────────
mapfile -t SCAN < <(printf '%s\n' "${TEXT[@]}" | grep -v '^09_System/pruefen.sh$')
geheim="$( ((${#SCAN[@]})) && grep -niE '(passwort|kennwort|password)[[:space:]]*[:=][[:space:]]*[^[:space:]…]|(pin|tan|puk)[[:space:]]*[:=][[:space:]]*[0-9]{4}|\bDE[0-9]{2}[[:space:]]?([0-9]{4}[[:space:]]?){4}[0-9]{2}\b' "${SCAN[@]}" 2>/dev/null || true)"
if [[ -n $geheim ]]; then
  F "Möglicher Zugangscode oder IBAN gefunden – gehört nicht ins Second Brain:"
  sed 's/^/         /' <<<"$geheim"
fi

# ── 3. Eindeutige IDs ─────────────────────────────────────────────
mapfile -t WISSEN < <(printf '%s\n' "${GIT_DATEIEN[@]}" | grep -E '(^|/)WISSEN\.md$')
if ((${#WISSEN[@]})); then
  doppelt="$(grep -hoE '^[A-Z]{2,4}-[0-9]{2,3} ' "${WISSEN[@]}" | sort | uniq -d)"
  [[ -n $doppelt ]] && F "Doppelte Wissens-IDs: $(echo $doppelt)"
fi
if [[ -f 01_Cockpit/AUFGABEN.md ]]; then
  doppelt="$(grep -oE '^- \[[ x]\] A-[0-9]{3}' 01_Cockpit/AUFGABEN.md | grep -oE 'A-[0-9]{3}' | sort | uniq -d)"
  [[ -n $doppelt ]] && F "Doppelte Aufgaben-IDs: $(echo $doppelt)"
fi

# ── 4. Fristen und Aufgaben ───────────────────────────────────────
if [[ -f 01_Cockpit/FRISTEN.md ]]; then
  ueber="$(awk -v h="$heute" '/^## Erledigt/ {exit} /^[0-9]{4}-[0-9]{2}-[0-9]{2} / { if (substr($0,1,10) < h) print }' 01_Cockpit/FRISTEN.md)"
  [[ -n $ueber ]] && W "Überfällige Fristen (erledigen oder nach „## Erledigt“ verschieben):
$(sed 's/^/         /' <<<"$ueber")"
fi
if [[ -f 01_Cockpit/AUFGABEN.md ]]; then
  ueber="$(grep -E '^- \[ \].*bis [0-9]{4}-[0-9]{2}-[0-9]{2}' 01_Cockpit/AUFGABEN.md \
    | awk -v h="$heute" '{ if (match($0, /bis [0-9]{4}-[0-9]{2}-[0-9]{2}/) && substr($0, RSTART+4, 10) < h) print }')"
  [[ -n $ueber ]] && W "Überfällige Aufgaben:
$(sed 's/^/         /' <<<"$ueber")"
fi

# ── 5. Eingang ────────────────────────────────────────────────────
if [[ -f 00_Eingang/EINGANG.md ]]; then
  alt="$(awk -v g="$vor7" '/^[0-9]{4}-[0-9]{2}-[0-9]{2} \|/ { if (substr($0,1,10) < g) n++ } END { print n+0 }' 00_Eingang/EINGANG.md)"
  ((alt > 0)) && W "$alt Notiz(en) liegen länger als 7 Tage im Eingang – „Eingang leeren“."
fi
m="$(find 00_Eingang -type f -not -name 'EINGANG.md' -not -name '.gitkeep' 2>/dev/null | wc -l)"
((m > 0)) && H "$m Datei(en) im Ordner 00_Eingang warten aufs Einsortieren."

# ── 6. Projekte ───────────────────────────────────────────────────
for d in [1-6][0-9]_*/; do
  [[ -d $d ]] || continue
  d="${d%/}"
  [[ -f $d/PROJEKT.md ]] || W "$d hat keine PROJEKT.md (Vorlage: 09_System/Vorlagen/PROJEKT.md)."
  grep -qF "$d" 01_Cockpit/UEBERSICHT.md 2>/dev/null || W "$d fehlt in 01_Cockpit/UEBERSICHT.md."
done

# ── 7. Ist das Repository öffentlich? ─────────────────────────────
if [[ $online == 1 ]]; then
  url="$(git remote get-url origin 2>/dev/null || true)"
  slug="$(sed -E 's#^.*github\.com[:/]##; s#\.git$##' <<<"$url" | grep -oE '^[^/]+/[^/]+$' || true)"
  if [[ -n $slug ]]; then
    antwort="$(curl -s --max-time 6 "https://api.github.com/repos/$slug" 2>/dev/null || true)"
    if grep -qE '"private": *false' <<<"$antwort"; then
      W "Das Repository $slug ist ÖFFENTLICH. Keine persönlichen Daten eintragen, bis es auf privat gestellt ist."
    elif grep -qE '"private": *true' <<<"$antwort"; then
      H "Repository ist privat."
    else
      H "Sichtbarkeit des Repositorys nicht prüfbar (offline oder privat ohne Anmeldung)."
    fi
  fi
fi

# ── Ergebnis ──────────────────────────────────────────────────────
if ((fehler > 0)); then
  echo "✘ $fehler Fehler, $warnungen Warnung(en). Commit bitte erst nach dem Beheben."
  exit 1
fi
[[ $leise == 1 ]] || echo "✔ Keine Fehler. $warnungen Warnung(en)."
exit 0
