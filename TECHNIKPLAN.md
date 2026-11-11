# Technikplan – Second Brain

Stand: 11.11.2026 · Version 1.0 · gilt für das Repository `Neu` und alle Projekte darin

**Inhalt:** 1 Ziel und Grundsätze · 2 Bestandsaufnahme · 3 Ordnerplan · 4 Datenmodell · 5 Abläufe · 6 Sperrbereich 70–79 · 7 Werkzeuge · 8 Zugriff und Geräte · 9 Sicherheit und Datenschutz · 10 Datensicherung · 11 Ausbaustufen · 12 Offene Entscheidungen · Anhang: Spickzettel

---

## 1. Ziel und Grundsätze

**Ziel:** Ein einziger Ort für alle Projekte, Aufgaben, Fristen, Kontakte, Notizen und Wissen. Claude findet jede Information in Sekunden und hält alles aktuell – egal ob vom PC oder vom Handy. Ausgenommen sind nur die Sonderprojekte im Sperrbereich 70–79.

| Nr | Grundsatz | Warum |
|---|---|---|
| 1 | **Klartext statt Spezialprogramm.** Alles sind Markdown-Dateien. | Lesbar mit jedem Editor, auf GitHub und in 20 Jahren noch. Keine Abhängigkeit von einem Anbieter (wie im Leitfaden Kap. 9 verlangt). |
| 2 | **Git ist Speicher und Verlauf.** Jede Änderung ist ein Commit. | Nichts geht verloren, jede Änderung ist nachvollziehbar und rückgängig zu machen. |
| 3 | **Eine Zeile = ein Eintrag** mit Datum oder ID, Tags und Quelle. | Claude findet Einträge mit einer einfachen Textsuche; man kann sie einzeln zitieren (z. B. `HOF-02`). |
| 4 | **Jede Information steht an genau einem Ort.** Das Cockpit verweist nur. | Keine Doppelpflege, keine widersprüchlichen Stände. Einzige Ausnahme: Termine stehen zusätzlich in `FRISTEN.md`, damit keiner übersehen wird. |
| 5 | **Claude pflegt, der Mensch entscheidet.** | Dieselben Standard-Regeln wie im Leitfaden Kap. 3: nichts löschen, nichts ohne Freigabe abschicken, keine Passwörter. |
| 6 | **Sperrbereich 70–79 ist strikt getrennt.** | Sonderprojekte sollen nicht im Second Brain landen – technisch abgesichert, nicht nur per Absprache (Kap. 6). |

---

## 2. Bestandsaufnahme (11.11.2026)

Vorher lagen drei Projekte auf drei getrennten Branches. Der Standard-Branch enthielt nur den Leitfaden, und ein Gedächtnis gab es nur für die Bauleitung.

| Projekt | Vorher | Jetzt |
|---|---|---|
| Claude auf dem Hof (Beratung) | `Leitfaden_Claude_Landwirtschaft.docx` im Hauptordner | `10_Hof_Beratung/` + Steckbrief, Wissen (HOF-01…08), Aufgaben A-005…010 |
| Bauleitung | `Bauleitung/` auf eigenem Branch, eigenes Gedächtnis | `20_Bauleitung/` – Inhalt unverändert, Regeln in `20_Bauleitung/CLAUDE.md`, Aufgaben A-011/012 |
| Marktstand verkaufen | `Kleinanzeige_Marktstand.md` auf eigenem Branch | `30_Marktstand/` + Steckbrief, Aufgaben A-013…017 |

**Befunde, die der Plan löst:**
- Die Projekte waren nicht verbunden. → Jetzt gibt es einen Branch mit gemeinsamem Cockpit und gemeinsamer Suche.
- Es gab keinen Eingang, keine Aufgaben- und Fristenliste und keinen Rückblick. → Jetzt gibt es `00_Eingang` und `01_Cockpit`.
- **Das Repository ist öffentlich.** → Bis zur Umstellung gilt eine Sperre für persönliche Daten (Kap. 9, Aufgabe A-001).

