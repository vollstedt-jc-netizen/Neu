# CLAUDE.md – Gedächtnis

Repository von Jan-Henrik Vollstedt. Sprache: Deutsch.
Inhalt: `Bauleitung/` (Wissen und Vorlagen für die Bauleitung) und `Leitfaden_Claude_Landwirtschaft.docx`.

## Bauleitung – so fragst du das Gedächtnis ab

1. **Zuerst** `Bauleitung/_gedaechtnis/frag.sh <begriff> [begriff …]` (UND-Suche, Groß/klein und ä/ae egal).
   - `frag.sh -t` listet die Tags, `frag.sh ABS-09` holt einen Fakt per ID, `frag.sh -a <begriff>` durchsucht alle Kapitel und Vorlagen.
2. Treffer stehen in `Bauleitung/_gedaechtnis/WISSEN.md` – eine Zeile = ein Fakt: `ID #tags | Fakt | Quelle`.
   Bereichs-Kürzel: UNF Unfall · BG · VOR Recht · ABS Absturz/Gerüst/Leiter · ERD Erdarbeiten · ELE Elektro · MAS Maschinen/Kran · GEF Gefahrstoffe · BRA Brand · PSA · LAE Lärm/Klima · VER Verkehr · ORG Organisation · PRF Prüffristen · BSV BaustellV · VOB Vertrag · PER Personal/NU · UMW Umwelt.
3. Nur wenn die Zeile nicht reicht: das Kapitel lesen, auf das das Kürzel im Kopf von WISSEN.md zeigt.
4. In Antworten die Fakt-ID und die Quelle nennen. Mit ⚠ markierte Werte als unsicher/landesabhängig kennzeichnen. Rechtsstand 10/2026, bei Rechtsfragen auf den Originaltext verweisen.

## Persönliche Daten des Nutzers

- `Bauleitung/_gedaechtnis/PROJEKTE.md` – laufende Baustellen (`## BST-<Name>`), Fristen, Gewährleistung
- `Bauleitung/_gedaechtnis/KONTAKTE.md` – Telefonnummern (BG, Behörden, D-Arzt, Störungsdienste)
- `Bauleitung/_gedaechtnis/NOTIZEN.md` – Vorlieben, Entscheidungen (`JJJJ-MM-TT #tag | Notiz`)

**Pflegeregel:** Nennt der Nutzer eine neue Baustelle, einen Kontakt, eine Frist oder eine Vorliebe, sofort in die passende Datei eintragen (eine Zeile, gleiches Format), committen und pushen. Neue allgemeine Fakten nur mit Quelle in WISSEN.md aufnehmen, nächste freie ID des Bereichs verwenden.

## Abhak-Checkliste

- Seite: https://claude.ai/artifact/1nA34SWgdVqcVRFwTUcoY3 (Quelle: `Bauleitung/Checkliste/checkliste.html`)
- Punkte stehen in `Bauleitung/Checkliste/checkliste.json`. Nach Änderungen `python3 Bauleitung/_werkzeuge/checkliste_bauen.py` ausführen (erzeugt `CHECKLISTE.md` und bettet Daten + Fakten in die Seite ein), dann die Seite mit dem Artifact-Tool neu veröffentlichen (gleicher Pfad bzw. obige URL).
- Häkchen lesen: ArtifactData `list` auf Sammlung `stand` (Dokument-ID `<baustelle>__<periode>`, Periode = `start|einr|pers|ende|unfall|T-JJJJ-MM-TT|W-JJJJ-Www|M-JJJJ-MM`; Feld `haken` = {Punkt-ID: Zeitpunkt}). Baustellen: Sammlung `baustellen` ({name, angelegt, archiviert}). Punkt-IDs → Texte in checkliste.json.

## Vorlagen

`Bauleitung/Vorlagen/*.md` sind die Quellen; `Bauleitung/Vorlagen/Word/*.docx` werden mit `python3 Bauleitung/_werkzeuge/vorlagen_zu_word.py` erzeugt (pandoc). Nach Änderungen an einer Vorlage neu erzeugen.
