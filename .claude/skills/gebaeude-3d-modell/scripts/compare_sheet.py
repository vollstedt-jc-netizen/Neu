#!/usr/bin/env python3
"""Legt Foto und Modellbild nebeneinander (zur Sichtprüfung) und beschriftet sie.
Aufruf: compare_sheet.py foto.jpg modell.png aus.png [--titel "IMG_6404 Ost"]
"""
import argparse
from PIL import Image, ImageDraw
ap = argparse.ArgumentParser(); ap.add_argument("foto"); ap.add_argument("modell"); ap.add_argument("out"); ap.add_argument("--titel", default="")
a = ap.parse_args()
f = Image.open(a.foto); 
try:
    from PIL import ImageOps; f = ImageOps.exif_transpose(f)
except Exception: pass
m = Image.open(a.modell).convert("RGB")
H = 900
f = f.convert("RGB").resize((int(f.width * H / f.height), H)); m = m.resize((int(m.width * H / m.height), H))
s = Image.new("RGB", (f.width + m.width + 30, H + 40), "white")
s.paste(f, (10, 30)); s.paste(m, (f.width + 20, 30))
d = ImageDraw.Draw(s); d.text((10, 8), f"FOTO  {a.titel}", fill="black"); d.text((f.width + 20, 8), "MODELL", fill="black")
s.save(a.out)