---

## 3. Ordnerplan

### 3.1 Nummernschema

Jeder Ordner im Hauptordner hat eine zweistellige Nummer. Die **Zehnerstelle ist der Bereich**, die Einerstelle das Projekt im Bereich. So bleibt die Reihenfolge überall gleich (Explorer, GitHub, Handy), und jede Nummer ist eine kurze, eindeutige Adresse.

| Bereich | Inhalt | Belegt |
|---|---|---|
| 00–09 | **System:** Eingang, Cockpit, Gedächtnis, Werkzeuge | 00, 01, 02, 09 |
| 10–19 | **Landwirtschaft & Beratung** | 10 Hof-Beratung |
| 20–29 | **Bau** | 20 Bauleitung |
| 30–39 | **Verkauf & Sonstiges** | 30 Marktstand |
| 40–69 | frei für neue Bereiche | – |
| **70–79** | **Sperrbereich – Sonderprojekte, nicht Teil des Second Brain** | wird nirgends aufgeführt |
| 80–89 | reserviert: Referenz & Nachschlagewissen (falls `02_Gedaechtnis` zu groß wird) | – |
| 90–99 | **Ablage:** 90 Archiv, 99 Aussortiert | 90, 99 |

**Regeln:**
- Neues Projekt → nächste freie Nummer im passenden Bereich. Passt kein Bereich, dann einen neuen ab 40 eröffnen.
- Nummern werden **nie neu vergeben**. Ein abgeschlossenes Projekt wandert mit seiner Nummer ins Archiv (`90_Archiv/30_Marktstand/`).
- Eine Nummer 70–79 vergibt Claude nie für ein Second-Brain-Projekt.

### 3.2 Aufbau

```
Neu/                              Hauptordner = Second Brain
├── README.md                     Startseite und Karte
├── CLAUDE.md                     Arbeitsregeln für Claude (lädt automatisch)
├── TECHNIKPLAN.md                dieser Plan
├── .gitignore                    Schicht 1: sperrt 70–79 für git
├── .claude/settings.json         Schicht 3: sperrt 70–79 für Claude
│
├── 00_Eingang/EINGANG.md         ── System ──
├── 01_Cockpit/                   UEBERSICHT · AUFGABEN · FRISTEN · RUECKBLICK
├── 02_Gedaechtnis/               NOTIZEN · KONTAKTE · WISSEN
├── 09_System/                    frag.sh · pruefen.sh · git-hooks/ · Vorlagen/
│
├── 10_Hof_Beratung/              ── Projekte ── PROJEKT.md · WISSEN.md · Leitfaden.docx
├── 20_Bauleitung/                PROJEKT.md · CLAUDE.md · README.md · _gedaechtnis/ · Kapitel · Vorlagen · Checkliste
├── 30_Marktstand/                PROJEKT.md · Kleinanzeige_Marktstand.md
│
├── (7x_…)                        ── Sperrbereich ── nur lokal, nie in git, nie durchsucht
│
├── 90_Archiv/                    ── Ablage ──
└── 99_Aussortiert/
```

### 3.3 Aufbau eines Projektordners

| Datei | Pflicht? | Zweck |
|---|---|---|
| `PROJEKT.md` | ja | Steckbrief: Tag, Status, Ziel, Stand, Dateien, Entscheidungen (Vorlage `09_System/Vorlagen/PROJEKT.md`) |
| `CLAUDE.md` | bei Bedarf | Projektregeln. Claude lädt sie automatisch, sobald es im Ordner arbeitet. So bleibt die Haupt-CLAUDE.md kurz. |
| `WISSEN.md` | bei Bedarf | Fakten mit Quelle, eigenes ID-Präfix (z. B. `HOF-`) |
| Unterordner | frei | Dateien, Vorlagen, Kundenakten … Dateinamen `JJJJ-MM-TT_Thema_Partner.ext` |

