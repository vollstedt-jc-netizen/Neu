---
name: gebaeude-3d-modell
description: Baut aus Bauplänen (PDF-Grundrisse, Schnitte, Ansichten), Fotos und Videos ein akkurates, interaktives 3D-Modell eines Bestandsgebäudes und prüft es so lange gegen alle Unterlagen, bis keine Abweichung mehr übrig ist. Läuft eigenständig ohne Rückfragen. Immer benutzen, wenn jemand ein Gebäude, eine Fabrik, ein Haus oder einen Bestand als 3D-Modell nachbauen, ein bestehendes Modell gegen Pläne oder Fotos prüfen, fehlende Fenster, Türen oder Stützen ergänzen oder Entwürfe auf Basis einer gesicherten Bestandsvorlage erstellen will, auch wenn das Wort "Skill" oder "Modell" nicht fällt (z. B. "Ordner Kassel durchgehen und Modell bauen", "Foto mit dem Modell vergleichen", "Entwurf Nutzung 2. OG").
---

# Gebäude-3D-Modell aus Plänen und Fotos

Du baust das Modell **selbstständig und ohne Rückfragen**. Der Nutzer ist meist nicht mehr vor Ort und kann nichts nachfotografieren oder nachmessen. Hole deshalb aus den vorhandenen Unterlagen heraus, was geht, und halte schriftlich fest, was du angenommen hast. Eine fehlende Antwort ist kein Grund anzuhalten. Frage nur nach, wenn ohne Unterlagen gar nichts zu tun ist (kein einziger Plan, kein einziges Foto).

## Grundregeln (mit Begründung)

1. **Pläne vor Fotos.** Maße kommen aus den Plänen (Vektordaten sind auf Zentimeter genau). Fotos liefern Lage, Form, Material, Farbe und Details. Fotomaße sind wegen Perspektive unsicher und werden als "aus Foto geschätzt" markiert.
2. **Jede Angabe belegen.** Jedes Bauteil bekommt eine Herkunft: `Plan` (Datei + Ansicht), `Foto` (Dateiname), `geschätzt` oder `offen`. Das ist der eigentliche Wert für den Nutzer: er sieht, worauf er sich verlassen kann.
3. **Nichts erfinden, nichts verstecken.** Fehlt eine Angabe, trage eine plausible Annahme ein und markiere sie. Lass keine Lücke, durch die man ins Gebäude hindurchsehen kann (weiße Löcher im Modell), außer sie ist im Plan belegt.
4. **Die Vorlage bleibt unverändert.** Ist eine gesicherte Vorlage vorhanden (siehe unten), arbeite immer an einer Kopie als neuer Datei und neuer Seite. Entwürfe sind Experimente.
5. **Wiederholen bis es stimmt.** Es gibt keine feste Rundenzahl. Prüfe, behebe, prüfe erneut, bis die Abweichungsliste leer ist oder nur noch Punkte enthält, die mit den vorhandenen Unterlagen nicht klärbar sind. Brich aber ab, wenn zwei Runden hintereinander nichts Neues finden.

## Ablauf

### 0. Bestandsaufnahme
- Finde alle Unterlagen (Ordner des Nutzers, Drive, Repo). Sortiere: PDFs, Fotos, Videos, vorhandene Modelle, Notizen. Lies vorhandene Notizen und `references/kassel-erfahrungen.md`, bevor du Annahmen triffst.
- Gibt es ein vorhandenes Modell oder eine Vorlage, starte davon, statt neu zu bauen. Sonst nimm `assets/Bestand_v8_VORLAGE.html` nur als Code-Gerüst (Datenformat `D`, Bauteil-Routinen, Schalter), nicht als Gebäude.
- Lege eine Arbeitsmappe im Scratchpad an und protokolliere dort alle Annahmen (`annahmen.md`).

