# 📚 Groep 7 toetsen – de Harlekijn

Oefentoetsen voor groep 7:

- 🧭 **TopoToets**: https://niels9001.github.io/groep7-toetsen/
- 🌊 **TopoToets – Zeeën en gebergten**: https://harlekijn-groep7-toetsen.vercel.app/zeeen-en-gebergten.html
- 🇬🇧 **English Words**: https://niels9001.github.io/groep7-toetsen/engels.html

## 🧭 TopoToets

Een topo-quiz met dezelfde kaart-en-antwoordenindeling. Tik op een gekleurd land, een stip voor een stad of eiland, of de lijn van de Po en kies rechts de juiste naam. Met de zoomknoppen kun je de kleine landen en dicht bij elkaar liggende steden beter bekijken.

### Wat leer je?

**Landen:** Zwitserland, Oostenrijk, Italië, Roemenië, Turkije, Irak en Iran

**Steden:** Genève, Bern, Wenen, Milaan, Boekarest, Istanbul, Ankara, Bagdad en Teheran
**Overig / wateren:** Po en Sicilië

## 🌊 Zeeën en gebergten

Een nieuwe variant van de TopoToets, zonder de eerdere toets te vervangen. Klik op een bolletje voor een water of gebergte en kies de juiste naam. Met Tab en Enter of de spatiebalk kun je de kaartlocaties ook met het toetsenbord selecteren. Zoom in voor de Ardennen, Het Kanaal en de Straat van Gibraltar. Op grote schermen vult de kaart de beschikbare ruimte naast de antwoordkolom; op mobiel staat de kaart boven de antwoorden. Er staat geen begintip boven de antwoordopties.

**Wateren (7):** Noordzee, Het Kanaal, Straat van Gibraltar, Middellandse Zee, Oostzee, Zwarte Zee en Kaspische Zee.

**Gebergten (5):** Pyreneeën, Ardennen, Alpen, Kaukasus en Oeral.

De bergbolletjes staan precies halverwege de lengte van de oorspronkelijke getekende berglijnen. Die vereenvoudigde lijnen blijven als bron in `zeeen-en-gebergten.js` bewaard, maar worden niet op de kaart getekend. De kaart bevat geen plaatsnamen die het antwoord verklappen. Alle 12 onderdelen tellen mee voor de score; foute pogingen bepalen de eindfeedback. Opnieuw beginnen wist de score en husselt de antwoorden.

## 🇬🇧 English Words

Een woordjestoets Engels ↔ Nederlands (`engels.html`).

- **Modus:** Woorden, Zinnen (phrases), Voorzetsels van tijd of Alles door elkaar.
- **Richting:** Door elkaar (standaard), Engels → Nederlands of Nederlands → Engels.
- Bij **voorzetsels van tijd** zie je de hele zin en vertaal je alleen het gemarkeerde woord.
- Kleine spelfoutjes worden goed gerekend, met een tip voor de juiste spelling. Foute woorden komen later nog een keer terug.

## Lokaal starten

Start in deze map een eenvoudige webserver, bijvoorbeeld met `python -m http.server 8000`, en open `http://localhost:8000/`. De quiz heeft geen buildstap of kaart-API-sleutel nodig. Kaartgrenzen en quizlocaties staan lokaal in `basemap.js` en `geography.js`; alleen Leaflet wordt via een CDN geladen.

De land- en riviercontouren zijn afkomstig uit de [publiek-domeindata van Natural Earth](https://www.naturalearthdata.com/about/terms-of-use/) (110m-landen en 50m-rivieren).

## GitHub Pages

Publiceer de branch met deze bestanden via **Settings → Pages → Deploy from a branch → / (root)**.

## Vercel publiceren

Alle toetsen staan in één Vercel-project: https://harlekijn-groep7-toetsen.vercel.app, elk op hun eigen URL. De oorspronkelijke topotoets staat op `/`, Engels op `/engels.html` en de nieuwe variant op `/zeeen-en-gebergten.html`.

Met Node.js, npm en een ingelogde Vercel CLI:

```powershell
.\scripts\publish-vercel.ps1 -Scope <team-slug> -QuizPage zeeen-en-gebergten.html
```

Commit en push eerst de wijzigingen naar GitHub. Het script weigert een vuile werkboom en uploadt alleen publieke webbestanden; `.vercel/` met de lokale projectkoppeling, `.env*` en de gegenereerde map `public/` staan niet in Git. De verzamelstap `node scripts/build-static.cjs` kopieert uitsluitend webbestanden naar `public/`; er is geen frontendcompilatie of server nodig. `vercel.json` gebruikt dezelfde stap bij automatische deployments via de GitHub-koppeling. De repositoryskill [toets-publiceren](.github/skills/toets-publiceren/SKILL.md) beschrijft het volledige proces voor volgende toetsen.

Vercel hanteert [planlimieten](https://vercel.com/docs/limits): op 29 oktober 2026 maximaal 200 projecten op Hobby, onbeperkt projecten op Pro. Gebruik, dataverkeer en deployments hebben afzonderlijke limieten; meer projecten betekent niet onbeperkt gratis gebruik.