---

## 4. Datenmodell – die Gedächtnis-Dateien

### 4.1 Dateien und Zeilenformate

| Datei | Zweck | Zeilenformat |
|---|---|---|
| `00_Eingang/EINGANG.md` | alles Neue, noch nicht einsortiert | `JJJJ-MM-TT \| Text` |
| `01_Cockpit/UEBERSICHT.md` | alle Projekte: Status, nächster Schritt | Tabelle, eine Zeile je Projekt |
| `01_Cockpit/AUFGABEN.md` | alle offenen Aufgaben, nach Projekt gruppiert | `- [ ] A-001 #tag \| Aufgabe \| bis JJJJ-MM-TT` |
| `01_Cockpit/FRISTEN.md` | alle Termine, nach Datum sortiert | `JJJJ-MM-TT #tag #thema \| Was \| Bezug` |
| `01_Cockpit/RUECKBLICK.md` | Ablauf und Protokoll des Wochenrückblicks | `JJJJ-Www \| Fazit` |
| `02_Gedaechtnis/NOTIZEN.md` | Vorlieben, projektübergreifende Entscheidungen | `JJJJ-MM-TT #tags \| Notiz` |
| `02_Gedaechtnis/KONTAKTE.md` | Personen und Firmen | `KON #tags \| Wer \| Telefon \| Sonstiges` |
| `02_Gedaechtnis/WISSEN.md` | projektübergreifendes Wissen (CLA, SYS) | `ID #tags \| Fakt \| Quelle` |
| `<Projekt>/WISSEN.md` | Projektwissen (HOF, UNF, BG …) | `ID #tags \| Fakt \| Quelle` |
| `<Projekt>/PROJEKT.md` | Steckbrief | Vorlage |
| `20_Bauleitung/_gedaechtnis/PROJEKTE.md` | Baustellen | Block `## BST-<Name>` |

### 4.2 Tags und IDs

- **Projekt-Tags:** `#hof` (10), `#bau` (20), `#markt` (30), `#system` (00–09). Jede Aufgabe, Frist und Notiz trägt genau einen Projekt-Tag.
- **Themen-Tags** frei wählbar und klein geschrieben: `#frist`, `#unfall`, `#datenschutz` … `frag.sh -t` zeigt alle mit Häufigkeit.
- **IDs** sind im ganzen Second Brain eindeutig und werden nie neu vergeben: `A-001` Aufgaben · `CLA-`, `SYS-` allgemeines Wissen · `HOF-` Hof · `UNF-`, `BG-`, `VOR-` … `UMW-` Bau · `BST-` Baustellen · `KON` Kontakte. `pruefen.sh` meldet doppelte IDs.

### 4.3 Wohin mit einer neuen Information?

| Es ist … | Dann … |
|---|---|
| unklar oder schnell notiert | `EINGANG.md` |
| etwas zu tun | `AUFGABEN.md` |
| ein Datum, das nicht verpasst werden darf | `FRISTEN.md` (braucht es Vorarbeit, zusätzlich eine Aufgabe) |
| eine Person oder Firma | `KONTAKTE.md` (Bau-Notfallkontakte: `20_Bauleitung/_gedaechtnis/KONTAKTE.md`) |
| eine Entscheidung oder Vorliebe | projektbezogen: `PROJEKT.md` → Entscheidungen; sonst `NOTIZEN.md` |
| ein geprüfter Fakt mit Quelle | `WISSEN.md` des Projekts, sonst `02_Gedaechtnis/WISSEN.md` |
| eine neue Baustelle | `20_Bauleitung/_gedaechtnis/PROJEKTE.md` + Termine in `FRISTEN.md` |
| eine Datei | in den Projektordner, sonst nach `00_Eingang/` |
| etwas aus einem Sonderprojekt 70–79 | **nirgends im Second Brain** |

---

## 5. Abläufe

