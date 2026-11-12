#!/usr/bin/env python3
"""Zieht aus einem Video brauchbare Einzelbilder.

Vorgehen: pro Sekunde einige Kandidaten, danach die unscharfen aussortieren und Bilder, die
dem vorigen zu ähnlich sind (kein neuer Standpunkt = keine neue Information). Das ergibt etwa
1 Bild pro Sekunde beim Gehen. Bild alle paar Millisekunden bringt nichts, die sind fast identisch.

Aufruf:  video_frames.py video.mov ausgabeordner [--fps 2] [--min-schaerfe 60]
"""
import argparse, os, subprocess, sys
import numpy as np
from PIL import Image


def lap_var(im):
    g = np.asarray(im.convert("L").resize((640, int(640 * im.height / im.width))), dtype=float)
    l = g[1:-1, 1:-1] * 4 - g[:-2, 1:-1] - g[2:, 1:-1] - g[1:-1, :-2] - g[1:-1, 2:]
    return float(l.var())


def diff(a, b):
    x = np.asarray(a.convert("L").resize((64, 64)), dtype=float); y = np.asarray(b.convert("L").resize((64, 64)), dtype=float)
    return float(np.abs(x - y).mean())


if __name__ == "__main__":
    ap = argparse.ArgumentParser(); ap.add_argument("video"); ap.add_argument("out")
    ap.add_argument("--fps", type=float, default=2); ap.add_argument("--min-schaerfe", type=float, default=60)
    ap.add_argument("--min-unterschied", type=float, default=6)
    a = ap.parse_args(); os.makedirs(a.out, exist_ok=True)
    tmp = os.path.join(a.out, "_roh"); os.makedirs(tmp, exist_ok=True)
    subprocess.run(["ffmpeg", "-loglevel", "error", "-i", a.video, "-vf", f"fps={a.fps}", "-q:v", "2", os.path.join(tmp, "f_%05d.jpg")], check=True)
    keep, last = 0, None
    for fn in sorted(os.listdir(tmp)):
        p = os.path.join(tmp, fn); im = Image.open(p)
        if lap_var(im) < a.min_schaerfe: os.remove(p); continue
        if last is not None and diff(im, last) < a.min_unterschied: os.remove(p); continue
        os.replace(p, os.path.join(a.out, fn)); last = im; keep += 1
    os.rmdir(tmp)
    print(f"{keep} Bilder behalten in {a.out}")
