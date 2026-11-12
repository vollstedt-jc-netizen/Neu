#!/usr/bin/env python3
"""Liest aus Fotos alles, was für den Abgleich mit dem Modell nützlich ist.

Pro Foto: Größe, Aufnahmezeit, Brennweite (Kleinbild-Äquivalent) und daraus den horizontalen
Bildwinkel, Kompassrichtung (wahr), GPS (nur grob, oft 100 m+ Fehler), Schärfe (Laplace-Varianz).
Fotos ohne Metadaten werden trotzdem aufgeführt (meta=false) - sie sind nicht wertlos,
nur muss die Kamera dann allein aus dem Bildinhalt bestimmt werden.

Aufruf:  photo_meta.py ordner_oder_dateien... [--out meta.json]
"""
import sys, json, math, glob, os, argparse
from PIL import Image, ExifTags
import numpy as np


def dms(v, ref):
    d = float(v[0]) + float(v[1]) / 60 + float(v[2]) / 3600
    return -d if ref in ("S", "W") else d


def sharpness(im):
    g = np.asarray(im.convert("L").resize((800, int(800 * im.height / im.width))), dtype=float)
    lap = g[1:-1, 1:-1] * 4 - g[:-2, 1:-1] - g[2:, 1:-1] - g[1:-1, :-2] - g[1:-1, 2:]
    return float(lap.var())


def one(path):
    out = {"datei": os.path.basename(path), "pfad": path, "meta": False}
    try:
        im = Image.open(path)
    except Exception as e:
        out["fehler"] = str(e); return out
    ex = im.getexif()
    out["groesse"] = im.size
    out["orientierung"] = ex.get(274)
    sub = ex.get_ifd(0x8769)
    f35 = sub.get(41989)
    out["zeit"] = str(sub.get(36867) or ex.get(306) or "")
    out["linse"] = str(sub.get(42036) or "")
    if f35:
        w = im.size[0] if im.size[0] >= im.size[1] else im.size[1]      # lange Seite
        out["brennweite_35mm"] = float(f35)
        out["bildwinkel_lange_seite_grad"] = round(2 * math.degrees(math.atan(36 / (2 * float(f35)))), 1)
        out["meta"] = True
    g = ex.get_ifd(0x8825)
    if g:
        gp = {ExifTags.GPSTAGS.get(k, k): v for k, v in g.items()}
        if "GPSLatitude" in gp:
            out["gps"] = [round(dms(gp["GPSLatitude"], gp.get("GPSLatitudeRef")), 6), round(dms(gp["GPSLongitude"], gp.get("GPSLongitudeRef")), 6)]
            out["gps_fehler_m"] = round(float(gp.get("GPSHPositioningError", -1)), 0)
        if "GPSImgDirection" in gp:
            out["kompass_grad"] = round(float(gp["GPSImgDirection"]), 1)
    out["schaerfe"] = round(sharpness(im), 1)
    out["unscharf"] = out["schaerfe"] < 60
    return out


if __name__ == "__main__":
    ap = argparse.ArgumentParser(); ap.add_argument("quellen", nargs="+"); ap.add_argument("--out")
    a = ap.parse_args()
    files = []
    for q in a.quellen:
        files += sorted(glob.glob(os.path.join(q, "*"))) if os.path.isdir(q) else [q]
    files = [f for f in files if f.lower().endswith((".jpg", ".jpeg", ".png", ".heic"))]
    res = [one(f) for f in files]
    txt = json.dumps(res, ensure_ascii=False, indent=1)
    if a.out: open(a.out, "w").write(txt)
    print(txt)
