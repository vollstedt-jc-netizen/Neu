#!/usr/bin/env python3
"""Erzeugt aus Checkliste/checkliste.json die Markdown-Checkliste und bettet
die Daten (inkl. der verlinkten Fakten aus WISSEN.md) in die Abhak-Seite ein.

Aufruf:  python3 Bauleitung/_werkzeuge/checkliste_bauen.py
"""
import json
import pathlib
import re
import sys

ROOT = pathlib.Path(__file__).resolve().parent.parent
QUELLE = ROOT / "Checkliste" / "checkliste.json"
WISSEN = ROOT / "_gedaechtnis" / "WISSEN.md"
MD = ROOT / "Checkliste" / "CHECKLISTE.md"
HTML = ROOT / "Checkliste" / "checkliste.html"

ART_TEXT = {
    "einmalig": "einmal je Baustelle",
    "tag": "jeden Arbeitstag",
    "woche": "jede Woche",
    "monat": "jeden Monat",
    "vorfall": "bei jedem Unfall",
}


def fakten_lesen():
    fakten = {}
    for zeile in WISSEN.read_text(encoding="utf-8").splitlines():
        m = re.match(r"^([A-Z]{2,3}-\d{2}) [^|]*\| (.+?) \| (.+)$", zeile)
        if m:
            fakten[m.group(1)] = {"text": m.group(2).strip(), "quelle": m.group(3).strip()}
    return fakten


def markdown(daten):
    z = [
        f"# {daten['titel']}",
        "",
        f"Stand {daten['stand']}. Zum Abhaken auf Papier ausdrucken oder digital in der Abhak-Seite (Link in `CLAUDE.md`).",
        "Die Kürzel in Klammern (z. B. UNF-03) verweisen auf `_gedaechtnis/WISSEN.md` – dort stehen Frist, Grenzwert und Quelle.",
        "*Diese Datei wird aus `checkliste.json` erzeugt – Änderungen bitte dort vornehmen und `_werkzeuge/checkliste_bauen.py` ausführen.*",
        "",
    ]
    for a in daten["abschnitte"]:
        z.append(f"## {a['titel']} ({ART_TEXT[a['art']]})")
        z.append("")
        for p in a["punkte"]:
            ref = f" ({', '.join(p['ref'])})" if p["ref"] else ""
            z.append(f"- [ ] {p['text']}{ref}")
        z.append("")
    return "\n".join(z)


def main():
    daten = json.loads(QUELLE.read_text(encoding="utf-8"))
    fakten = fakten_lesen()

    ids, fehlend, benutzt = set(), [], {}
    for a in daten["abschnitte"]:
        for p in a["punkte"]:
            if p["id"] in ids:
                sys.exit(f"Doppelte Punkt-ID: {p['id']}")
            ids.add(p["id"])
            for r in p["ref"]:
                if r in fakten:
                    benutzt[r] = fakten[r]
                else:
                    fehlend.append(f"{p['id']} → {r}")
    if fehlend:
        sys.exit("Verweise ohne Fakt in WISSEN.md:\n  " + "\n  ".join(fehlend))

    MD.write_text(markdown(daten), encoding="utf-8")

    eingebettet = dict(daten, fakten=benutzt)
    json_text = json.dumps(eingebettet, ensure_ascii=False, separators=(",", ":")).replace("</", "<\\/")
    html = HTML.read_text(encoding="utf-8")
    html, n = re.subn(
        r'(<script id="daten" type="application/json">).*?(</script>)',
        lambda m: m.group(1) + json_text + m.group(2),
        html,
        flags=re.S,
    )
    if n != 1:
        sys.exit("Datenblock in checkliste.html nicht gefunden")
    HTML.write_text(html, encoding="utf-8")

    anzahl = sum(len(a["punkte"]) for a in daten["abschnitte"])
    print(f"{anzahl} Punkte in {len(daten['abschnitte'])} Abschnitten, {len(benutzt)} Fakten eingebettet.")


if __name__ == "__main__":
    main()