### 1. Pläne einlesen
- Klassifiziere jedes PDF (Grundriss je Geschoss, Schnitt, Ansicht) über Titelblock-Text (`pdftotext`) und Aussehen (`pdftoppm -r 110`, dann ansehen).
- `scripts/pdf_plan.py plan.pdf` liefert Wand-Box, Stützenkandidaten, Glasflächen in Metern. Wandpolygone, Öffnungen und Treppen holst du aus denselben Vektoren (`fitz.get_drawings()`), nicht aus dem Bild.
- Kalibriere jeden Plan an der Gebäudebox (Breite/Tiefe müssen zu allen Geschossen passen, Toleranz 0,05 m). Weicht ein Geschoss ab, such den Grund (Anbau, anderes Plotdatum) und notiere ihn.
- Bei Schnitten und Ansichten: Geschosshöhen aus den Deckenlinien, Fensterhöhen aus den Glasflächen. Ansichten sind ggf. gespiegelt, wenn der Betrachter von der anderen Seite schaut. Bestimme die Blickrichtung über Nordpfeil und Schnittmarken, dann prüfe sie an einem erkennbaren Merkmal (Turm, Schacht).

### 2. Modell aufbauen
- Wände aus Polygonen extrudieren, Fenster als Glasfläche mit Sturz und Brüstung, Stützen vom Boden bis zur Decke, Treppen, Decken, Dach, Aufbauten. Je Geschoss eine eigene Gruppe mit Ein-/Ausblend-Schalter; zusätzlich Schalter für Dach und Fußböden.
- Das Modell ist eine einzige eigenständige HTML-Seite mit eingebautem three.js (kein Nachladen aus dem Netz, sonst bleibt die Seite im Viewer leer). Es muss die globalen Variablen `cam` und `oc` haben, damit `scripts/render_pose.js` es aus beliebigen Positionen rendern kann.

### 3. Prüfschleife gegen die Pläne (so oft wie nötig)
Für jede Ansicht und jedes Geschoss: Modell aus derselben Richtung rendern (`render_pose.js`, Dach und Böden je nach Plan ausblenden) und mit dem Plan vergleichen. Prüfe systematisch:
- **Stützen und Wände je Geschoss**: Anzahl und Lage gegen den Grundriss (die Bauteile auf dem Raster aus `pdf_plan.py`). Typischer Fehler: Stützen, die im Plan grau statt schwarz gezeichnet sind, wurden übersehen.
- **Fenster je Fassade und Geschoss**: Anzahl pro Achse gegen die Ansicht. Typischer Fehler: eine Achse am Gebäudeende fehlt, oder Geschosse übernehmen die Fensterlage vom Nachbargeschoss.
- **Löcher**: Fassade aus jeder Himmelsrichtung ansehen. Weiße Flächen, durch die man hindurchsieht, sind fast immer fehlende Wandstücke oder Fenster.
- **Höhen und Absätze**: Geschosshöhen, Dachkanten, Aufbauten gegen die Schnitte.
Führe eine Abweichungsliste (Ort, Soll aus Plan, Ist im Modell, Behebung). Behebe, rendere neu, prüfe dieselben Stellen erneut und suche danach nach neuen Fehlern in der Umgebung der Änderung.

### 4. Fotos und Videos auswerten
Das ist die zweite Prüfschleife. Sie läuft, solange Fotos neue Details oder Abweichungen liefern.
1. **Videos** mit `scripts/video_frames.py` in Einzelbilder zerlegen (ca. 1 Bild pro Sekunde, unscharfe und doppelte raus).
2. **Metadaten** mit `scripts/photo_meta.py`: Brennweite → Bildwinkel, Kompassrichtung, grobes GPS, Schärfe. Sortiere die Fotos grob: Außen/Innen/Detail, und bei Außenfotos nach Gebäudeseite (Kompass, notfalls Bildinhalt). Offensichtlich Unbrauchbares (verwackelt, nur Boden) legst du beiseite, löschst es aber nicht.
3. **Kamera einstellen** (`render_pose.js`): Bildwinkel aus den Metadaten, Blickrichtung aus dem Kompass (Plan-Norden aus dem Nordpfeil des Plans bestimmen, nicht annehmen), Startposition vor der passenden Fassade im geschätzten Abstand. GPS ist zu ungenau für die Position.
4. **Position nachführen**: Suche im Foto markante Fixpunkte (Gebäudeecken, Gesimse, Turmkanten, Fensterreihen) und verschiebe die Modellkamera, bis sie im Render an derselben Stelle liegen. Das geht iterativ per Sichtvergleich (`compare_sheet.py`); wenn `cv2` installiert ist, kannst du mit `solvePnP` und von dir gewählten Punktpaaren genauer werden. Ein Foto zählt als "eingepasst", wenn mindestens drei weit auseinanderliegende Fixpunkte auf wenige Prozent der Bildbreite passen.
5. **Details übernehmen**: Vergleiche systematisch Fensteranzahl und -teilung, Türen, Vorbauten, Sockel, Gesimse, Dachaufbauten, Schornsteine, Fallrohre, Materialien und Farben (Backsteinton und Sockel aus dem Foto abnehmen). Trage Neues ins Modell ein, belege es mit dem Dateinamen.
6. **Mehrere Fotos derselben Stelle gegeneinander prüfen.** Ein Detail gilt als gesichert, wenn es auf zwei Fotos erscheint, sonst als "Foto, einfach belegt".