### 5.1 Erfassen – jederzeit, in Sekunden
„Notiere: …“ an Claude (Handy oder PC). Ist eindeutig, wohin es gehört, schreibt Claude es direkt dorthin, sonst in den Eingang. Danach prüft Claude, committet und pusht. Dateien wie Fotos, Lieferscheine oder Sprachnotizen kommen nach `00_Eingang/`.

### 5.2 Eingang leeren – täglich oder beim Rückblick
„Eingang leeren“: Claude sortiert jede Zeile und jede Datei nach der Tabelle 4.3 ein. Unklares fragt Claude nach. `pruefen.sh` warnt, wenn etwas länger als 7 Tage liegt.

### 5.3 Abfragen
„Was weißt du über …?“: Claude ruft zuerst `09_System/frag.sh` auf, nennt ID und Quelle und liest nur bei Bedarf ganze Kapitel. „Was steht an?“ läuft über `frag.sh -o`: offene Aufgaben, Überfälliges, Fristen der nächsten 60 Tage und den Eingang.

### 5.4 Wochenrückblick – freitags, 15 Minuten
„Wochenrückblick“ startet den Ablauf in `01_Cockpit/RUECKBLICK.md`: Eingang leeren, Aufgaben abhaken, Fristen der nächsten 4 Wochen ansehen, Projektstände in der Übersicht aktualisieren, `pruefen.sh` laufen lassen und eine Zeile ins Protokoll schreiben.

### 5.5 Neues Projekt
„Neues Projekt: …“: Claude wählt die nächste freie Nummer im passenden Bereich und legt den Ordner `<Nr>_<Name>/` an. Dazu kommen ein `PROJEKT.md` aus der Vorlage, eine Zeile in `UEBERSICHT.md`, ein Projekt-Tag und die ersten Aufgaben.

### 5.6 Projekt abschließen
Claude trägt Status „abgeschlossen“ und ein Fazit ins `PROJEKT.md` ein und verschiebt den Ordner nach `90_Archiv/<Nr>_<Name>/`. Die Projektzeile wandert in den Archiv-Abschnitt der Übersicht. Fristen, die weiterlaufen (z. B. Gewährleistung), bleiben in `FRISTEN.md`.

### 5.7 Aufräumen
Nichts wird gelöscht. Überflüssiges wandert nach `99_Aussortiert/`, und leeren darf nur der Inhaber. Zusätzlich bewahrt git jede frühere Fassung auf.

---

## 6. Sperrbereich 70–79

### 6.1 Was er ist
Die Ordner 70–79 sind für **Sonderprojekte**. Sie liegen im selben Nummernsystem und auf dem PC im selben Hauptordner, gehören aber **nicht zum Second Brain**:
- Sie werden nicht in git gespeichert, nicht zu GitHub hochgeladen und fehlen deshalb in Cloud-Sitzungen.
- Claude liest oder durchsucht sie im Second Brain nicht und übernimmt nichts daraus.
- Kein Second-Brain-Dokument nennt oder verlinkt sie, auch nicht die Übersicht.

### 6.2 Sechs Schutzschichten

| Nr | Schicht | Technik | Schützt vor | Status |
|---|---|---|---|---|
| 1 | Git-Sperre | `.gitignore`: `/7[0-9]*` | Ordner wird versehentlich committet, gepusht oder öffentlich | ✔ eingerichtet, getestet (70 und 79 ignoriert; 07, 69, 80 nicht) |
| 2 | Commit-Sperre | `09_System/git-hooks/pre-commit` ruft `pruefen.sh --hook` auf | Erzwungenes `git add -f` | ✔ eingerichtet – je Rechner einmal einschalten (A-003) |
| 3 | Claude-Zugriffssperre | `.claude/settings.json`: `deny` für `Read`/`Edit` auf `/70*/**` … `/79*/**` | Claude liest oder ändert Dateien in 70–79 (auch über `cat`, `head`, `sed`) | ✔ eingerichtet, getestet (Lesen und `cat` werden abgelehnt) |
| 4 | Werkzeug-Sperre | `frag.sh` und `pruefen.sh` überspringen 70–79 fest | Suche über `grep -r`, die Schicht 3 nicht erfasst | ✔ eingerichtet, getestet |
| 5 | Regel-Sperre | `CLAUDE.md` Abschnitt 0 | Inhalte aus dem Gespräch („übrigens, bei Projekt X …“) werden notiert | ✔ eingerichtet |
| 6 | Kontrolle | `pruefen.sh`: Dateien aus 70–79 in git? Verweise auf 7x-Ordner? Sperrregeln vollständig? | Schleichende Fehler, geänderte Sperren | ✔ läuft vor jedem Commit |

