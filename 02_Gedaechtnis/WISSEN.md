# WISSEN – projektübergreifend

Eine Zeile = ein Fakt · Format: `ID #tags | Fakt | Quelle` · ⚠ = unsicher, vor Verwendung prüfen.
Projektwissen steht im Projekt: `10_Hof_Beratung/WISSEN.md` (HOF), `20_Bauleitung/_gedaechtnis/WISSEN.md` (UNF, BG, VOR …).
ID-Präfixe hier: **CLA** = Arbeiten mit Claude/KI · **SYS** = Technik des Second Brain. IDs sind im ganzen Second Brain eindeutig.

## Arbeiten mit Claude
CLA-01 #claude #datenschutz | Dateien bleiben auf dem eigenen Rechner bzw. im Repository gespeichert; was Claude liest oder bearbeitet, wird zur Verarbeitung an die Server von Anthropic geschickt. | Leitfaden Kap. 1
CLA-02 #claude | Claude kann sich irren. Die Verantwortung für Meldungen, Zahlen und Unterschriften bleibt beim Menschen. | Leitfaden Kap. 1
CLA-03 #claude #regeln | Standard-Regeln: nichts löschen (verschieben nach 99_Aussortiert), nichts ohne Freigabe abschicken, keine Zahlungen, keine Passwörter/PINs/TANs in den Chat, bei Unklarheit nachfragen. | Leitfaden Kap. 3
CLA-04 #claude #skill | Ein Skill ist eine fest eingeübte Arbeitsanweisung; Aufbau: Aufgabe durchspielen → Vorlagen sammeln → Ein-/Ausgabe festlegen → mit Skill Creator bauen → an 3 echten Fällen testen → freigeben. | Leitfaden Kap. 6

## Technik des Second Brain
SYS-01 #system #sperrbereich | Ordner 70–79 sind durch .gitignore, Commit-Sperre, Claude-Zugriffssperre (.claude/settings.json) und die Werkzeuge vom Second Brain getrennt. | TECHNIKPLAN.md Kap. 6
SYS-02 #system #claude | Die Zugriffssperre in `.claude/settings.json` greift nur, wenn Claude im Hauptordner gestartet wird; CLAUDE.md-Dateien darüberliegender Ordner lädt Claude dagegen immer mit. | code.claude.com/docs (Settings, Memory), 11/2026
SYS-03 #system #sicherung | Vollständige Sicherung samt Verlauf: `git bundle create Sicherung_JJJJ-MM-TT.bundle --all`; wiederherstellen mit `git clone Sicherung_….bundle`. | git-Dokumentation
