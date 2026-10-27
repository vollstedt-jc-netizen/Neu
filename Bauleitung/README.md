# Bauleitung

Alles, was ein Bauleiter griffbereit haben muss: Sicherheitsvorschriften, BG BAU, Unfallablauf, Formulare, Vertragsfristen – plus ein Gedächtnis, das Claude in Sekunden abfragt, und eine Checkliste zum Abhaken.

Stand: 10/2026 · Sicht: Bauleiter des ausführenden Unternehmens · Ohne Gewähr – bei Rechtsfragen Originaltext prüfen.

## Schnellzugriff

| Ich brauche … | Datei |
|---|---|
| **Es ist ein Unfall passiert** | [00_Notfall/Ablauf_bei_Unfall.md](00_Notfall/Ablauf_bei_Unfall.md) |
| Notfall-Aushang für den Container | [00_Notfall/Notfall_Aushang.md](00_Notfall/Notfall_Aushang.md) · Word: [Vorlagen/Word/Notfall_Aushang.docx](Vorlagen/Word/Notfall_Aushang.docx) |
| Unfallzettel / Verbandbuch | [Vorlagen/Unfall-Erfassungsbogen.md](Vorlagen/Unfall-Erfassungsbogen.md) · [Vorlagen/Verbandbuch.md](Vorlagen/Verbandbuch.md) |
| Checkliste zum Abhaken | Online: <https://claude.ai/artifact/1nA34SWgdVqcVRFwTUcoY3> · Papier: [Checkliste/CHECKLISTE.md](Checkliste/CHECKLISTE.md) |
| Eine Frist oder einen Grenzwert | [_gedaechtnis/WISSEN.md](_gedaechtnis/WISSEN.md) (oder Claude fragen) |

## Inhalt

| Ordner | Inhalt |
|---|---|
| `00_Notfall/` | Ablauf bei Unfall, Notfall-Aushang |
| `01_Vorschriften/` | Rechtsgrundlagen und Regelwerk, Absturz/Gerüste/Leitern, Erdarbeiten/Leitungen, Elektro/Maschinen/Krane, Gefahrstoffe/Brandschutz, PSA/Lärm/Klima, Verkehrssicherung |
| `02_BG_BAU/` | Berufsgenossenschaft: Pflichten, Unfallanzeige, D-Arzt, Leistungen, Angebote |
| `03_Arbeitsschutz_Organisation/` | Gefährdungsbeurteilung, Unterweisung, Pflichtenübertragung, Erste Hilfe, Vorsorge, Baustellenordner, Prüffristen |
| `04_Baustellenverordnung/` | Vorankündigung, SiGe-Plan, SiGeKo, Anhang II, Vorankündigungs-Formular |
| `05_Vertrag_VOB/` | Bedenken-, Behinderungs-, Mehrkostenanzeige, Abnahme, VOB/B-Fristen, Nachträge |
| `06_Personal_Nachunternehmer/` | Ausweispflicht, Arbeitszeit, Mindestlohn, NU-Unterlagen, Haftung, Bauabzugsteuer, Zoll |
| `07_Umwelt_Entsorgung/` | Abfalltrennung, Boden, Bäume, Wasser, Baulärm, Funde |
| `Vorlagen/` | 19 Formulare als Markdown, druckfertig als Word unter `Vorlagen/Word/` |
| `Checkliste/` | Abhak-Checkliste (Quelle `checkliste.json`, Papierfassung `CHECKLISTE.md`, Seite `checkliste.html`) |
| `_gedaechtnis/` | Claudes Gedächtnis: `WISSEN.md` (Fakten), `PROJEKTE.md`, `KONTAKTE.md`, `NOTIZEN.md`, Suchskript `frag.sh` |
| `_werkzeuge/` | Skripte: Checkliste bauen, Vorlagen nach Word |

## Vorlagen

| Arbeitsschutz | Vertrag und Dokumentation |
|---|---|
| Unfall-Erfassungsbogen | Bautagebuch |
| Verbandbuch | Behinderungsanzeige (§6 VOB/B) |
| Beinahe-Unfall-Meldung | Bedenkenanzeige (§4 Abs. 3 VOB/B) |
| Gefährdungsbeurteilung | Mehrkostenanzeige (§2 VOB/B) |
| Unterweisungsnachweis | Stundenlohnzettel (§15 VOB/B) |
| Pflichtenübertragung | Baubesprechung – Protokoll |
| Beauftragung Geräteführer | Mängelliste / Mängelrüge |
| Erlaubnisschein Heißarbeiten | Abnahmeprotokoll |
| Gerüst-Kontrolle | Belehrung Ausweispflicht |
| PSA-Ausgabe | Vorankündigung BaustellV (Ordner 04) |

## Mit Claude arbeiten

- Fragen wie „Ab wann muss ich einen Graben verbauen?“ oder „Welche Frist hat die Unfallanzeige?“ beantwortet Claude aus `_gedaechtnis/WISSEN.md` und nennt die Quelle.
- Sag Claude neue Baustellen, Telefonnummern oder Fristen – Claude trägt sie in `PROJEKTE.md` / `KONTAKTE.md` ein.
- „Was ist auf Baustelle X heute noch offen?“ – Claude liest die Häkchen aus der Online-Checkliste.
- Zuerst ausfüllen: `_gedaechtnis/KONTAKTE.md` (D-Arzt, Krankenhaus, BG-Bezirksverwaltung, Arbeitsschutzbehörde, Störungsnummern).