### 6.3 So arbeitest du in einem Sonderprojekt

1. **Ordner anlegen** – auf dem PC im Hauptordner, z. B. `7x_<Name>` (x = 0–9). Git ignoriert ihn automatisch.
2. **Empfohlen: ein eigenes privates Repository je Sonderprojekt.** Dann hat das Projekt eine eigene Sicherung und eigene Zugriffsrechte und lässt sich als eigene Cloud-Sitzung nutzen. Das Second Brain bekommt davon nichts mit, weil git den Ordner ignoriert.
3. **Claude für das Sonderprojekt direkt im Ordner 7x starten** (Desktop-App: diesen Ordner wählen; Cloud: das eigene Repository). Die Zugriffssperre aus Schicht 3 gilt dort nicht, weil Claude Code `.claude/settings.json` nur aus dem Startordner liest.
4. **Achtung:** Claude lädt beim Start in einem Unterordner die `CLAUDE.md` der darüberliegenden Ordner mit. Dagegen gibt es zwei Maßnahmen:
   - Abschnitt 0 der Haupt-`CLAUDE.md` sagt: „Startordner in 70–79 → diese Datei gilt nicht.“
   - Im Sonderprojekt `.claude/settings.json` mit `claudeMdExcludes` anlegen, dann wird die Haupt-CLAUDE.md gar nicht erst geladen. Vorlagen dafür: `09_System/Vorlagen/Sonderprojekt/` (`CLAUDE.md.vorlage`, `settings.json.vorlage`).
5. **Kein Austausch in beide Richtungen.** Was ein Sonderprojekt braucht (z. B. eine Telefonnummer), pflegt es selbst.
6. **Datensicherung** des Sperrbereichs ist eigene Aufgabe (Kap. 10), denn GitHub sichert ihn bewusst nicht.

**Noch strenger:** Sonderprojekte ganz außerhalb des Second-Brain-Ordners ablegen. Die Nummer 7x bleibt als Name erhalten, dann entfällt Punkt 4.

### 6.4 Grenzen (ehrlich)
- Schicht 3 setzt Claude Code durch, nicht das Betriebssystem. Ein Skript (z. B. Python), das Claude ausführt, könnte theoretisch trotzdem lesen. Dafür gibt es Schicht 5 (Regel) und Schicht 4 (eigene Werkzeuge). Eine Sperre auf Betriebssystem-Ebene wäre nur mit der Sandbox von Claude Code möglich.
- Die Commit-Sperre (Schicht 2) muss in jeder lokalen Kopie einmal eingeschaltet werden. Schicht 1 wirkt immer.
- In Cloud-Sitzungen gibt es 70–79 gar nicht, weil der Bereich nie in git ist. Das ist der sicherste Fall.

---

## 7. Werkzeuge

