---
name: toets-publiceren
description: Maak een nieuwe oefentoets of topotoets in deze repository, bewaar bestaande varianten, sla de wijzigingen op in GitHub en publiceer de toets op Vercel. Gebruik bij verzoeken om een toets te uploaden, live te zetten of te publiceren.
---

# Toets publiceren

## Nieuwe variant

1. Lees `README.md`, de nieuwste relevante toets en de bijbehorende gegevens. Controleer de huidige Git-status; behoud wijzigingen van de gebruiker.
2. Bewaar bestaande toetsen op hun eigen URL. Geef een variant een beschrijvende bestandsnaam in kebab-case. Hergebruik de laatste relevante toets als basis, inclusief kaart, feedback, score, opnieuw beginnen en mobiel ontwerp.
3. Controleer de gevraagde namen en geografische posities. Gebruik lokale, naamloze kaartgegevens voor topotoetsen, zodat kaartlabels het antwoord niet verraden. Wateren en gebergten worden als bolletjes weergegeven; bergbolletjes staan op het lengtemidden van de oorspronkelijke berglijnen, berekend met Leaflets `L.LineUtil.polylineCenter`. De lijnen zelf blijven verborgen. Gebruik de rubrieknaam "Wateren" en de ondertitel "Groep 7 van de Harlekijn". Laat de begintip weg, maar behoud feedback na antwoorden. Op desktop vult de kaart de ruimte naast een vaste antwoordkolom; op mobiel staat de kaart boven de antwoorden.
4. Link de variant vanuit `index.html` en documenteer onderwerp en URL in `README.md`. Houd toetsen statisch; voeg geen framework of buildstap toe zonder noodzaak.
5. Controleer iedere locatie, een fout antwoord, alle goede antwoorden, eindscherm, reset, toetsenbord en mobiele indeling. Controleer ook dat de vorige toetsen nog werken.

## GitHub en Vercel

1. Controleer GitHub-toegang met `gh auth status` en Vercel met `npx --yes vercel@65.1.0 whoami`.
2. Lees `npx --yes vercel@65.1.0 teams ls` en `npx --yes vercel@65.1.0 project ls`. Hergebruik het project `harlekijn-groep7-toetsen`; maak niet voor elke toets een nieuw project. Kies alleen een andere scope of projectnaam als de gebruiker dat vraagt. Vraag bij een onduidelijke accountkeuze om input.
3. Geef nooit tokens weer of sla ze op in Git. Bij ontbrekende toegang: laat de gebruiker zelf inloggen; claim geen geslaagde publicatie.
4. Commit uitsluitend de bedoelde bestanden op de huidige sessiebranch met de voorgeschreven co-auteur. Push de branch naar `origin`. Open alleen een pull request als de gebruiker daarom vraagt; force-push niet en verander de standaardbranch niet stilzwijgend.
5. Publiceer vanuit de repository met de gekozen team-slug en pagina:

   ```powershell
   .\scripts\publish-vercel.ps1 -Scope <team-slug> -QuizPage <bestandsnaam>.html
   ```

   Het script vereist een schone Git-status, koppelt het project en maakt een statische Vercel Build Output-deployment. `scripts/build-static.cjs` verzamelt uitsluitend publieke webbestanden uit de root en ondersteunde media uit `assets/`. Skills, documentatie, tests, scripts, credentials en Git-data worden niet gehost. Voeg nieuwe assettypen bewust aan de allowlist toe als een toets die nodig heeft. `vercel.json` gebruikt dezelfde verzamelstap voor automatische deployments via de Git-koppeling.
6. Wacht tot Vercel gereed is. Controleer de echte productie-alias uit de CLI-uitvoer, de nieuwe pagina en alle lokale afhankelijkheden zonder authenticatie. Controleer de quiz ook in de browser. Een beveiligde preview is niet hetzelfde als een publiek bereikbare toets. Verander toegangsinstellingen niet zonder toestemming.
7. Deel de exacte live-URL en een GitHub-link naar de opgeslagen branch of commit. Noem een blokkade expliciet als een van beide niet gelukt is.

## Limieten

Controleer bij vragen over kosten of capaciteit opnieuw het actieve plan en de officiële documentatie: https://vercel.com/docs/limits en https://vercel.com/docs/plans/hobby.

Op 29 oktober 2026 vermeldt Vercel: Hobby maximaal 200 projecten en 100 deployments per dag; Pro onbeperkt projecten en 6.000 deployments per dag. Voor Git-koppelingen geldt respectievelijk 25 en 150 projecten per repository. Onbeperkt projecten betekent niet onbeperkt gratis dataverkeer of onbeperkt gebruik. Verander of upgrade het abonnement niet automatisch.
