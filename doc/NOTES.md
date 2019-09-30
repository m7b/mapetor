https://www.freebasic.net/forum/viewtopic.php?t=22167

Icons von:
http://www.iconarchive.com/

curl von
https://bintray.com/vszakats/generic/curl/


Overpass API (Reutlingen)
http://www.overpass-api.de/api/xapi_meta?*[bbox=9.1305319296736478,48.306384885710379,9.4112410378702478,48.528035381824772]
http://www.overpass-api.de/api/xapi_meta?*[bbox=9.131,48.306,9.411,48.528]

hat noch nicht funktioniert
curl -o Rt.osm -g http://www.overpass-api.de/api/xapi_meta?*[bbox=9.131,48.306,9.411,48.528]

Overpass API (Bernburg)
http://www.overpass-api.de/api/xapi_meta?*[bbox=11.68,51.75,11.80,51.85]

Datei in batch speichern
https://stackoverflow.com/questions/19575665/store-a-file-inside-of-a-batch-file

@ECHO OFF
for /f "delims=" %%a in (bin.dat) do >>file2.tmp (echo(echo %%a^>^> exec.dat)


# Erstellen von Gebietskarten aus Daten von OpenStreetMap

Diese Skriptdateien dienen zum automatisch Herstellen von Gebietskarten.
Folgende Programme werden weiter benötigt:

 * Maperitive
    - Zum Beziehen der OSM-Daten als auch zur Kartenerstellung aus diesen Daten
	- http://www.http://maperitive.net/

 * ImageMagick
    - Für automatisierte, grafische Nachbearbeitung der Gebietskarte
	- http://www.imagemagick.org/

 * Inkscape
    - Um die Gebietsgrenzen und weitere Informationen (`xxx_borders.svg`)
      auf die Gebietskarte zu zeichnen.
	- https://inkscape.org/

Um die Batchdateien fehlerfrei ausfüren zu können, muss die Schriftart der
Konsole auf "Lucida Console" eingestellt werden. Erst dann können Texte mit
Unicode-Zeichen korrekt auf die Gebietskarte gezeichnet werden.

## Verzeichnisstruktur

    ROOT
    |   get_osm-data.bat > (1)
    |   make_001.bat     > (2)
    |   make_002.bat     > (3)
    |   readme.md        > (4)
    |   _env.bat         > (5)
    |   _process.bat     > (6)
    |
    +---borders
    |       001_borders.svg > (7)
    |       002_borders.svg > (8)
    |       xxx_templ.svg   > (9)
    |
    \---common
            a6Karte.mrules                    > (10)
            Compass-Arrow-300dpi-90degree.png > (11)
            Compass-Arrow-300dpi.png          > (12)

			
 1)  Lädt OSM-Daten vom Internet
 2)  Beispielscript für eine Gebietskarte
 3)  Beispielscript für eine weitere Gebietskarte
 4)  Dieses Dokument
 5)  Pfade zu den Tools, wird von Beispielscript aufgerufen
 6)  Prozessschritte, wird von Beispielscript aufgerufen
 7)  Grenzinformationen für Beispielgebietskarte
 8)  Grenzinformationen für weitere Beispielgebietskarte
 9)  leere Vorlage
10)  Definitionsdatei für Maperitive, wie die Karte aussehen soll. Hier
     können Schriftgrößen, Farben etc. angepasst werden
11)  Windrose mit Norden oben
12)  Windrose mit Norden links


## Beziehen der OSM Rohdaten für die Kartenerstellung

### OSM Bounds

- `MaxX: 9.4112410378702478` entspricht min Longitude
- `MaxY: 48.528035381824772` entspricht min Latitude
- `MinX: 9.1305319296736478` entspricht max Longitude
- `MinY: 48.306384885710379` entspricht max Latitude

### Maperitive-Befehl

    download-osm bounds=9.4112410378702478,48.528035381824772,9.1305319296736478,48.306384885710379 xapi-url="http://www.overpass-api.de/api/xapi_meta?*"
    save-source Rt5.osm


## Typische Vorgehnensweise

 1. OSM Bounds festlegen für das Holen der OSM Daten
    - Mittels Maperitive die Koordinaten ermitteln Map\Set Geometry Bounds
	- MaxX, MaxY, MinX, MinY in die Datei get_osm-data.bat eintragen.
 2. OSM-Daten downloaden
    - Ausführen der get_osm-data.bat