| Werkzeug | Aufruf | Zweck |
|---|---|---|
| `09_System/frag.sh` | `frag.sh gülle frist` | UND-Suche über alle Gedächtnis-Dateien (Groß/klein und ä/ae egal) |
| | `frag.sh -a`, `-x` | alle Dateien bzw. mit Archiv |
| | `frag.sh -t` | Tags mit Häufigkeit |
| | `frag.sh -o` | Cockpit: offene Aufgaben, überfällige und kommende Fristen, Eingang |
| `09_System/pruefen.sh` | `pruefen.sh` | Gesundheitscheck: Sperrbereich, Geheimnisse (Passwort, PIN, IBAN), doppelte IDs, überfällige Fristen und Aufgaben, alter Eingang, Projekt-Steckbriefe, Sichtbarkeit des Repositorys |
| | `--offline`, `--hook` | ohne Online-Prüfung bzw. nur Fehler (im git-Hook) |
| `09_System/git-hooks/pre-commit` | `git config core.hooksPath 09_System/git-hooks` | blockiert Commits mit FEHLER |
| `09_System/Vorlagen/` | – | `PROJEKT.md`, Sonderprojekt-Vorlagen |
| `20_Bauleitung/_gedaechtnis/frag.sh` | wie bisher | Suche nur in der Bauleitung |
| `20_Bauleitung/_werkzeuge/checkliste_bauen.py` | `python3 …` | Checkliste aus JSON erzeugen |
| `20_Bauleitung/_werkzeuge/vorlagen_zu_word.py` | `python3 …` | Vorlagen als Word-Dateien (braucht pandoc) |

Die Werkzeuge brauchen nur bash, git und Standard-Unix-Programme. In der Cloud-Sitzung, unter Linux und macOS laufen sie direkt, unter Windows über Git Bash, das mit „Git für Windows“ installiert wird.

---

## 8. Zugriff und Geräte

| Gerät | Weg | Hinweise |
|---|---|---|
| **Handy** | Claude-App → Claude Code → Repository `Neu` | Ideal zum Erfassen und Abfragen. Claude schreibt, committet und pusht selbst. |
| **PC** | Claude Desktop-App oder Claude Code im **Hauptordner** des geklonten Repositorys | Nur im Hauptordner greift die Claude-Sperre für 70–79. Vor der Arbeit `git pull`, danach pushen (macht Claude). |
| **Browser** | GitHub-Webseite des Repositorys | Zum Lesen und für kleine Änderungen; nach der Umstellung auf privat nur angemeldet. |

**Branches:** Ein Hauptzweig `main` ist der gültige Stand. Claude-Sitzungen arbeiten auf eigenen Zweigen und werden per Pull Request zusammengeführt. Heute ist ein automatisch benannter Branch (`ccr-…`) als Standard eingestellt. Empfehlung: `main` aus diesem Stand anlegen und in GitHub unter Settings → General → Default branch festlegen (A-002).

---

## 9. Sicherheit und Datenschutz

**Sofort-Maßnahme: Repository auf privat stellen (A-001).**
GitHub → Repository `Neu` → Settings → General → ganz unten „Danger Zone“ → „Change visibility“ → „Make private“.
Was bisher öffentlich war, kann bereits kopiert worden sein. Heute stehen dort keine Zugangsdaten, wohl aber Vornamen und der Leitfaden.

| Regel | Umsetzung |
|---|---|
| Solange öffentlich: keine persönlichen Daten | `CLAUDE.md` Abschnitt 1; `pruefen.sh` meldet „ÖFFENTLICH“ |
| Nie speichern: Passwörter, PINs, TANs (HIT-PIN), Zugangsdaten, IBAN | `CLAUDE.md`; `pruefen.sh` blockiert typische Muster |
| Gesundheitsdaten (Krankheitsbuch, Unfälle) und Kundendaten nur so viel wie nötig | Kundenakten erst nach A-001 und mit Datenschutz-Vereinbarung (Leitfaden Kap. 9) |
| Was Claude liest, wird an Anthropic übertragen | `CLA-01`; gilt auch fürs Second Brain |
| GitHub-Konto mit Zwei-Faktor-Anmeldung | einmalig einrichten |
| Handy mit Bildschirmsperre; bei Verlust in GitHub und Claude abmelden | wie Leitfaden Kap. 4 |

---

