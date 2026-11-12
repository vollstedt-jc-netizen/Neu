#!/usr/bin/env node
// Rendert das Modell (HTML-Seite mit globalen Variablen cam, oc) aus einer vorgegebenen Kameraposition.
// Aufruf: node render_pose.js modell.html aus.png '{"pos":[x,y,z],"target":[x,y,z],"fov":30,"w":1200,"h":800,"hide":["Dach","Fußböden"]}'
// Koordinaten wie im Modell-Code: Szene-x = Plan-x, Szene-y = Höhe, Szene-z = -Plan-y.
// "fov" ist der VERTIKALE Bildwinkel in Grad. Aus dem horizontalen Bildwinkel h (Foto) bei Seitenverhältnis a=w/h:
//   fov = 2*atan(tan(h/2)/a)
const { chromium } = require('playwright');
(async () => {
  const [html, out, json] = process.argv.slice(2);
  const p = JSON.parse(json);
  const b = await chromium.launch({ args: ['--use-gl=swiftshader', '--enable-unsafe-swiftshader', '--ignore-gpu-blocklist'] });
  const pg = await b.newPage({ viewport: { width: p.w || 1200, height: p.h || 800 } });
  pg.on('pageerror', e => console.error('Seitenfehler:', e.message));
  await pg.goto('file://' + require('path').resolve(html));
  await pg.waitForTimeout(2500);
  for (const t of (p.hide || [])) await pg.locator('label', { hasText: t }).locator('input').uncheck();
  await pg.addStyleTag({ content: '#ui,#hint{display:none!important}' });   // Bedienfeld nicht mitfotografieren
  await pg.evaluate(q => { cam.fov = q.fov; cam.aspect = innerWidth / innerHeight; cam.updateProjectionMatrix(); oc.target.set(...q.target); cam.position.set(...q.pos); oc.update(); }, p);
  await pg.waitForTimeout(1200);
  await pg.screenshot({ path: out });
  await b.close();
})();
