# CLAUDE.md – Projekt 20 Bauleitung

Ergänzt die Haupt-`CLAUDE.md` im Hauptordner. Alle Pfade hier sind vom Hauptordner des Second Brain aus angegeben.

## So fragst du das Bauleitungs-Gedächtnis ab

1. **Zuerst** `09_System/frag.sh <begriff> …` (durchsucht das ganze Second Brain) oder gezielt `20_Bauleitung/_gedaechtnis/frag.sh <begriff> …` (nur Bauleitung).
   - Bauleitungs-Suche: `frag.sh -t` listet die Tags, `frag.sh ABS-09` holt einen Fakt per ID, `frag.sh BST-` alle Baustellen, `frag.sh -a <begriff>` durchsucht alle Kapitel und Vorlagen.
2. Treffer stehen in `20_Bauleitung/_gedaechtnis/WISSEN.md` – eine Zeile = ein Fakt: `ID #tags | Fakt | Quelle`.
   Bereichs-Kürzel: UNF Unfall · BG · VOR Recht · ABS Absturz/Gerüst/Leiter · ERD Erdarbeiten · ELE Elektro · MAS Maschinen/Kran · GEF Gefahrstoffe · BRA Brand · PSA · LAE Lärm/Klima · VER Verkehr · ORG Organisation · PRF Prüffristen · BSV BaustellV · VOB Vertrag · PER Personal/NU · UMW Umwelt.
3. Nur wenn die Zeile nicht reicht: das Kapitel lesen, auf das das Kürzel im Kopf von WISSEN.md zeigt.
4. In Antworten die Fakt-ID und die Quelle nennen. Mit ⚠ markierte Werte als unsicher/landesabhängig kennzeichnen. Rechtsstand 10/2026, bei Rechtsfragen auf den Originaltext verweisen.

## Daten der Bauleitung

- `20_Bauleitung/_gedaechtnis/PROJEKTE.md` – laufende Baustellen (`## BST-<Name>`), Stammdaten, Gewährleistung
- `20_Bauleitung/_gedaechtnis/KONTAKTE.md` – Notfall- und Baukontakte (BG, Behörden, D-Arzt, Störungsdienste)
- `20_Bauleitung/_gedaechtnis/NOTIZEN.md` – Entscheidungen zur Bauleitung (`JJJJ-MM-TT #tag | Notiz`)

**Pflegeregel:** Neue Baustelle → Block in `PROJEKTE.md` (Vorlage dort). Bau-Kontakt → `KONTAKTE.md` der Bauleitung. Jede Frist mit Datum (Abnahme, Gewährleistungsende, Ablauf einer verkehrsrechtlichen Anordnung …) **zusätzlich** als Zeile in `01_Cockpit/FRISTEN.md` mit `#bau` und der Baustellen-ID. Neue allgemeine Fakten nur mit Quelle in WISSEN.md, nächste freie ID des Bereichs.

## Abhak-Checkliste

- Seite: https://claude.ai/artifact/1nA34SWgdVqcVRFwTUcoY3 (Quelle: `20_Bauleitung/Checkliste/checkliste.html`)
- Punkte stehen in `20_Bauleitung/Checkliste/checkliste.json`. Nach Änderungen `python3 20_Bauleitung/_werkzeuge/checkliste_bauen.py` ausführen (erzeugt `CHECKLISTE.md` und bettet Daten + Fakten in die Seite ein), dann die Seite mit dem Artifact-Tool unter der obigen URL neu veröffentlichen.
- Häkchen lesen: ArtifactData `list` auf Sammlung `stand` (Dokument-ID `<baustelle>__<periode>`, Periode = `start|einr|pers|ende|unfall|T-JJJJ-MM-TT|W-JJJJ-Www|M-JJJJ-MM`; Feld `haken` = {Punkt-ID: Zeitpunkt}). Baustellen: Sammlung `baustellen` ({name, angelegt, archiviert}). Punkt-IDs → Texte in checkliste.json.

## Vorlagen

`20_Bauleitung/Vorlagen/*.md` sind die Quellen; `20_Bauleitung/Vorlagen/Word/*.docx` werden mit `python3 20_Bauleitung/_werkzeuge/vorlagen_zu_word.py` erzeugt (pandoc). Nach Änderungen an einer Vorlage neu erzeugen.