## 10. Datensicherung

| Was | Kopie 1 | Kopie 2 | Kopie 3 |
|---|---|---|---|
| Second Brain | GitHub | lokaler Klon auf dem PC | monatlich `git bundle create Sicherung_JJJJ-MM-TT.bundle --all` auf externe Festplatte |
| Sperrbereich 70–79 | **nicht über das Second Brain** | eigenes privates Repository je Sonderprojekt | externe Festplatte |

**Wiederherstellen:** `git clone <GitHub-Adresse>` oder `git clone Sicherung_….bundle`. Sonderprojekte stellst du getrennt aus ihren eigenen Sicherungen wieder her.

---

## 11. Ausbaustufen

| Phase | Inhalt | Wer | Status |
|---|---|---|---|
| **1 Fundament** | Ordnerplan, Zusammenführung der drei Projekte, Cockpit, Gedächtnis, Regeln, Werkzeuge, Sperrbereich mit sechs Schichten | Claude | ✔ erledigt (11.11.2026) |
| **2 In Betrieb nehmen** (~1 h) | Repository privat (A-001) · in `main` übernehmen (A-002) · PC einrichten, Commit-Sperre einschalten (A-003) · offene Fragen klären (A-004) · eine Woche täglich „Notiere …“ und „Was steht an?“ nutzen | du | offen |
| **3 Komfort** (nach 2–4 Wochen) | Fristen mit Erinnerung in den Google Kalender übertragen (Kalender ist verbunden) · Wochenrückblick als geplante Aufgabe jeden Freitag · Skill „Second Brain“ für Erfassen und Eingang leeren · Cockpit als Handy-Seite (Aufgaben und Fristen zum Abhaken) | Claude, nach Freigabe | geplant |
| **4 Wachstum** (bei Bedarf) | Wissen nach Bereichen aufteilen bzw. Bereich 80–89 nutzen, wenn eine Datei über ~2.000 Zeilen wächst · Volltextsuche in PDFs (Textauszug neben jeder PDF) · Kundenakten der Hof-Beratung · neue Bereiche ab 40 | Claude | bei Bedarf |

---

## 12. Offene Entscheidungen

1. **Repository privat stellen?** Dringend empfohlen, sonst bleibt das Second Brain ohne persönliche Daten.
2. **Weitere Projekte?** Der Leitfaden erwähnt eigene Skills „Rechnung erstellen“ und „Mietakten“. Gehören Rechnungen oder Vermietung als Projekte ins Second Brain (z. B. neuer Bereich 40–49)?
3. **Bereich 30–39** heißt vorläufig „Verkauf & Sonstiges“. Passt der Name, oder gehört der Marktstand eher zum Hof?
4. **Sonderprojekte:** eigene private Repositorys (empfohlen) oder nur lokale Ordner mit Festplatten-Sicherung?
5. **Hauptzweig `main`** anlegen und als Standard festlegen?

---

## Anhang: Spickzettel

| Du sagst … | Claude … |
|---|---|
| „Notiere: Tim am Freitag wegen Termin anrufen“ | legt eine Aufgabe mit `#hof` und Fälligkeit an |
| „Frist: Abnahme Halle am 15.12.“ | trägt sie in `FRISTEN.md` ein (und bei der Baustelle) |
| „Was steht an?“ | zeigt Überfälliges, offene Aufgaben, die nächsten Fristen und den Eingang |
| „Was weißt du über Gülle?“ | sucht mit `frag.sh`, antwortet mit ID und Quelle |
| „Eingang leeren“ | sortiert alles Neue ein |
| „Neues Projekt: Mietakten“ | legt Ordner, Steckbrief und Übersichtszeile an |
| „Wochenrückblick“ | arbeitet `RUECKBLICK.md` ab |
| „Projekt Marktstand abschließen“ | archiviert das Projekt |
| „Prüf das Second Brain“ | führt `pruefen.sh` aus und behebt Fehler |
