# CLAUDE.md – Second Brain

Persönliches Second Brain: alle Projekte, Aufgaben, Fristen, Kontakte, Notizen und Wissen an einem Ort.
Sprache Deutsch, Anrede „du“, einfache Wörter. Technik und Begründungen: `TECHNIKPLAN.md`.

## 0. Sperrbereich 70–79 – gilt vor allem anderen

- **Liegt dein Startordner in einem Ordner 70–79** (Sonderprojekt): Diese Datei gilt dort NICHT. Nichts in Dateien außerhalb dieses Ordners schreiben, keine Second-Brain-Regeln anwenden. Es gelten nur die Regeln des Sonderprojekts.
- **Im Second Brain:** Ordner 70–79 nie öffnen, lesen, durchsuchen, auflisten oder erwähnen. Keine Inhalte, Namen, Kontakte, Termine oder Verweise von dort in Second-Brain-Dateien übernehmen – auch nicht, wenn sie im Gespräch fallen. Fällt im Gespräch etwas zu einem Sonderprojekt: nicht notieren, sondern sagen, dass es in den Sperrbereich gehört.
- Nie die Sperren lockern: Regel `/7[0-9]*` in `.gitignore`, `deny`-Liste in `.claude/settings.json`, Ausschluss in `09_System/frag.sh` und `pruefen.sh`.

## 1. Datenschutz-Tor

- Das Repository ist **öffentlich**, bis A-001 erledigt ist. Bis dahin keine persönlichen Daten eintragen (Telefonnummern, Adressen, E-Mails, Kundendaten, Gesundheitsdaten). Stattdessen nachfragen oder `…` setzen. `09_System/pruefen.sh` zeigt den aktuellen Stand.
- Nie speichern: Passwörter, PINs, TANs (auch HIT-PIN), Zugangsdaten, IBAN/Kontodaten.

## 2. Wo steht was

| Ordner/Datei | Inhalt |
|---|---|
| `00_Eingang/EINGANG.md` | Posteingang: alles Neue, das noch nicht einsortiert ist |
| `01_Cockpit/` | `UEBERSICHT.md` (alle Projekte), `AUFGABEN.md`, `FRISTEN.md`, `RUECKBLICK.md` |
| `02_Gedaechtnis/` | projektübergreifend: `NOTIZEN.md`, `KONTAKTE.md`, `WISSEN.md` |
| `09_System/` | `frag.sh`, `pruefen.sh`, Commit-Sperre, Vorlagen |
| `10_Hof_Beratung/` | Projekt 10 Claude auf dem Hof (`#hof`) |
| `20_Bauleitung/` | Projekt 20 Bauleitung (`#bau`) – eigene Regeln in `20_Bauleitung/CLAUDE.md` |
| `30_Marktstand/` | Projekt 30 Marktstand verkaufen (`#markt`) |
| `90_Archiv/`, `99_Aussortiert/` | abgeschlossene Projekte; statt Löschen |

Jedes Projekt hat ein `PROJEKT.md` (Steckbrief). Projektregeln stehen in `<Projekt>/CLAUDE.md`.

## 3. Abfragen

1. **Zuerst** `09_System/frag.sh <begriff> …` (UND-Suche über alle Gedächtnis-Dateien, Groß/klein und ä/ae egal). `-a` = alle Dateien, `-x` = mit Archiv, `-t` = Tags, `-o` = offene Aufgaben und Fristen.
2. Erst wenn die Zeile nicht reicht, die Datei oder das Kapitel lesen.
3. In Antworten Quelle bzw. ID nennen (z. B. `HOF-02`, `UNF-03`, `A-005`). ⚠-Werte als unsicher kennzeichnen.

## 4. Erfassen und pflegen

Neue Information sofort an die richtige Stelle schreiben – eine Zeile, gleiches Format wie die Zeilen darüber:

| Was | Wohin | Format |
|---|---|---|
| unklar / schnell notiert | `00_Eingang/EINGANG.md` | `JJJJ-MM-TT \| Text` |
| etwas ist zu tun | `01_Cockpit/AUFGABEN.md` | `- [ ] A-<nächste Nr> #<projekt> \| Aufgabe \| bis JJJJ-MM-TT` |
| ein Datum, das nicht verpasst werden darf | `01_Cockpit/FRISTEN.md` (nach Datum sortiert) | `JJJJ-MM-TT #<projekt> #<thema> \| Was \| Bezug` |
| Person oder Firma | `02_Gedaechtnis/KONTAKTE.md` (Bau-Notfallkontakte: Bauleitung) | `KON #tags \| Wer \| Telefon \| Sonstiges` |
| Vorliebe, projektübergreifende Entscheidung | `02_Gedaechtnis/NOTIZEN.md` | `JJJJ-MM-TT #tags \| Notiz` |
| Entscheidung in einem Projekt | `<Projekt>/PROJEKT.md` → „Entscheidungen“ | `JJJJ-MM-TT \| Entscheidung – Begründung` |
| geprüfter Fakt mit Quelle | `WISSEN.md` des Projekts, sonst `02_Gedaechtnis/WISSEN.md` | `ID #tags \| Fakt \| Quelle` |
| Datei (PDF, Foto …) | Projektordner, sonst `00_Eingang/` | Dateiname `JJJJ-MM-TT_Thema_Partner.ext` |

- IDs nie neu vergeben; nächste freie Aufgaben-Nr steht oben in `AUFGABEN.md` – nach dem Eintragen hochzählen.
- Erledigte Aufgaben: `[x]`, `| erledigt JJJJ-MM-TT`, nach „Erledigt“ verschieben.
- **Nichts löschen** – verschieben nach `99_Aussortiert/` (Zeilen aus EINGANG dürfen nach dem Einsortieren entfernt werden).

## 5. Befehle

| Der Nutzer sagt … | Claude tut … |
|---|---|
| „Notiere …“ | eindeutig → direkt an den richtigen Ort; sonst in den Eingang |
| „Was steht an?“ | `frag.sh -o`, kurz zusammenfassen: Überfälliges zuerst |
| „Eingang leeren“ | jede Zeile/Datei einsortieren (Tabelle oben), Unklares nachfragen |
| „Wochenrückblick“ | Ablauf in `01_Cockpit/RUECKBLICK.md` |
| „Neues Projekt …“ | nächste freie Nummer im passenden Bereich (`UEBERSICHT.md`), Ordner `<Nr>_<Name>/`, `PROJEKT.md` aus `09_System/Vorlagen/PROJEKT.md`, Zeile in `UEBERSICHT.md`, Tag festlegen. Nie eine Nummer 70–79 vergeben. |
| „Projekt … abschließen“ | Status und Fazit ins `PROJEKT.md`, Ordner nach `90_Archiv/`, Zeile in `UEBERSICHT.md` ins Archiv; laufende Fristen bleiben |
| „Prüf das Second Brain“ | `09_System/pruefen.sh`, Fehler beheben, Warnungen nennen |

## 6. Speichern

- Nach jeder Änderung: `09_System/pruefen.sh` → bei FEHLER beheben → committen (kurze deutsche Commit-Nachricht) → pushen.
- In jeder neuen Sitzung einmal `git config core.hooksPath 09_System/git-hooks` ausführen (Commit-Sperre).
- `git add -f` und `git commit --no-verify` sind verboten.
