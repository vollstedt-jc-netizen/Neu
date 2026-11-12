#!/usr/bin/env python3
"""Liest Geometrie aus dem Vektoranteil eines Bauplan-PDFs (Grundriss, Schnitt, Ansicht).

Warum Vektoren statt Bild: Maße sind auf 0,01 m genau und es gibt keine Schätzfehler durch Pixel.

Ausgabe (JSON): Bounding-Box der schwarzen Wandflächen, Stützen (kleine Quadrate),
Glasflächen (Fenster) und alle gefüllten Rechtecke gruppiert nach Füllfarbe.
Koordinaten in Metern, Ursprung = linke untere Ecke der Wandflächen in Anzeigerichtung
(Seitenrotation ist bereits herausgerechnet, y zeigt nach OBEN).

Aufruf:  pdf_plan.py plan.pdf [--scale 200] [--out plan.json]
"""
import argparse, json, collections, warnings
warnings.filterwarnings("ignore")
import pymupdf as fitz


def load(pdf, scale=200):
    pg = fitz.open(pdf)[0]
    M = pg.rotation_matrix                      # Seitenrotation berücksichtigen
    S = 72 / 25.4 * (1000 / scale)              # Punkte pro Meter im Plan
    items = []
    for d in pg.get_drawings():
        r = d["rect"] * M
        items.append((d.get("fill"), d.get("color"), r, d["type"]))
    return pg, S, items


def analyse(pdf, scale=200):
    pg, S, items = load(pdf, scale)
    black = [r for f, c, r, t in items if f and max(f) < 0.05 and r.width < 400 and r.height < 400]
    if not black:
        raise SystemExit("keine schwarzen Wandflächen gefunden")
    bx0 = min(r.x0 for r in black); bx1 = max(r.x1 for r in black)
    by0 = min(r.y0 for r in black); by1 = max(r.y1 for r in black)

    def to_m(r):  # PDF-Rechteck -> (x0,y0,x1,y1) in m, y nach oben
        return [round((r.x0 - bx0) / S, 3), round((by1 - r.y1) / S, 3),
                round((r.x1 - bx0) / S, 3), round((by1 - r.y0) / S, 3)]

    by_fill = collections.defaultdict(list)
    for f, c, r, t in items:
        if f:
            by_fill[tuple(round(v, 2) for v in f)].append(to_m(r))

    cols, glass = [], []
    for f, rects in by_fill.items():
        g = max(f)
        for q in rects:
            w, h = q[2] - q[0], q[3] - q[1]
            if 0.15 < w < 0.9 and 0.15 < h < 0.9 and abs(w - h) < 0.2 and g < 0.6:
                cols.append([round((q[0] + q[2]) / 2, 2), round((q[1] + q[3]) / 2, 2), round((w + h) / 2, 2), list(f)])
        # Glas = helle, bläuliche Füllung (b > r)
        if len(f) == 3 and f[2] > f[0] + 0.05 and g > 0.8:
            glass += rects
    return {
        "datei": pdf, "massstab": f"1:{scale}",
        "wand_bbox_m": [0, 0, round((bx1 - bx0) / S, 2), round((by1 - by0) / S, 2)],
        "stuetzen_kandidaten": sorted({tuple(c[:3]) for c in cols}),
        "glasflaechen": glass,
        "fuellfarben": {str(k): len(v) for k, v in sorted(by_fill.items(), key=lambda kv: -len(kv[1]))[:15]},
    }


if __name__ == "__main__":
    ap = argparse.ArgumentParser()
    ap.add_argument("pdf"); ap.add_argument("--scale", type=int, default=200); ap.add_argument("--out")
    a = ap.parse_args()
    res = analyse(a.pdf, a.scale)
    txt = json.dumps(res, ensure_ascii=False, indent=1)
    if a.out: open(a.out, "w").write(txt)
    print(txt[:3000])