### 5. Aus schlechten Fotos das Beste herausholen
Der Nutzer kann nicht nachfotografieren. Deshalb gilt:
- **Keine Metadaten** (Messenger-Versand): Bildwinkel schätzen (Smartphone-Hauptkamera ca. 65 bis 70 Grad horizontal bei Querformat), Position und Richtung allein aus dem Bildinhalt bestimmen. Sie sind weiterhin brauchbar.
- **Unscharf oder dunkel**: trotzdem für grobe Formen und Farben nutzen (Dachform, Anzahl der Fensterachsen, Vorbauten). Details daraus nicht übernehmen.
- **Ausschnitte**: Ein Foto, das nur einen Teil der Fassade zeigt, belegt nur diesen Teil. Trage ein, was sichtbar ist.
- **Schräge Ansichten**: Ecken und Dächer sind darin sogar besonders aussagekräftig.
- **Innenfotos**: Nutze sie für Raumhöhen, Stützenform, Fensterlaibungen, Treppen und Aufzüge, soweit sie sich einem Grundriss zuordnen lassen.
- **Videos**: Der Weg entlang der Fassade ist mehr wert als viele Einzelfotos; verfolge, wie sich die Ansicht ändert, und prüfe Fensterachsen Bild für Bild.
Markiere in der Übersicht ausdrücklich, was wegen schlechter Fotos offen bleibt und was nachfotografiert werden sollte. Das ist eine Empfehlung im Bericht, kein Grund zu warten.

### 6. Ergebnis ausliefern
- Modell als **eigenständige HTML-Seite** veröffentlichen (Artifact, privat, Teilen entscheidet der Nutzer) und, wenn ein Drive-Zugang besteht, als versionierte Datei in den Modell-Ordner legen. Bestehende Dateien werden nie überschrieben.
- **Bericht** (kurz, auf Deutsch): Was wurde gebaut, Abdeckung (wie viele Pläne, Fotos eingepasst/nicht eingepasst), Tabelle Bauteil → Herkunft (Plan / Foto / geschätzt / offen), Liste der Annahmen, Liste der noch offenen Abweichungen mit Begründung, Empfehlung "nachfotografieren" nur als Hinweis.
- Entwürfe (neue Nutzung, Umbau, Entwicklungskonzepte) werden immer als Kopie der Vorlage angelegt und im Titel klar als Entwurf gekennzeichnet.

## Vorlage Kassel
`assets/Bestand_v8_VORLAGE.html` ist das gesicherte Bestandsmodell der Haferkakaofabrik Kassel (Stand 12.11.2026). Sie wird nicht verändert. Details und Erfahrungswerte: `references/kassel-erfahrungen.md`.

## Werkzeuge
- `scripts/pdf_plan.py`: Maße, Stützen, Glas aus Plan-PDFs
- `scripts/photo_meta.py`: Bildwinkel, Kompass, GPS, Schärfe je Foto
- `scripts/video_frames.py`: Einzelbilder aus Videos
- `scripts/render_pose.js`: Modell aus beliebiger Kameraposition rendern (Playwright, vorinstalliert)
- `scripts/compare_sheet.py`: Foto neben Modellbild legen
