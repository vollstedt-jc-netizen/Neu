# Erfahrungen aus dem Modell Kassel (Haferkakaofabrik)

Lies das vor dem Bauen. Es spart die Fehler, die wir dort gemacht und gefunden haben.

## Ausgangslage
- Gebäude ca. 53,1 × 28,8 m, KG bis 4. OG, denkmalgeschützt, Plan von F. Behrmann (Bestand, Plotdatum 12.03.2025, 1:200).
- Ordner "10 Arbeit Kassel": 17 PDFs (Grundrisse KG bis 4. OG je als "Layout" und als "Flächen", Schnitte A-A bis E-E, Ansicht West), über 100 Fotos und Videos.
- Gesicherte Vorlage: `assets/Bestand_v8_VORLAGE.html`; Drive-Kopie `04_Modell_3D/Staende/2026-11-12_Bestand_v8_VORLAGE/Bestand_v8_VORLAGE.html`.

## Koordinaten und Datenformat der Vorlage
- Plan-x läuft über die lange Seite (0 bis 53,1 m), Plan-y über die kurze (0 bis 28,8 m, im Plan nach oben). In der 3D-Szene ist Szene-x = Plan-x, Szene-y = Höhe, Szene-z = -Plan-y.
- Geschosse (z0 bis z1 in m): KG -2,8 bis 0 · EG 0 bis 4 · 1. OG 4 bis 8 · 2. OG 8 bis 12 · 3. OG 12 bis 16 · 4. OG 16 bis 21. Je Geschoss eine 0,25 m dicke Decke (Fußboden) auf z0; die Wände stehen darüber von z0+0,25 bis z1.
- `D = {W, H, floors:[{name, z0, z1, walls:[[Außenring, [Löcher…]]…], wins:[[cx,cy,w,h]…], stairs:[…]}]}`. Fenster in `wins`: `w` ist die Länge entlang der Wand, `h` die Wandstärke; bei Fenstern in Wänden quer zur x-Achse ist es umgekehrt (Länge in `h`).
- Fenster werden als Brüstung (z0+0,25 bis z0+1,15), Glas (z0+1,15 bis z0+3,35) und Sturz bis Decke gebaut. Wandpolygone sind die Pfeiler zwischen den Fenstern; eine Fensterachse ist also eine Lücke zwischen zwei Pfeilern.
- Das Dach, der Turmaufsatz und der Metallschacht sind von Hand modelliert (Maße aus Ansicht West und Schnitt B-B).
- Das Dach über dem eingeschossigen EG-Teil am Turmende liegt bei z = 4,0.

## Orientierung der Pläne
- Der Nordpfeil im Plan zeigt nach rechts: der Plan ist so gedreht, dass Plan-rechts Norden ist. Die lange Fassade oben im Grundriss schaut nach Westen ("Westansicht"), der Turm liegt am östlichen Ende (Plan-rechts unten, x > 46,6 m, y 0 bis 9,8 m).
- Die Westansicht ist gegenüber dem Modell gespiegelt (Turm links): Ansicht-x = 53,2 - Modell-x - 0,4 m. Senkrecht gilt Modell-z = Ansicht-z - 1,85 m (die Ansicht beginnt am Sockelfuß).
- Schnitt E-E zeigt die Ostwand des Hauptbaus (x ≈ 46,1 m) mit dem Turm links; Ansicht-x = Plan-y - 0,3 m, Schnitthöhe: 1. OG-Decke bei z = 4,0 m.
- PDFs haben `rotation = 90`: immer `page.rotation_matrix` anwenden.

## Was die Prüfung gefunden hat (Typische Fehler, gezielt suchen!)
1. **Stützen fehlten im 1. bis 4. OG.** Im Plan 1. bis 3. OG sind sie grau (0,25 bzw. 0,18) und 0,5 m groß, im 4. OG 0,25 m, im KG/EG schwarz (und damit als Wand erfasst). Raster 5,0 m: links x = 5,3 / 10,3 / 15,3 × y = 5,4 / 9,8 / 14,2 / 18,6 / 23,0; rechts x = 30,7 / 35,7 / 40,7 × y = 5,9 / 11,1 / 16,3 / 22,2 plus x = 25,7.
2. **Eine Fensterachse am Westgiebelende (x ≈ 2,8 m, Nordwand) fehlte im 1. bis 3. OG.** Im EG war sie da; im 4. OG kopiert der Code die Lage vom 3. OG.
3. **Ostwand über dem EG-Anbau hatte keine Fenster.** Pfeiler 10,17–13,51 / 15,64–19,16 / 21,16–24,48 m; Fensterachsen bei y = 9,17 / 14,58 / 20,16 / 25,5 m (je ca. 2,0 bis 2,1 m breit). Glas (m über EG-Boden): 1. OG 4,40–6,25, 2. OG 8,57–10,88, 3. OG 12,50–14,76, 4. OG je Achse zwei Fenster à 0,83 m, 16,35–18,22.
4. **Turm-Nordwand und Aufzughalle hatten Lücken** (weiße Aussparungen an den Geschossdecken, durch die man hindurchsah). Die Wandpolygone aus dem Plan sind dort unregelmäßig; sauberer ist es, die Wand als geschlossene Flächen neu aufzubauen. Treppenhausfenster: x ≈ 50,7 und 47,3 m, 0,52 m breit, 1,0 m hoch, bei z = 5,1 / 9,05 / 13,1 (und 4. OG 16,8, dort 1,1 m breit).
5. **Das 4. OG hat laut Ansicht und Schnitt kleinere Doppelfenster**; die Vorlage zeigt an der Nordwand noch die großen Fenster der unteren Geschosse (offen).

## Fallstricke
- **Seite bleibt im Viewer leer**, wenn three.js per Link nachgeladen wird. three.js (r128 + OrbitControls) einbetten.
- **Dunkle Wandseiten durch Glasflächen**: Glas als eigene Box mit Textur, die Wand daneben nicht von hinten sichtbar machen.
- **Fotos aus Kassel** (iPhone 15 Pro Max): Kompass und Brennweite sind in der Datei, GPS hat ca. 130 m Fehler. Position nie aus dem GPS nehmen.
- Weiße Löcher im Modell sind der beste Hinweis auf fehlende Bauteile.
