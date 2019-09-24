REM !!! IMPORTANT !!! IMPORTANT !!! IMPORTANT !!! IMPORTANT !!! IMPORTANT
REM Font for console has to be Lucida Console
chcp 65001

@ECHO OFF
CLS

:: ****************************************************************************
:: ****************************************************************************
:: ****************************************************************************

:: Karteneigenschaften
:: Folgende Daten erscheinen auf der Gebietskarte oben
SET Erzeugnisstand=%date:~0%
SET GebietNr=763
SET GebietBez=Bernloch

:: Folgende Daten erscheinen auf der Gebietskarte unten
SET BottomText=Bewahre diese Karte bitte in der Schutzhülle auf. Beschmutze, beschreibe und knicke sie nicht. Teile bitte dem Bruder, des sich um die Gebietsbearbeitung kümmert, jede Bearbeitung des Gebiets mit. (S-12-X)

:: Kartengröße und Orientierung. Zu entnehmen aus Maperitive.
SET Orientation=landscape
SET PaperHeight_mm=94
SET PaperWidth_mm=150

:: Daten für den Kartenausschnitt. Zu entnehmen aus Maperitive.
SET MapCenter=9.33934115984384,48.3558847770488
SET MapScale=8000

:: Auflösung des gerenderten Bildes
SET MapDpi=300

:: Schalter für Grid, OSM-Hinweis und Maßstab. Diese werden bei der
:: Kartenerstellung eingezeichnet oder nicht.
SET UseGrid=false
SET UseAttribution=false
SET UseScale=false

:: ****************************************************************************
:: ****************************************************************************
:: ****************************************************************************

::Pfad zu Programme
SET MAPC=C:\CPP\tools\Maperitive\Maperitive.Console.exe
SET MAPG=C:\CPP\tools\Maperitive\Maperitive.exe
SET IMCO=C:\CPP\tools\ImageMagick-7.0.7-22-portable-Q16-x86\convert.exe
SET IMID=C:\CPP\tools\ImageMagick-7.0.7-22-portable-Q16-x86\identify.exe
SET INKS=C:\Program Files\Inkscape\inkscape.exe

:: Pfad zu den OSM Rohdaten
SET OSM=raw_data.osm
SET OSM_GEOMETRY_BOUNDS=9.4112410378702478,48.528035381824772,9.1305319296736478,48.306384885710379

:: URL um die OSM-Rohdaten herunterzuladen
REM SET ServiceURL="http://www.overpass-api.de/api/interpreter?*"
SET ServiceURL="http://www.overpass-api.de/api"

:: ****************************************************************************
:: ****************************************************************************
:: ****************************************************************************

:: For internal use only
SET SELF=%~n0
SET SELFNAME=%~nx0
SET SELFPATHNAME=%~fnx0

SET STD_SVG_FILE=border.svg
SET STD_RULE_FILE=karte.mrules
SET STD_NORTH_FILE=Compass-Arrow-300dpi.png
SET STD_NORTH90_FILE=Compass-Arrow-300dpi-90degree.png

SET DEF_MAP=_def_.mscript

:: ****************************************************************************
:: ****************************************************************************
:: ****************************************************************************

REM Handle parameters
:Loop
REM Show help and exit
IF     [%1]==[-h]           GOTO HELP
IF     [%1]==[--help]       GOTO HELP
IF     [%1]==[-svge]        GOTO SVG_EXPORT
IF     [%1]==[-svgi]        GOTO SVG_IMPORT
IF     [%1]==[-maprulee]    GOTO MAPRULE_EXPORT
IF     [%1]==[-maprulei]    GOTO MAPRULE_IMPORT
IF     [%1]==[-northe]      GOTO NORTH_IMG_EXPORT
IF     [%1]==[-northi]      GOTO NORTH_IMG_IMPORT
IF     [%1]==[-north90e]    GOTO NORTH90_IMG_EXPORT
IF     [%1]==[-north90i]    GOTO NORTH90_IMG_IMPORT
IF NOT [%1]==[]             GOTO HELP
GOTO BUILD

:HELP
ECHO Create a territory card
ECHO:
ECHO Usage:
ECHO   %SELFNAME% ^<command^>
ECHO:
ECHO Available options:
ECHO   -h, --help                   Show this help message.
ECHO   -svge ^<svg-file^>             Export embeded svg-file.
ECHO   -svgi ^<svg-file^>             Embed new svg-file.
ECHO   -maprulee ^<maprule-file^>     Export embeded maprule-file.
ECHO   -maprulei ^<maprule-file^>     Embed new maprule-file.
ECHO   -northe ^<north-png-file^>     Export embeded north image (png-file).
ECHO   -northi ^<north-png-file^>     Embed new north image (png-file).
ECHO   -north90e ^<north90-png-file^> Export embeded north 90 image (png-file).
ECHO   -north90i ^<north90-png-file^> Embed new north 90 image (png-file).
ECHO:
ECHO:
ECHO Example usage:
ECHO   Embed the new svg-file with the name new_one.svg. A new batch-file will then
ECHO   be created with the actual time-stamp.
ECHO:
ECHO     %SELFNAME% -svgi new_one.svg
ECHO:
ECHO:
ECHO   Export embeded svg-file to exported.svg
ECHO:
ECHO     %SELFNAME% -svge exported.svg
GOTO EXIT


:SVG_EXPORT
ECHO -----BEGIN CERTIFICATE----->> svg_blob.txt
ECHO PD94bWwgdmVyc2lvbj0iMS4wIiBlbmNvZGluZz0iVVRGLTgiIHN0YW5kYWxvbmU9>> svg_blob.txt
ECHO Im5vIj8+CjwhLS0gQ3JlYXRlZCB3aXRoIElua3NjYXBlIChodHRwOi8vd3d3Lmlu>> svg_blob.txt
ECHO a3NjYXBlLm9yZy8pIC0tPgoKPHN2ZwogICB4bWxuczpkYz0iaHR0cDovL3B1cmwu>> svg_blob.txt
ECHO b3JnL2RjL2VsZW1lbnRzLzEuMS8iCiAgIHhtbG5zOmNjPSJodHRwOi8vY3JlYXRp>> svg_blob.txt
ECHO dmVjb21tb25zLm9yZy9ucyMiCiAgIHhtbG5zOnJkZj0iaHR0cDovL3d3dy53My5v>> svg_blob.txt
ECHO cmcvMTk5OS8wMi8yMi1yZGYtc3ludGF4LW5zIyIKICAgeG1sbnM6c3ZnPSJodHRw>> svg_blob.txt
ECHO Oi8vd3d3LnczLm9yZy8yMDAwL3N2ZyIKICAgeG1sbnM9Imh0dHA6Ly93d3cudzMu>> svg_blob.txt
ECHO b3JnLzIwMDAvc3ZnIgogICB4bWxuczpzb2RpcG9kaT0iaHR0cDovL3NvZGlwb2Rp>> svg_blob.txt
ECHO LnNvdXJjZWZvcmdlLm5ldC9EVEQvc29kaXBvZGktMC5kdGQiCiAgIHhtbG5zOmlu>> svg_blob.txt
ECHO a3NjYXBlPSJodHRwOi8vd3d3Lmlua3NjYXBlLm9yZy9uYW1lc3BhY2VzL2lua3Nj>> svg_blob.txt
ECHO YXBlIgogICB3aWR0aD0iMjEwbW0iCiAgIGhlaWdodD0iMjk3bW0iCiAgIHZpZXdC>> svg_blob.txt
ECHO b3g9IjAgMCAyMTAgMjk3IgogICB2ZXJzaW9uPSIxLjEiCiAgIGlkPSJzdmc4Igog>> svg_blob.txt
ECHO ICBpbmtzY2FwZTp2ZXJzaW9uPSIwLjkyLjIgKDVjM2U4MGQsIDIwMTctMDgtMDYp>> svg_blob.txt
ECHO IgogICBzb2RpcG9kaTpkb2NuYW1lPSJuZXdfaW5rc2NhcGVfMC45Mi4yX2ZpbGUu>> svg_blob.txt
ECHO c3ZnIj4KICA8ZGVmcwogICAgIGlkPSJkZWZzMiIgLz4KICA8c29kaXBvZGk6bmFt>> svg_blob.txt
ECHO ZWR2aWV3CiAgICAgaWQ9ImJhc2UiCiAgICAgcGFnZWNvbG9yPSIjZmZmZmZmIgog>> svg_blob.txt
ECHO ICAgIGJvcmRlcmNvbG9yPSIjNjY2NjY2IgogICAgIGJvcmRlcm9wYWNpdHk9IjEu>> svg_blob.txt
ECHO MCIKICAgICBpbmtzY2FwZTpwYWdlb3BhY2l0eT0iMC4wIgogICAgIGlua3NjYXBl>> svg_blob.txt
ECHO OnBhZ2VzaGFkb3c9IjIiCiAgICAgaW5rc2NhcGU6em9vbT0iMC4zNSIKICAgICBp>> svg_blob.txt
ECHO bmtzY2FwZTpjeD0iLTEyMi44NTcxNCIKICAgICBpbmtzY2FwZTpjeT0iNTYwIgog>> svg_blob.txt
ECHO ICAgIGlua3NjYXBlOmRvY3VtZW50LXVuaXRzPSJtbSIKICAgICBpbmtzY2FwZTpj>> svg_blob.txt
ECHO dXJyZW50LWxheWVyPSJsYXllcjIiCiAgICAgc2hvd2dyaWQ9ImZhbHNlIgogICAg>> svg_blob.txt
ECHO IGlua3NjYXBlOndpbmRvdy13aWR0aD0iODAwIgogICAgIGlua3NjYXBlOndpbmRv>> svg_blob.txt
ECHO dy1oZWlnaHQ9IjYwMCIKICAgICBpbmtzY2FwZTp3aW5kb3cteD0iLTgiCiAgICAg>> svg_blob.txt
ECHO aW5rc2NhcGU6d2luZG93LXk9Ii04IgogICAgIGlua3NjYXBlOndpbmRvdy1tYXhp>> svg_blob.txt
ECHO bWl6ZWQ9IjEiIC8+CiAgPG1ldGFkYXRhCiAgICAgaWQ9Im1ldGFkYXRhNSI+CiAg>> svg_blob.txt
ECHO ICA8cmRmOlJERj4KICAgICAgPGNjOldvcmsKICAgICAgICAgcmRmOmFib3V0PSIi>> svg_blob.txt
ECHO PgogICAgICAgIDxkYzpmb3JtYXQ+aW1hZ2Uvc3ZnK3htbDwvZGM6Zm9ybWF0Pgog>> svg_blob.txt
ECHO ICAgICAgIDxkYzp0eXBlCiAgICAgICAgICAgcmRmOnJlc291cmNlPSJodHRwOi8v>> svg_blob.txt
ECHO cHVybC5vcmcvZGMvZGNtaXR5cGUvU3RpbGxJbWFnZSIgLz4KICAgICAgICA8ZGM6>> svg_blob.txt
ECHO dGl0bGU+PC9kYzp0aXRsZT4KICAgICAgPC9jYzpXb3JrPgogICAgPC9yZGY6UkRG>> svg_blob.txt
ECHO PgogIDwvbWV0YWRhdGE+CiAgPGcKICAgICBpbmtzY2FwZTpsYWJlbD0iTWFwIgog>> svg_blob.txt
ECHO ICAgIGlua3NjYXBlOmdyb3VwbW9kZT0ibGF5ZXIiCiAgICAgaWQ9ImxheWVyMSIg>> svg_blob.txt
ECHO Lz4KICA8ZwogICAgIGlua3NjYXBlOmxhYmVsPSJCb3JkZXJzIgogICAgIGlua3Nj>> svg_blob.txt
ECHO YXBlOmdyb3VwbW9kZT0ibGF5ZXIiCiAgICAgaWQ9ImxheWVyMiIgLz4KICA8Zwog>> svg_blob.txt
ECHO ICAgIGlua3NjYXBlOmxhYmVsPSJJbmZvIgogICAgIGlua3NjYXBlOmdyb3VwbW9k>> svg_blob.txt
ECHO ZT0ibGF5ZXIiCiAgICAgaWQ9ImxheWVyMyIgLz4KPC9zdmc+Cg==>> svg_blob.txt
ECHO -----END CERTIFICATE----->> svg_blob.txt
SET SVG_OUTPUT=%2
IF [%2]==[] SET SVG_OUTPUT=%STD_SVG_FILE%
certutil -decode svg_blob.txt %SVG_OUTPUT% >nul
DEL svg_blob.txt
ECHO SVG-File exported to %SVG_OUTPUT%.
IF DEFINED BUILDING GOTO BUILD_STEP_1
GOTO DONE


:SVG_IMPORT
IF NOT EXIST %2 GOTO SVG_IMPORT_ERROR
SET SVG_INPUT=%2

REM Kopiere BATCH-Datei ohne enkodiertes svg_blob
SET EXCLUDE_STR="svg_blob.txt"
TYPE %SELFNAME% | findstr /v /c:">> %EXCLUDE_STR%" > %SELFNAME%.cpy

REM Erstelle blob aus svg -> tmp2.bin
certutil -encode -f %SVG_INPUT% tmp.bin
FOR /f "delims=" %%a in (tmp.bin) do >> tmp2.bin (ECHO(ECHO %%a^>^> %EXCLUDE_STR:"=%)
DEL tmp.bin

REM Füge blob (tmp2.bin) an entsprechender Stelle in kopiertes Batch ein
REM https://stackoverflow.com/questions/155932/how-do-you-loop-through-each-line-in-a-text-file-using-a-windows-batch-file
SET NEWFILE=%SELF%_%DATE:~6,6%%DATE:~3,2%%DATE:~0,2%_%time:~0,2%-%time:~3,2%-%time:~6,2%.bat
SETLOCAL DisableDelayedExpansion
FOR /F "usebackq delims=" %%a in (`"findstr /n ^^ %SELFNAME%.cpy"`) do (
    SET "var=%%a"
	SETLOCAL EnableDelayedExpansion
	SET "var=!var:*:=!"
	ECHO(!var!>> %NEWFILE%
	IF "!var!" == ":SVG_EXPORT" (
        TYPE tmp2.bin >> %NEWFILE%
	)
	ENDLOCAL
)
DEL %SELFNAME%.cpy
DEL tmp2.bin
GOTO DONE


:SVG_IMPORT_ERROR
ECHO File does not exist: %2
GOTO DONE

:: ****************************************************************************
:: ****************************************************************************
:: ****************************************************************************

:MAPRULE_EXPORT
ECHO -----BEGIN CERTIFICATE----->> maprule_blob.txt
ECHO Ly8gRGVmYXVsdCByZW5kZXJpbmcgcnVsZXMgZm9yIE1hcGVyaXRpdmUgcmVzZW1i>> maprule_blob.txt
ECHO bGluZyB0aGF0IG9mIE9TTSBNYXBuaWsNCi8vIGh0dHA6Ly9tYXBlcml0aXZlLm5l>> maprule_blob.txt
ECHO dA0KDQovLyBDcmVhdGVkIGJ5IElnb3IgQnJlamMNCi8vIFJlbGVhc2VkIHVuZGVy>> maprule_blob.txt
ECHO IHRoZSBDcmVhdGl2ZSBDb21tb25zIEF0dHJpYnV0aW9uLVNoYXJlQWxpa2UgMy4w>> maprule_blob.txt
ECHO IExpY2Vuc2UgKGh0dHA6Ly9jcmVhdGl2ZWNvbW1vbnMub3JnL2xpY2Vuc2VzL2J5>> maprule_blob.txt
ECHO LXNhLzMuMC8pDQovLyBVcGRhdGVzIGJ5IE1pY2hhZWwgPHF1ZWxic19hdF9nbWFp>> maprule_blob.txt
ECHO bC5jb20+DQovLyBJY29ucyB1c2VkOiBNYXAgaWNvbnMgQ0MtMCBmcm9tIFNKSkIg>> maprule_blob.txt
ECHO TWFuYWdlbWVudCAoaHR0cDovL3d3dy5zampiLmNvLnVrL21hcGljb25zKQ0KDQpm>> maprule_blob.txt
ECHO ZWF0dXJlcw0KCXBvaW50cywgYXJlYXMNCgkJcGFya2luZyA6IGFtZW5pdHk9cGFy>> maprule_blob.txt
ECHO a2luZw0KCQlwb3N0Ym94IDogYW1lbml0eT1wb3N0X2JveA0KCQlwb3N0b2ZmaWNl>> maprule_blob.txt
ECHO IDogYW1lbml0eT1wb3N0X29mZmljZQ0KCQl0ZWxlcGhvbmUgOiBhbWVuaXR5PXRl>> maprule_blob.txt
ECHO bGVwaG9uZQ0KCQlmaXJlIHN0YXRpb24gOiBhbWVuaXR5PWZpcmVfc3RhdGlvbg0K>> maprule_blob.txt
ECHO CQlwb2xpY2Ugc3RhdGlvbiA6IGFtZW5pdHk9cG9saWNlDQoJCWhvc3BpdGFsIDog>> maprule_blob.txt
ECHO YW1lbml0eT1ob3NwaXRhbA0KCQlyZWN5Y2xpbmcgOiBhbWVuaXR5PXJlY3ljbGlu>> maprule_blob.txt
ECHO Zw0KCQljaHVyY2ggOiBhbWVuaXR5PXBsYWNlX29mX3dvcnNoaXAgQU5EIHJlbGln>> maprule_blob.txt
ECHO aW9uPWNocmlzdGlhbg0KCQlkcmlua2luZyB3YXRlciA6IGFtZW5pdHk9ZHJpbmtp>> maprule_blob.txt
ECHO bmdfd2F0ZXINCgkJYmFuayA6IGFtZW5pdHk9YmFuaw0KCQlhdG0gOiBhbWVuaXR5>> maprule_blob.txt
ECHO PWF0bQ0KCQl0b2lsZXRzIDogYW1lbml0eT10b2lsZXRzDQoJCWxpYnJhcnkgOiBh>> maprule_blob.txt
ECHO bWVuaXR5PWxpYnJhcnkNCgkJdHJlZSA6IG5hdHVyYWw9dHJlZQ0KCS8vCXNjaG9v>> maprule_blob.txt
ECHO bCA6IGFtZW5pdHk9c2Nob29sDQoJCWJ1cyBzdG9wIDogaGlnaHdheT1idXNfc3Rv>> maprule_blob.txt
ECHO cA0KCQlyYWlsd2F5IHN0YXRpb24gOiByYWlsd2F5PXN0YXRpb24NCgkJbWluaSBy>> maprule_blob.txt
ECHO b3VuZGFib3V0IDogaGlnaHdheT1taW5pX3JvdW5kYWJvdXQNCgkJZ2F0ZSA6IGJh>> maprule_blob.txt
ECHO cnJpZXI9Z2F0ZQ0KCQl0b3VyaXNtIHZpZXdwb2ludCA6IHRvdXJpc209dmlld3Bv>> maprule_blob.txt
ECHO aW50DQoJCXRvdXJpc20gaG90ZWwgOiB0b3VyaXNtPWhvdGVsDQoJCXRvdXJpc20g>> maprule_blob.txt
ECHO bXVzZXVtIDogdG91cmlzbT1tdXNldW0NCgkJYW1lbml0eSBwdWIgOiBhbWVuaXR5>> maprule_blob.txt
ECHO PXB1Yg0KCQlhbWVuaXR5IGZhc3RfZm9vZCA6IGFtZW5pdHk9ZmFzdF9mb29kDQoJ>> maprule_blob.txt
ECHO CWFlcm9kcm9tZSA6IGFlcm93YXk9YWVyb2Ryb21lDQoJCWhvdXNlbnVtYmVyIDog>> maprule_blob.txt
ECHO W2FkZHI6aG91c2VudW1iZXJdDQoJLy8gVGhlc2UgYXJlIG5vdCBzaG93biBvbiBN>> maprule_blob.txt
ECHO YXBuaWsNCgkJcHVmZmluIDogY3Jvc3NpbmdfcmVmPXB1ZmZpbg0KCQltZW1vcmlh>> maprule_blob.txt
ECHO bCA6IGhpc3RvcmljPW1lbW9yaWFsDQoNCg0KCWFyZWFzDQoJCWJlYWNoIDogbmF0>> maprule_blob.txt
ECHO dXJhbD1iZWFjaA0KCS8vCWJ1aWxkaW5nIDogYnVpbGRpbmc9eWVzIE9SIGJ1aWxk>> maprule_blob.txt
ECHO aW5nPWRldGFjaGVkIE9SIGJ1aWxkaW5nPWhvdXNlIE9SIGJ1aWxkaW5nPWNvbnN0>> maprule_blob.txt
ECHO cnVjdGlvbiBPUiBidWlsZGluZz1jb21tZXJjaWFsIE9SIGJ1aWxkaW5nPXN1cGVy>> maprule_blob.txt
ECHO bWFya2V0IE9SIGJ1aWxkaW5nPW9mZmljZSBPUiBidWlsZGluZz13YXJlaG91c2Ug>> maprule_blob.txt
ECHO T1IgYnVpbGRpbmc9c3RhYmxlDQoJCWJ1aWxkaW5nIDogYnVpbGRpbmcNCgkJd2F0>> maprule_blob.txt
ECHO ZXIgOiBuYXR1cmFsPXdhdGVyIE9SIHdhdGVyd2F5PXJpdmVyYmFuayBPUiBsYW5k>> maprule_blob.txt
ECHO dXNlPXJlc2Vydm9pciBPUiBsYW5kdXNlPWJhc2luIE9SIHdhdGVyd2F5PWRvY2sg>> maprule_blob.txt
ECHO T1IgbGVpc3VyZT1zd2ltbWluZ19wb29sDQoJCXZpbGxhZ2UgZ3JlZW4gOiBsYW5k>> maprule_blob.txt
ECHO dXNlPXZpbGxhZ2VfZ3JlZW4NCgkJZm9yZXN0IDogbGFuZHVzZT1mb3Jlc3QgT1Ig>> maprule_blob.txt
ECHO bmF0dXJhbD13b29kDQoJCWZhcm0gOiBsYW5kdXNlPWZhcm0NCgkJZmFybXlhcmQ6>> maprule_blob.txt
ECHO bGFuZHVzZT1mYXJteWFyZA0KCQlncmFzcyA6IGxhbmR1c2U9Z3Jhc3MNCgkJZmVs>> maprule_blob.txt
ECHO bCA6IG5hdHVyYWw9ZmVsbA0KCQlnbGFjaWVyIDogbmF0dXJhbD1nbGFjaWVyDQoJ>> maprule_blob.txt
ECHO CW5hdGlvbmFsIHBhcmsgOiBib3VuZGFyeT1uYXRpb25hbF9wYXJrDQoJCWFsbG90>> maprule_blob.txt
ECHO bWVudHMgOiBsYW5kdXNlPWFsbG90bWVudHMNCgkJYWNhZGVtaWMgOiBub2RlW0Bp>> maprule_blob.txt
ECHO c09uZU9mKGFtZW5pdHksIHVuaXZlcnNpdHksIGNvbGxlZ2UsIHNjaG9vbCldIGFy>> maprule_blob.txt
ECHO ZWFbQGlzT25lT2YoYW1lbml0eSwgdW5pdmVyc2l0eSwgY29sbGVnZSwgc2Nob29s>> maprule_blob.txt
ECHO KV0NCgkJbWVhZG93IDogbmF0dXJhbD1tZWFkb3cgT1IgbGFuZHVzZT1tZWFkb3cN>> maprule_blob.txt
ECHO CgkJbmF0dXJlIHJlc2VydmUgOiBsZWlzdXJlPW5hdHVyZV9yZXNlcnZlDQoJCXBs>> maprule_blob.txt
ECHO YXlncm91bmQgOiBsZWlzdXJlPXBsYXlncm91bmQNCgkJY2FyIHBhcms6IGFtZW5p>> maprule_blob.txt
ECHO dHk9cGFya2luZw0KCQl0cmFjayA6IGxlaXN1cmU9dHJhY2sNCgkJZ3JhdmV5YXJk>> maprule_blob.txt
ECHO IDogYW1lbml0eT1ncmF2ZV95YXJkIE9SIGxhbmR1c2U9Y2VtZXRlcnkNCgkJbWls>> maprule_blob.txt
ECHO aXRhcnkgOiBsYW5kdXNlPW1pbGl0YXJ5IE9SIG1pbGl0YXJ5PWJhcnJhY2tzDQoJ>> maprule_blob.txt
ECHO CXBhcmsgOiBsZWlzdXJlPXBhcmsNCgkJbGVpc3VyZSBnYXJkZW4gOiBsZWlzdXJl>> maprule_blob.txt
ECHO PWdhcmRlbg0KCQlsZWlzdXJlIHBpdGNoIDogbGVpc3VyZT1waXRjaA0KCQlsZWlz>> maprule_blob.txt
ECHO dXJlIHN0YWRpdW0gOiBsZWlzdXJlPXN0YWRpdW0NCgkJbGFuZHVzZSByZXRhaWwg>> maprule_blob.txt
ECHO OiBsYW5kdXNlPXJldGFpbA0KCQlsYW5kdXNlIGluZHVzdHJpYWwgOiBsYW5kdXNl>> maprule_blob.txt
ECHO PWluZHVzdHJpYWwNCgkJY29tbWVyY2lhbCBhcmVhIDogbGFuZHVzZT1jb21tZXJj>> maprule_blob.txt
ECHO aWFsDQoJCXJlc2lkZW50aWFsIGFyZWEgOiBsYW5kdXNlPXJlc2lkZW50aWFsDQoJ>> maprule_blob.txt
ECHO CWFlcm93YXkgYXByb24gOiBhZXJvd2F5PWFwcm9uDQoJCWFlcm93YXkgdGVybWlu>> maprule_blob.txt
ECHO YWwgOiBhZXJvd2F5PXRlcm1pbmFsDQoJCWhpZ2h3YXkgcGVkZXN0cmlhbiA6IGhp>> maprule_blob.txt
ECHO Z2h3YXk9cGVkZXN0cmlhbg0KCQlvcmNoYXJkIDogbGFuZHVzZT1vcmNoYXJkDQoJ>> maprule_blob.txt
ECHO CWZhcm1sYW5kIDogbGFuZHVzZT1mYXJtbGFuZA0KCQlxdWFycnkgOiBsYW5kdXNl>> maprule_blob.txt
ECHO PXF1YXJyeQ0KDQoJbGluZXMNCgkJb25ld2F5IDogb25ld2F5PXllcyBPUiBvbmV3>> maprule_blob.txt
ECHO YXk9dHJ1ZSBPUiBvbmV3YXk9LTENCgkJY29hc3RsaW5lIDogbmF0dXJhbD1jb2Fz>> maprule_blob.txt
ECHO dGxpbmUNCgkJcml2ZXIgOiB3YXRlcndheT1yaXZlcg0KCQlzdHJlYW0gOiB3YXRl>> maprule_blob.txt
ECHO cndheT1zdHJlYW0NCgkJY2FuYWwgOiB3YXRlcndheT1jYW5hbA0KCQlkcmFpbiA6>> maprule_blob.txt
ECHO IHdhdGVyd2F5PWRyYWluDQoJCWRvY2sgOiB3YXRlcndheT1kb2NrDQoJCXJhaWx3>> maprule_blob.txt
ECHO YXkgcmFpbCA6IHJhaWx3YXk9cmFpbA0KCQlyYWlsd2F5IGxpZ2h0cmFpbCA6IHJh>> maprule_blob.txt
ECHO aWx3YXk9bGlnaHRfcmFpbA0KCQlwbGF0Zm9ybSA6IHJhaWx3YXk9cGxhdGZvcm0g>> maprule_blob.txt
ECHO T1IgcHVibGljX3RyYW5zcG9ydD1wbGF0Zm9ybQ0KCQlsaW5lIGJhcnJpZXIgOiBi>> maprule_blob.txt
ECHO YXJyaWVyPXdhbGwgT1IgYmFycmllcj1mZW5jZQ0KCQloaWdod2F5IG1vdG9yd2F5>> maprule_blob.txt
ECHO IDogaGlnaHdheT1tb3RvcndheSBPUiAoaGlnaHdheT1jb25zdHJ1Y3Rpb24gQU5E>> maprule_blob.txt
ECHO IGNvbnN0cnVjdGlvbj1tb3RvcndheSkNCgkJaGlnaHdheSBtb3RvcndheSBsaW5r>> maprule_blob.txt
ECHO IDogaGlnaHdheT1tb3RvcndheV9saW5rIE9SIChoaWdod2F5PWNvbnN0cnVjdGlv>> maprule_blob.txt
ECHO biBBTkQgY29uc3RydWN0aW9uPW1vdG9yd2F5X2xpbmspDQoJCWhpZ2h3YXkgdHJ1>> maprule_blob.txt
ECHO bmsgOiBoaWdod2F5PXRydW5rIE9SIChoaWdod2F5PWNvbnN0cnVjdGlvbiBBTkQg>> maprule_blob.txt
ECHO Y29uc3RydWN0aW9uPXRydW5rKQ0KCQloaWdod2F5IHRydW5rIGxpbms6IGhpZ2h3>> maprule_blob.txt
ECHO YXk9dHJ1bmtfbGluayBPUiAoaGlnaHdheT1jb25zdHJ1Y3Rpb24gQU5EIGNvbnN0>> maprule_blob.txt
ECHO cnVjdGlvbj10cnVua19saW5rKQ0KCQloaWdod2F5IHByaW1hcnkgbGluayA6IGhp>> maprule_blob.txt
ECHO Z2h3YXk9cHJpbWFyeV9saW5rIE9SIChoaWdod2F5PWNvbnN0cnVjdGlvbiBBTkQg>> maprule_blob.txt
ECHO Y29uc3RydWN0aW9uPXByaW1hcnlfbGluaykNCgkJaGlnaHdheSBwcmltYXJ5IDog>> maprule_blob.txt
ECHO aGlnaHdheT1wcmltYXJ5IE9SIChoaWdod2F5PWNvbnN0cnVjdGlvbiBBTkQgY29u>> maprule_blob.txt
ECHO c3RydWN0aW9uPXByaW1hcnkpDQoJCWhpZ2h3YXkgc2Vjb25kYXJ5IDogaGlnaHdh>> maprule_blob.txt
ECHO eT1zZWNvbmRhcnkgT1IgKGhpZ2h3YXk9Y29uc3RydWN0aW9uIEFORCBjb25zdHJ1>> maprule_blob.txt
ECHO Y3Rpb249c2Vjb25kYXJ5KQ0KCQloaWdod2F5IHRlcnRpYXJ5IDogaGlnaHdheT10>> maprule_blob.txt
ECHO ZXJ0aWFyeSBPUiBoaWdod2F5PXRlcnRpYXJ5X2xpbmsgT1IgKGhpZ2h3YXk9Y29u>> maprule_blob.txt
ECHO c3RydWN0aW9uIEFORCBjb25zdHJ1Y3Rpb249dGVydGlhcnkpDQoJCWhpZ2h3YXkg>> maprule_blob.txt
ECHO dW5jbGFzc2lmaWVkIDogaGlnaHdheT11bmNsYXNzaWZpZWQgT1IgKGhpZ2h3YXk9>> maprule_blob.txt
ECHO Y29uc3RydWN0aW9uIEFORCBjb25zdHJ1Y3Rpb249dW5jbGFzc2lmaWVkKQ0KCQlo>> maprule_blob.txt
ECHO aWdod2F5IHJlc2lkZW50aWFsIDogaGlnaHdheT1yZXNpZGVudGlhbCBPUiAoaGln>> maprule_blob.txt
ECHO aHdheT1jb25zdHJ1Y3Rpb24gQU5EIGNvbnN0cnVjdGlvbj1yZXNpZGVudGlhbCkN>> maprule_blob.txt
ECHO CgkJaGlnaHdheSBsaXZpbmdfc3RyZWV0IDogaGlnaHdheT1saXZpbmdfc3RyZWV0>> maprule_blob.txt
ECHO IE9SIChoaWdod2F5PWNvbnN0cnVjdGlvbiBBTkQgY29uc3RydWN0aW9uPWxpdmlu>> maprule_blob.txt
ECHO Z19zdHJlZXQpDQoJCWhpZ2h3YXkgY29uc3RydWN0aW9uIDogaGlnaHdheT1jb25z>> maprule_blob.txt
ECHO dHJ1Y3Rpb24NCgkJaGlnaHdheSBzZXJ2aWNlIDogaGlnaHdheT1zZXJ2aWNlDQoJ>> maprule_blob.txt
ECHO CWhpZ2h3YXkgcGVkZXN0cmlhbiA6IGhpZ2h3YXk9cGVkZXN0cmlhbg0KCQloaWdo>> maprule_blob.txt
ECHO d2F5IHRyYWNrIDogaGlnaHdheT10cmFjaw0KCQloaWdod2F5IGZvb3R3YXkgOiBo>> maprule_blob.txt
ECHO aWdod2F5PWZvb3R3YXkNCgkJaGlnaHdheSBjeWNsZXdheSA6IGhpZ2h3YXk9Y3lj>> maprule_blob.txt
ECHO bGV3YXkNCgkJaGlnaHdheSBwYXRoIDogaGlnaHdheT1wYXRoDQoJCWhpZ2h3YXkg>> maprule_blob.txt
ECHO YWNjZXNzIHByaXZhdGUgOiBhY2Nlc3M9cHJpdmF0ZSBBTkQgaGlnaHdheQ0KCQlo>> maprule_blob.txt
ECHO aWdod2F5IGFjY2VzcyBkZXN0aW5hdGlvbiA6IGFjY2Vzcz1kZXN0aW5hdGlvbiBB>> maprule_blob.txt
ECHO TkQgaGlnaHdheQ0KCQloaWdod2F5IHN0ZXBzIDogaGlnaHdheT1zdGVwcw0KCQlw>> maprule_blob.txt
ECHO aWVyIDogbWFuX21hZGU9cGllcg0KCQlicmlkZ2UgZm9vdCA6IGJyaWRnZT15ZXMg>> maprule_blob.txt
ECHO QU5EIChmb290PXllcyBPUiBoaWdod2F5PWZvb3R3YXkpDQoJCWhpc3RvcmljIGNp>> maprule_blob.txt
ECHO dHl3YWxscyA6IGhpc3RvcmljPWNpdHl3YWxscyBPUiBoaXN0b3JpYz1jaXR5X3dh>> maprule_blob.txt
ECHO bGwNCgkJLy9wb3dlcl9saW5lIDogcG93ZXI9bGluZSBPUiBwb3dlcj1taW5vcl9s>> maprule_blob.txt
ECHO aW5lDQoJCWFlcmlhbHdheSBjbG9zZWQ6IEBpc09uZU9mKGFlcmlhbHdheSxjYWJs>> maprule_blob.txt
ECHO ZV9jYXIsZ29uZG9sYSxtaXhlZF9saWZ0KQ0KCQlhZXJpYWx3YXkgb3BlbjogQGlz>> maprule_blob.txt
ECHO T25lT2YoYWVyaWFsd2F5LGNoYWlyX2xpZnQsZHJhZ19saWZ0KQ0KDQoJCWFlcm93>> maprule_blob.txt
ECHO YXkgcnVud2F5IDogYWVyb3dheT1ydW53YXkNCgkJYWVyb3dheSB0YXhpd2F5IDog>> maprule_blob.txt
ECHO YWVyb3dheT10YXhpd2F5DQoNCgkJYm91bmRhcnkgY291bnRyeSA6IGJvdW5kYXJ5>> maprule_blob.txt
ECHO PWFkbWluaXN0cmF0aXZlIEFORCAoYWRtaW5fbGV2ZWw9MiBPUiBhZG1pbl9sZXZl>> maprule_blob.txt
ECHO bD00KSBBTkQgTk9UIG5hdHVyYWw9Y29hc3RsaW5lDQoJCWJvdW5kYXJ5IHByb3Zp>> maprule_blob.txt
ECHO bmNlIDogYm91bmRhcnk9YWRtaW5pc3RyYXRpdmUgQU5EIGFkbWluX2xldmVsPTYN>> maprule_blob.txt
ECHO CgkJYm91bmRhcnkgbXVuaWNpcGFsIDogYm91bmRhcnk9YWRtaW5pc3RyYXRpdmUg>> maprule_blob.txt
ECHO QU5EIGFkbWluX2xldmVsPTgNCg0KCQljb250b3VyIG1ham9yIDogY29udG91cltA>> maprule_blob.txt
ECHO aXNNdWx0aShlbGV2YXRpb24sIDEwMCldDQoJCWNvbnRvdXIgbWlub3IgOiBjb250>> maprule_blob.txt
ECHO b3VyW0Bpc011bHRpKGVsZXZhdGlvbiwgMjApIGFuZCBub3QgQGlzTXVsdGkoZWxl>> maprule_blob.txt
ECHO dmF0aW9uLCAxMDApXQ0KDQoJCWdwcyB0cmFja3MgOiBncHN0cmFja1tdDQoJCWdw>> maprule_blob.txt
ECHO cyByb3V0ZXMgOiBncHNyb3V0ZVtdDQoNCi8vIFJvdXRlcw0KLy8JCXJvdXRlIG5j>> maprule_blob.txt
ECHO biA6IHJlbGF0aW9uW3R5cGU9cm91dGUgQU5EIHJvdXRlPWJpY3ljbGUgQU5EIG5l>> maprule_blob.txt
ECHO dHdvcms9bmNuXQ0KCQlyb3V0ZSBieXdheSA6IHJlbGF0aW9uW3R5cGU9cm91dGUg>> maprule_blob.txt
ECHO QU5EIHJvdXRlPWJpY3ljbGUgQU5EIG5ldHdvcms9Ik5hdGlvbmFsIEJ5d2F5Il0N>> maprule_blob.txt
ECHO CgkJcm91dGUgZm9vdCA6IHJlbGF0aW9uW3R5cGU9cm91dGUgQU5EIHJvdXRlPWZv>> maprule_blob.txt
ECHO b3RdDQoNCglwb2ludHMNCgkJcGxhY2UgY2l0eSA6IHBsYWNlPWNpdHkNCgkJcGxh>> maprule_blob.txt
ECHO Y2UgdG93biA6IHBsYWNlPXRvd24NCgkJcGxhY2UgdmlsbGFnZSA6IHBsYWNlPXZp>> maprule_blob.txt
ECHO bGxhZ2UNCgkJcGxhY2UgaGFtbGV0IDogcGxhY2U9aGFtbGV0DQoJCXBsYWNlIGxv>> maprule_blob.txt
ECHO Y2FsaXR5OiBwbGFjZT1sb2NhbGl0eQ0KCQlwbGFjZSBpc29sYXRlZF9kd2VsbGlu>> maprule_blob.txt
ECHO ZyA6IHBsYWNlPWlzb2xhdGVkX2R3ZWxsaW5nDQoJCXBsYWNlIHN1YnVyYiA6IHBs>> maprule_blob.txt
ECHO YWNlPXN1YnVyYg0KCQlkaXkgOiBzaG9wPWRvaXR5b3Vyc2VsZg0KCQloYWlyIGRy>> maprule_blob.txt
ECHO ZXNzZXIgOiBzaG9wPWhhaXJkcmVzc2VyDQoJCXN1cGVybWFya2V0IDogc2hvcD1z>> maprule_blob.txt
ECHO dXBlcm1hcmtldA0KCQljb252ZW5pZW5jZSA6IHNob3A9Y29udmVuaWVuY2UNCgkJ>> maprule_blob.txt
ECHO YmFrZXJ5IDogc2hvcD1iYWtlcnkNCgkJcmVzdGF1cmFudCA6IGFtZW5pdHk9cmVz>> maprule_blob.txt
ECHO dGF1cmFudA0KCQljYWZlIDogYW1lbml0eT1jYWZlDQoJCXBoYXJtYWN5IDogYW1l>> maprule_blob.txt
ECHO bml0eT1waGFybWFjeQ0KCQlwZWFrIDogbmF0dXJhbD1wZWFrDQoJCS8vcG93ZXJ0>> maprule_blob.txt
ECHO b3dlciA6IHBvd2VyPXRvd2VyIE9SIHBvd2VyPXBvbGUNCgkJaW5mbyA6IGluZm9y>> maprule_blob.txt
ECHO bWF0aW9uPWd1aWRlcG9zdA0KCQlib2xsYXJkIDogYmFycmllcj1ib2xsYXJkDQoJ>> maprule_blob.txt
ECHO CWxpZnRfZ2F0ZSA6IGJhcnJpZXI9bGlmdF9nYXRlDQoJCWFlcmlhbHdheSBzdGF0>> maprule_blob.txt
ECHO aW9uIDogYWVyaWFsd2F5PXN0YXRpb24NCgkJbW90b3J3YXlfanVuY3Rpb24gOiBo>> maprule_blob.txt
ECHO aWdod2F5PW1vdG9yd2F5X2p1bmN0aW9uDQoNCgkJZ3BzIHdheXBvaW50cyA6IGdw>> maprule_blob.txt
ECHO c3dheXBvaW50W10NCgkJZ3BzIHRyYWNrcG9pbnRzOiBncHN0cmFja1tdLmdwc3Bv>> maprule_blob.txt
ECHO aW50W10NCgkJZ3BzIHJvdXRlcG9pbnRzOiBncHNyb3V0ZVtdLmdwc3BvaW50W10N>> maprule_blob.txt
ECHO Cg0KcHJvcGVydGllcw0KCW1hcC1iYWNrZ3JvdW5kLWNvbG9yCTogI0YxRUVFOA0K>> maprule_blob.txt
ECHO CW1hcC1iYWNrZ3JvdW5kLW9wYWNpdHkJOiAxDQoJbWFwLXNlYS1jb2xvciA6ICNC>> maprule_blob.txt
ECHO NUQwRDANCglmb250LXdlaWdodCA6IGJvbGQNCglmb250LWZhbWlseSA6IFZlcmRh>> maprule_blob.txt
ECHO bmENCgl0ZXh0LW1heC13aWR0aCA6IDcNCgl0ZXh0LWhhbG8td2lkdGggOiAyNSUN>> maprule_blob.txt
ECHO Cgl0ZXh0LWhhbG8tb3BhY2l0eSA6IDAuNzUNCgl0ZXh0LWFsaWduLWhvcml6b250>> maprule_blob.txt
ECHO YWwgOiBjZW50ZXINCgl0ZXh0LWFsaWduLXZlcnRpY2FsIDogY2VudGVyDQoJZm9u>> maprule_blob.txt
ECHO dC1zdHJldGNoIDogMC45DQoJbWFwLnJlbmRlcmluZy5sZmxwLm1pbi1idWZmZXIt>> maprule_blob.txt
ECHO c3BhY2UgOiA0DQoJbWFwLnJlbmRlcmluZy5sZmxwLm1heC1hbGxvd2VkLWNvcm5l>> maprule_blob.txt
ECHO ci1hbmdsZSA6IDQwDQoNCnJ1bGVzDQoJdGFyZ2V0OiBncHMgdHJhY2tzDQoJCWRl>> maprule_blob.txt
ECHO ZmluZQ0KCQkJbGluZS1jb2xvciA6IHJlZA0KCQkJbGluZS1vcGFjaXR5IDogMC43>> maprule_blob.txt
ECHO NQ0KCQkJbWluLXpvb20gOiA1DQoJCQlsaW5lLXdpZHRoIDogNQ0KCQlkcmF3IDog>> maprule_blob.txt
ECHO bGluZQ0KDQoJdGFyZ2V0OiBncHMgcm91dGVzDQoJCWRlZmluZQ0KCQkJbGluZS1j>> maprule_blob.txt
ECHO b2xvciA6IGJsdWUNCgkJCWxpbmUtb3BhY2l0eSA6IDAuNzUNCgkJCWxpbmUtc3R5>> maprule_blob.txt
ECHO bGUgOiBkYXNoDQoJCQltaW4tem9vbSA6IDUNCgkJCWxpbmUtd2lkdGggOiA1DQoJ>> maprule_blob.txt
ECHO CWRyYXcgOiBsaW5lDQoNCgl0YXJnZXQgOiBncHMgd2F5cG9pbnRzDQoJCWRlZmlu>> maprule_blob.txt
ECHO ZQ0KCQkJc2hhcGUgOiBjaXJjbGUNCgkJCXNoYXBlLXNpemUgOiA4DQoJCQlsaW5l>> maprule_blob.txt
ECHO LWNvbG9yIDogZ3JlZW4NCgkJCWZpbGwtb3BhY2l0eSA6IDANCgkJZHJhdyA6IHNo>> maprule_blob.txt
ECHO YXBlDQoNCgl0YXJnZXQgOiBncHMgdHJhY2twb2ludHMNCgkJZGVmaW5lDQoJCQlt>> maprule_blob.txt
ECHO aW4tem9vbSA6IDE3DQoJCQlzaGFwZSA6IHNxdWFyZQ0KCQkJc2hhcGUtc2l6ZSA6>> maprule_blob.txt
ECHO IDEwDQoJCQlsaW5lLWNvbG9yIDogZ3JlZW4NCgkJCWxpbmUtd2lkdGggOiAxDQoJ>> maprule_blob.txt
ECHO CQlmaWxsLW9wYWNpdHkgOiAwDQoJCWRyYXcgOiBzaGFwZQ0KDQoNCgl0YXJnZXQg>> maprule_blob.txt
ECHO OiBncHMgcm91dGVwb2ludHMNCgkJZGVmaW5lDQoJCQltaW4tem9vbSA6IDEyDQoJ>> maprule_blob.txt
ECHO CQlzaGFwZSA6IGRpYW1vbmQNCgkJCXNoYXBlLXNpemUgOiAxMA0KCQkJbGluZS1j>> maprule_blob.txt
ECHO b2xvciA6IGdyZWVuDQoJCQlsaW5lLXdpZHRoIDogMQ0KCQkJZmlsbC1vcGFjaXR5>> maprule_blob.txt
ECHO IDogMA0KCQlkcmF3IDogc2hhcGUNCg0KCXRhcmdldCA6ICRmZWF0dXJldHlwZShw>> maprule_blob.txt
ECHO b2ludCkNCgkJaWYgOiBwbGFjZSoNCgkJCWRlZmluZQ0KCQkJCWZvbnQtd2VpZ2h0>> maprule_blob.txt
ECHO IDogYm9sZA0KCQkJCXRleHQtbWF4LXdpZHRoIDogMTAwMA0KCQkJCXRleHQtYWxp>> maprule_blob.txt
ECHO Z24taG9yaXpvbnRhbCA6IG5lYXINCg0KCQkJaWYgOiAqY2l0eQ0KCQkJCWRlZmlu>> maprule_blob.txt
ECHO ZQ0KCQkJCQlmb250LXNpemUgOiA2Ojg7MTQ6MjANCgkJCQkJbWluLXpvb20gOiA2>> maprule_blob.txt
ECHO DQoJCQkJCW1heC16b29tIDogMTQNCgkJCQkJcGxhY2VtZW50LXZhbHVlIDogMTAw>> maprule_blob.txt
ECHO MA0KCQkJZWxzZWlmIDogKnRvd24NCgkJCQlkZWZpbmUNCgkJCQkJZm9udC1zaXpl>> maprule_blob.txt
ECHO IDogOTo4OzEyOjEwOzIwOjIwDQoJCQkJCW1pbi16b29tIDogOQ0KCQkJCQlwbGFj>> maprule_blob.txt
ECHO ZW1lbnQtdmFsdWUgOiAyMA0KCQkJZWxzZWlmIDogKnZpbGxhZ2UNCgkJCQlkZWZp>> maprule_blob.txt
ECHO bmUNCgkJCQkJZm9udC1zaXplIDogMTI6MTA7MjA6MjANCgkJCQkJbWluLXpvb20g>> maprule_blob.txt
ECHO OiAxMg0KCQkJCQlwbGFjZW1lbnQtdmFsdWUgOiAxDQoJCQllbHNlaWYgOiAqaGFt>> maprule_blob.txt
ECHO bGV0DQoJCQkJZGVmaW5lDQoJCQkJCWZvbnQtc2l6ZSA6IDE0Ojg7MjA6MTYNCgkJ>> maprule_blob.txt
ECHO CQkJbWluLXpvb20gOiAxNA0KCQkJCQlwbGFjZW1lbnQtdmFsdWUgOiAwLjENCgkJ>> maprule_blob.txt
ECHO CWVsc2VpZiA6ICpsb2NhbGl0eQ0KCQkJCWRlZmluZQ0KCQkJCQlmb250LXNpemUg>> maprule_blob.txt
ECHO OiAxNDo4OzIwOjE2DQoJCQkJCW1pbi16b29tIDogMTQNCgkJCQkJcGxhY2VtZW50>> maprule_blob.txt
ECHO LXZhbHVlIDogMC4xDQoJCQllbHNlaWYgOiAqaXNvbGF0ZWRfZHdlbGxpbmcNCgkJ>> maprule_blob.txt
ECHO CQlkZWZpbmUNCgkJCQkJZm9udC1zaXplIDogMTU6ODsyMDoxNA0KCQkJCQltaW4t>> maprule_blob.txt
ECHO em9vbSA6IDE1CQ0KCQkJCQlwbGFjZW1lbnQtdmFsdWUgOiAwLjENCgkJCWVsc2Vp>> maprule_blob.txt
ECHO ZiA6ICpzdWJ1cmINCgkJCQlkZWZpbmUNCgkJCQkJZm9udC1zaXplIDogMTM6MTA7>> maprule_blob.txt
ECHO MjA6MjANCgkJCQkJbWluLXpvb20gOiAxMw0KCQkJCQl0ZXh0LWNvbG9yIDogd2hp>> maprule_blob.txt
ECHO dGUgYmxhY2sgNTAlDQoJCQkJCXBsYWNlbWVudC12YWx1ZSA6IDEwDQoJCQlkcmF3>> maprule_blob.txt
ECHO IDogdGV4dA0KCQlpZiA6IGFlcmlhbHdheSBzdGF0aW9uDQoJCQlkZWZpbmUNCgkJ>> maprule_blob.txt
ECHO CQltaW4tem9vbToxMg0KCQkJCXNoYXBlOnNxdWFyZQ0KCQkJCXNoYXBlLXNpemU6>> maprule_blob.txt
ECHO MTI6MzsxNjo4DQoJCQkJZmlsbC1jb2xvcjojNzk4MUIwDQoJCQkJbGluZS1zdHls>> maprule_blob.txt
ECHO ZTpub25lDQoJCQkJdGV4dC1vZmZzZXQtdmVydGljYWw6MTIwJQ0KCQkJCXRleHQt>> maprule_blob.txt
ECHO Y29sb3I6Izg4ODhGRg0KCQkJZHJhdzpzaGFwZQ0KCQkJZHJhdzp0ZXh0DQoNCg0K>> maprule_blob.txt
ECHO CXRhcmdldCA6IGhvdXNlbnVtYmVyDQoJCWRlZmluZQ0KCQkJbWluLXpvb20gOiAx>> maprule_blob.txt
ECHO NA0KCQkJdGV4dCA6IFtbYWRkcjpob3VzZW51bWJlcl1dDQoJCQl0ZXh0LWhhbG8t>> maprule_blob.txt
ECHO d2lkdGggOiAyDQoJCQlmb250LXNpemUgOiAxNDozOzE3OjcNCgkJCXBsYWNlbWVu>> maprule_blob.txt
ECHO dC12YWx1ZSA6IDAuMDENCgkJZHJhdyA6IHRleHQNCgl0YXJnZXQgOiBwbGF5Z3Jv>> maprule_blob.txt
ECHO dW5kDQoJCWRlZmluZQ0KCQkJZmlsbC1jb2xvciA6ICNDQ0ZFRjANCgkJCWxpbmUt>> maprule_blob.txt
ECHO c3R5bGUgOiBub25lDQoJCWRyYXcgOiBmaWxsDQoJCWRlZmluZQ0KCQkJbGluZS1j>> maprule_blob.txt
ECHO b2xvciA6ICNBRENDQjUNCgkJCWxpbmUtd2lkdGggOiAxDQoJCWRyYXcgOiBsaW5l>> maprule_blob.txt
ECHO DQoJCWRlZmluZQ0KCQkJbWluLXpvb20gOiAxNw0KCQkJcGxhY2VtZW50LXZhbHVl>> maprule_blob.txt
ECHO IDogMC4wNQ0KCQlkcmF3IDogdGV4dA0KDQoJdGFyZ2V0IDogJGZlYXR1cmV0eXBl>> maprule_blob.txt
ECHO KGFyZWEpDQoJCWRlZmluZQ0KCQkJbGluZS1zdHlsZSA6IG5vbmUNCgkJCWxpbmUt>> maprule_blob.txt
ECHO d2lkdGggOiAxDQoJCWlmIDogZm9yZXN0DQoJCQlkZWZpbmUNCgkJCQltaW4tem9v>> maprule_blob.txt
ECHO bSA6IDkNCgkJCQlmaWxsLWNvbG9yIDogIzhEQzU2Qw0KCQllbHNlaWYgOiBiZWFj>> maprule_blob.txt
ECHO aA0KCQkJZGVmaW5lDQoJCQkJbWluLXpvb20gOiAxMA0KCQkJCWZpbGwtY29sb3Ig>> maprule_blob.txt
ECHO OiAjRkVGRUMwDQoJCWVsc2VpZiA6IGZhcm0NCgkJCWRlZmluZQ0KCQkJCW1pbi16>> maprule_blob.txt
ECHO b29tIDogOQ0KCQkJCWZpbGwtY29sb3IgOiAjRTlEOEJEDQoJCWVsc2VpZiA6IGZh>> maprule_blob.txt
ECHO cm15YXJkDQoJCQlkZWZpbmUNCgkJCQltaW4tem9vbSA6IDkNCgkJCQlmaWxsLWNv>> maprule_blob.txt
ECHO bG9yIDogI0RDQkU5MQ0KCQllbHNlaWYgOiBmZWxsDQoJCQlkZWZpbmUNCgkJCQlm>> maprule_blob.txt
ECHO aWxsLWNvbG9yIDogI0M1RkY1QiBibGFjayAxMCUNCgkJZWxzZWlmIDogd2F0ZXIN>> maprule_blob.txt
ECHO CgkJCWRlZmluZQ0KCQkJCWZpbGwtY29sb3IgOiAjQjVEMEQwDQoJCWVsc2VpZjph>> maprule_blob.txt
ECHO Y2FkZW1pYw0KCQkJZGVmaW5lDQoJCQkJZmlsbC1jb2xvciA6ICNGMEYwRDgNCgkJ>> maprule_blob.txt
ECHO CQlsaW5lLWNvbG9yIDogI0U1RDJDQw0KCQkJCWxpbmUtc3R5bGUgOiBzb2xpZA0K>> maprule_blob.txt
ECHO CQllbHNlaWYgOiByZXNpZGVudGlhbCBhcmVhDQoJCQlkZWZpbmUNCgkJCQlmaWxs>> maprule_blob.txt
ECHO LWNvbG9yIDogI0RDRENEQw0KCQllbHNlaWYgOiBncmFzcw0KCQkJZGVmaW5lDQoJ>> maprule_blob.txt
ECHO CQkJZmlsbC1jb2xvciA6ICNDRkVDQTgNCgkJZWxzZWlmIDogYWxsb3RtZW50cw0K>> maprule_blob.txt
ECHO CQkJZGVmaW5lDQoJCQkJZmlsbC1jb2xvciA6ICNDOEIwODQNCgkJZWxzZWlmIDog>> maprule_blob.txt
ECHO bWVhZG93DQoJCQlkZWZpbmUNCgkJCQlmaWxsLWNvbG9yIDogI0NGRUNBOA0KCQll>> maprule_blob.txt
ECHO bHNlaWYgOiBuYXR1cmUgcmVzZXJ2ZQ0KCQkJZGVmaW5lDQoJCQkJZmlsbC1jb2xv>> maprule_blob.txt
ECHO ciA6ICNBQkRFOTYNCgkJZWxzZWlmIDogY2FyIHBhcmsNCgkJCWRlZmluZQ0KCQkJ>> maprule_blob.txt
ECHO CWZpbGwtY29sb3IgOiAjRjZFRUI3DQoJCWVsc2VpZiA6IHBhcmsNCgkJCWRlZmlu>> maprule_blob.txt
ECHO ZQ0KCQkJCWZpbGwtY29sb3IgOiAjQzBGNkIwDQoJCWVsc2VpZiA6IGxlaXN1cmUg>> maprule_blob.txt
ECHO Z2FyZGVuDQoJCQlkZWZpbmUNCgkJCQlmaWxsLWNvbG9yIDogI0NGRUNBOA0KCQll>> maprule_blob.txt
ECHO bHNlaWYgOiBncmF2ZXlhcmQNCgkJCWRlZmluZQ0KCQkJCWZpbGwtY29sb3IgOiAj>> maprule_blob.txt
ECHO QTlDQUFFDQoJCWVsc2VpZiA6IGJ1aWxkaW5nDQoJCQlkZWZpbmUNCgkJCQlmaWxs>> maprule_blob.txt
ECHO LWNvbG9yIDogI0JDQTlBOQ0KCQllbHNlaWYgOiBsZWlzdXJlIHBpdGNoDQoJCQlk>> maprule_blob.txt
ECHO ZWZpbmUNCgkJCQlmaWxsLWNvbG9yIDogIzg5RDJBRQ0KCQllbHNlaWYgOiBsZWlz>> maprule_blob.txt
ECHO dXJlIHN0YWRpdW0NCgkJCWRlZmluZQ0KCQkJCWZpbGwtY29sb3IgOiAjMzNDQzk5>> maprule_blob.txt
ECHO DQoJCWVsc2VpZiA6IHRyYWNrDQoJCQlkZWZpbmUNCgkJCQlmaWxsLWNvbG9yIDog>> maprule_blob.txt
ECHO Izc0RENCQQ0KCQllbHNlaWYgOiB2aWxsYWdlIGdyZWVuDQoJCQlkZWZpbmUNCgkJ>> maprule_blob.txt
ECHO CQlmaWxsLWNvbG9yIDogI0NGRUNBOA0KCQllbHNlaWYgOiBsYW5kdXNlIHJldGFp>> maprule_blob.txt
ECHO bA0KCQkJZGVmaW5lDQoJCQkJZmlsbC1jb2xvciA6ICNGMEQ5RDkNCgkJCQlsaW5l>> maprule_blob.txt
ECHO LWNvbG9yIDogI0Y0QTE5RQ0KCQkJZHJhdyA6IGxpbmUNCgkJZWxzZWlmIDogbGFu>> maprule_blob.txt
ECHO ZHVzZSBpbmR1c3RyaWFsDQoJCQlkZWZpbmUNCgkJCQlmaWxsLWNvbG9yIDogI0RG>> maprule_blob.txt
ECHO RDFENg0KCQllbHNlaWYgOiBjb21tZXJjaWFsIGFyZWENCgkJCWRlZmluZQ0KCQkJ>> maprule_blob.txt
ECHO CWZpbGwtY29sb3IgOiAjRUZDOEM4DQoJCWVsc2VpZiA6IG1pbGl0YXJ5DQoJCQlk>> maprule_blob.txt
ECHO ZWZpbmUNCgkJCQlmaWxsLWNvbG9yIDogI0ZFOTg5OA0KCQllbHNlaWYgOiBhZXJv>> maprule_blob.txt
ECHO d2F5Kg0KCQkJZGVmaW5lDQoJCQkJZmlsbC1jb2xvciA6ICNFOUQxRkUNCgkJZWxz>> maprule_blob.txt
ECHO ZWlmIDogb3JjaGFyZA0KCQkJZGVmaW5lDQoJCQkJZmlsbC1jb2xvciA6ICM5ZmQ3>> maprule_blob.txt
ECHO OTANCgkJZWxzZWlmIDogZmFybWxhbmQNCgkJCWRlZmluZQ0KCQkJCWZpbGwtY29s>> maprule_blob.txt
ECHO b3IgOiAjZTlkOGJlDQoJCWVsc2VpZiA6IGFlcm9kcm9tZQ0KCQkJZGVmaW5lDQoJ>> maprule_blob.txt
ECHO CQkJZmlsbC1jb2xvciA6ICNlOWU4ZTMNCgkJCQlsaW5lLXN0eWxlIDogc29saWQN>> maprule_blob.txt
ECHO CgkJCQlsaW5lLWNvbG9yIDogI2IzYjNiMCBibGFjayAxMCUNCgkJZWxzZWlmIDog>> maprule_blob.txt
ECHO cXVhcnJ5DQoJCQlkZWZpbmUNCgkJCQlmaWxsLWNvbG9yIDogd2hpdGUNCgkJCQls>> maprule_blob.txt
ECHO aW5lLXN0eWxlIDogc29saWQNCgkJCQlsaW5lLWNvbG9yIDogI2IzYjNiMCBibGFj>> maprule_blob.txt
ECHO ayAxMCUNCgkJCQlmaWxsLWhhdGNoIDogZGlhZ29uYWxjcm9zcw0KCQkJCWZpbGwt>> maprule_blob.txt
ECHO aGF0Y2gtY29sb3IgOiAjY2NjY2NjDQoJCWVsc2VpZiA6IGdsYWNpZXINCgkJCWRl>> maprule_blob.txt
ECHO ZmluZQ0KCQkJCWZpbGwtY29sb3IgOiAjRERFQ0VDDQoJCQkJbGluZS1zdHlsZSA6>> maprule_blob.txt
ECHO IGRhc2gNCgkJCQlsaW5lLWNvbG9yIDogI0RERUNFQyBibGFjayAxMCUNCgkJZWxz>> maprule_blob.txt
ECHO ZWlmIDogKnBlZGVzdHJpYW4NCgkJCWZvciA6IGFyZWENCgkJCQlkZWZpbmUNCgkJ>> maprule_blob.txt
ECHO CQkJbWluLXpvb20gOiAxNA0KCQkJCQlmaWxsLWNvbG9yIDogI0VERURFRA0KCQkJ>> maprule_blob.txt
ECHO CQlsaW5lLWNvbG9yIDogI0IxQjFCMSBibGFjayAyMCUNCgkJCQkJbGluZS1zdHls>> maprule_blob.txt
ECHO ZSA6IHNvbGlkDQoJCWVsc2UNCgkJCXN0b3ANCgkJZHJhdyA6IGZpbGwNCgkJaWYg>> maprule_blob.txt
ECHO OiBidWlsZGluZw0KCQkJZGVmaW5lDQoJCQkJbWluLXpvb20gOiAxNQ0KCQkJCWxp>> maprule_blob.txt
ECHO bmUtc3R5bGUgOiBzb2xpZA0KCQkJCWxpbmUtd2lkdGggOiAxDQoJCQkJbGluZS1j>> maprule_blob.txt
ECHO b2xvciA6ICM2NjYNCgkJCWRyYXcgOiBsaW5lDQoJCWZvciA6IGFtZW5pdHk9aG9z>> maprule_blob.txt
ECHO cGl0YWwNCgkJCXN0b3ANCgkJZGVmaW5lDQoJCQltaW4tem9vbSA6IDE3DQoJCWlm>> maprule_blob.txt
ECHO OmFjYWRlbWljDQoJCQlkZWZpbmUNCgkJCQltaW4tem9vbToxNg0KCQlkcmF3IDog>> maprule_blob.txt
ECHO dGV4dA0KDQovLwkJYWVyb3dheSB0YXhpd2F5IDogYWVyb3dheT10YXhpd2F5DQov>> maprule_blob.txt
ECHO LwkJYWVyb3dheSBhcHJvbiA6IGFlcm93YXk9YXByb24NCi8vCQlhZXJvd2F5IHRl>> maprule_blob.txt
ECHO cm1pbmFsIDogYWVyb3dheT10ZXJtaW5hbA0KDQoJdGFyZ2V0IDogYWVyb3dheSBy>> maprule_blob.txt
ECHO dW53YXkNCgkJZGVmaW5lDQoJCQltaW4tem9vbSA6IDExDQoJCQlsaW5lLWNvbG9y>> maprule_blob.txt
ECHO IDogI0JCQkJDQw0KCQkJbGluZS13aWR0aCA6IDExOjI7MTU6MjANCgkJZHJhdyA6>> maprule_blob.txt
ECHO IGxpbmUNCg0KCXRhcmdldCA6IGFlcm93YXkgdGF4aXdheQ0KCQlkZWZpbmUNCgkJ>> maprule_blob.txt
ECHO CW1pbi16b29tIDogMTENCgkJCWxpbmUtY29sb3IgOiAjQkJCQkNDDQoJCQlsaW5l>> maprule_blob.txt
ECHO LXdpZHRoIDogMTE6MTsxNTo2DQoJCWRyYXcgOiBsaW5lDQoNCgl0YXJnZXQgOiBn>> maprule_blob.txt
ECHO bGFjaWVyDQoJCWRlZmluZQ0KCQkJbWluLXpvb20gOiAxMA0KCQkJdGV4dC1jb2xv>> maprule_blob.txt
ECHO ciA6ICNBM0EzRkUNCgkJZHJhdyA6IHRleHQNCg0KCXRhcmdldCA6IGJvdW5kYXJ5>> maprule_blob.txt
ECHO Kg0KCQlkZWZpbmUNCgkJCWxpbmUtY29sb3IgOiAjOUUxQTk5DQoJCQlsaW5lLW9w>> maprule_blob.txt
ECHO YWNpdHkgOiAwLjUNCgkJaWYgOiBib3VuZGFyeSBjb3VudHJ5DQoJCQlkZWZpbmUN>> maprule_blob.txt
ECHO CgkJCQlsaW5lLXdpZHRoIDogNjoxOzk6MzsxMDo2DQoJCWVsc2VpZiA6IGJvdW5k>> maprule_blob.txt
ECHO YXJ5IHByb3ZpbmNlDQoJCQlkZWZpbmUNCgkJCQltaW4tem9vbSA6IDQNCgkJCQls>> maprule_blob.txt
ECHO aW5lLXdpZHRoIDogNDoxOzExOjMNCgkJCQlsaW5lLXN0eWxlIDogZGFzaA0KCQll>> maprule_blob.txt
ECHO bHNlaWYgOiBib3VuZGFyeSBtdW5pY2lwYWwNCgkJCWRlZmluZQ0KCQkJCW1pbi16>> maprule_blob.txt
ECHO b29tIDogMTINCgkJCQlsaW5lLXdpZHRoIDogMTI6MTsxNDoyDQoJCQkJbGluZS1z>> maprule_blob.txt
ECHO dHlsZSA6IGRhc2gNCgkJZHJhdyA6IGxpbmUNCg0KCXRhcmdldCA6IG5hdGlvbmFs>> maprule_blob.txt
ECHO IHBhcmsNCgkJZGVmaW5lDQoJCQlmaWxsLWNvbG9yIDogIzhEQzU2Qw0KCQkJZmls>> maprule_blob.txt
ECHO bC1vcGFjaXR5IDogMC4yDQoJCQlsaW5lLXN0eWxlIDogbm9uZQ0KCQlkcmF3IDog>> maprule_blob.txt
ECHO ZmlsbA0KCQlkZWZpbmUNCgkJCWxpbmUtY29sb3IgOiAjOERDNTZDIGJsYWNrIDIw>> maprule_blob.txt
ECHO JQ0KCQkJbGluZS1vcGFjaXR5IDogMC41DQoJCQlsaW5lLXdpZHRoIDogMw0KCQkJ>> maprule_blob.txt
ECHO bGluZS1zdHlsZSA6IGRhc2gNCgkJCWZvbnQtc2l6ZSA6IDM6MzsxMjoxMg0KCQkJ>> maprule_blob.txt
ECHO dGV4dC1jb2xvciA6IGdyZWVuDQoJCQlmb250LXdlaWdodCA6IG5vcm1hbA0KCQlk>> maprule_blob.txt
ECHO cmF3IDogbGluZQ0KCQlkcmF3IDogdGV4dA0KDQoJdGFyZ2V0IDogcGVhaw0KCQlk>> maprule_blob.txt
ECHO ZWZpbmUNCgkJCXNoYXBlIDogdHJpYW5nbGUNCgkJCXNoYXBlLXNpemUgOiAxMg0K>> maprule_blob.txt
ECHO CQkJZmlsbC1jb2xvciA6ICNEMDhGNTUNCgkJCWxpbmUtc3R5bGUgOiBub25lDQoJ>> maprule_blob.txt
ECHO CQltaW4tem9vbSA6IDExDQoJCWRyYXcgOiBzaGFwZQ0KCQlkZWZpbmUNCgkJCXRl>> maprule_blob.txt
ECHO eHQgOiBAaWYobmFtZSwgbmFtZSBAaWYoZWxlLCAiXG4oIiBlbGUgIikiKSwgZWxl>> maprule_blob.txt
ECHO KQ0KCQkJdGV4dC1jb2xvciA6ICNhZTQyNDINCgkJCW1pbi16b29tIDogMTMNCgkJ>> maprule_blob.txt
ECHO CWZvbnQtc2l6ZSA6IDEwDQoJCQl0ZXh0LW1heC13aWR0aCA6IDEwDQoJCQl0ZXh0>> maprule_blob.txt
ECHO LW9mZnNldC12ZXJ0aWNhbCA6IDEwMCUNCgkJCXRleHQtYWxpZ24tdmVydGljYWwg>> maprule_blob.txt
ECHO OiBuZWFyDQoJCWRyYXcgOiB0ZXh0DQoNCgl0YXJnZXQgOiBpbmZvDQoJCWRlZmlu>> maprule_blob.txt
ECHO ZQ0KCQkJbWluLXpvb20gOiAxNg0KCQkJdGV4dCA6ICJpIg0KCQkJdGV4dC1jb2xv>> maprule_blob.txt
ECHO ciA6ICM3MzRBMDgNCgkJCWZvbnQtc2l6ZSA6IDIwDQoJCQlmb250LWZhbWlseSA6>> maprule_blob.txt
ECHO IFRpbWVzIE5ldyBSb21hbg0KCQkJdGV4dC1oYWxvLXdpZHRoIDogMA0KCQlkcmF3>> maprule_blob.txt
ECHO IDogdGV4dA0KCXRhcmdldCA6IGxpZnRfZ2F0ZQ0KCQlkZWZpbmUNCgkJCW1pbi16>> maprule_blob.txt
ECHO b29tIDogMTYNCgkJCXNoYXBlIDogY3VzdG9tDQoJCQlzaGFwZS1kZWYgOiBmOiMz>> maprule_blob.txt
ECHO RTNFM0U7cDojM0UzRTNFOy0xLDE7LTEsLTM7LTMsLTM7LTMsMzstMSwzOy0xLDI7>> maprule_blob.txt
ECHO NCwyOzQsMTtaDQoJCQlzaGFwZS1zaXplIDogMTQ6NzsyMDoxMg0KCQkJbGluZS13>> maprule_blob.txt
ECHO aWR0aCA6IDENCgkJZHJhdyA6IHNoYXBlDQoJdGFyZ2V0IDogYm9sbGFyZA0KCQlk>> maprule_blob.txt
ECHO ZWZpbmUNCgkJCW1pbi16b29tIDogMTYNCgkJCWZpbGwtY29sb3IgOiAjN0Q3RDdE>> maprule_blob.txt
ECHO DQoJCQlsaW5lLXN0eWxlIDogbm9uZQ0KCQkJc2hhcGUtc2l6ZSA6IDE2OjE7MTg6>> maprule_blob.txt
ECHO Mg0KCQlkcmF3IDogc2hhcGUNCgl0YXJnZXQgOiBwb3dlcnRvd2VyDQoJCWRlZmlu>> maprule_blob.txt
ECHO ZQ0KCQkJbWluLXpvb206IDE0DQoJCQlzaGFwZSA6IGN1c3RvbQ0KCQkJc2hhcGUt>> maprule_blob.txt
ECHO ZGVmIDogbTotMSwxO2w6MSwxLDEsLTEsLTEsLTEsLTEsMSwxLC0xO206LTEsLTE7>> maprule_blob.txt
ECHO bDoxLDENCgkJCXNoYXBlLXNpemUgOiAxNDoyOzIwOjkNCgkJCWxpbmUtd2lkdGgg>> maprule_blob.txt
ECHO OiAxDQoJCWRyYXcgOiBzaGFwZQ0KDQoJdGFyZ2V0IDogcG93ZXJfbGluZQ0KCQlk>> maprule_blob.txt
ECHO ZWZpbmUNCgkJCW1pbi16b29tOiAxNg0KCQkJbGluZS13aWR0aDogMQ0KCQkJbGlu>> maprule_blob.txt
ECHO ZS1jb2xvciA6ICM1YzVjNWMgd2hpdGUgNTAlDQoJCWZvciA6IHBvd2VyPWxpbmUN>> maprule_blob.txt
ECHO CgkJCWRlZmluZQ0KCQkJCWxpbmUtY29sb3IgOiAjNWM1YzVjDQoJCQkJbWluLXpv>> maprule_blob.txt
ECHO b20gOiAxNA0KCQkJCWxpbmUtd2lkdGg6IDENCgkJZHJhdyA6IGxpbmUNCg0KCXRh>> maprule_blob.txt
ECHO cmdldDphZXJpYWx3YXkgKg0KCQlkZWZpbmUNCgkJCW1pbi16b29tOjEyDQoJCQls>> maprule_blob.txt
ECHO aW5lLXdpZHRoOjENCgkJCWxpbmUtc3R5bGU6c29saWQNCgkJCWxpbmUtY29sb3I6>> maprule_blob.txt
ECHO Izk5OQ0KCQlkcmF3OmxpbmUNCgkJZHJhdzp0ZXh0DQoJdGFyZ2V0OmFlcmlhbHdh>> maprule_blob.txt
ECHO eSBjbG9zZWQNCgkJZGVmaW5lDQoJCQltaW4tem9vbToxMg0KCQkJc2hhcGU6Y2ly>> maprule_blob.txt
ECHO Y2xlDQoJCQlzaGFwZS1zaXplOjENCgkJCXNoYXBlLXNwYWNpbmc6MjANCgkJZHJh>> maprule_blob.txt
ECHO dzpzaGFwZQ0KCXRhcmdldDphZXJpYWx3YXkgb3Blbg0KCQlkZWZpbmUNCgkJCW1p>> maprule_blob.txt
ECHO bi16b29tOjEyDQoJCQlzaGFwZTpjdXN0b20NCgkJCXNoYXBlLWRlZjpsOjAsMSww>> maprule_blob.txt
ECHO LC0xDQoJCQlzaGFwZS1zcGFjaW5nOjUNCgkJCXNoYXBlLXNpemU6Mw0KCQkJbGlu>> maprule_blob.txt
ECHO ZS13aWR0aDoxDQoJCWRyYXc6c2hhcGUNCgl0YXJnZXQgOiBwbGF0Zm9ybQ0KCQlk>> maprule_blob.txt
ECHO ZWZpbmUNCgkJCW1pbi16b29tIDogMTMNCgkJCWxpbmUtY29sb3IgOiBncmF5DQoJ>> maprule_blob.txt
ECHO CQlsaW5lLXdpZHRoIDogMw0KCQlkcmF3IDogbGluZQ0KCXRhcmdldCA6IHJhaWx3>> maprule_blob.txt
ECHO YXkgcmFpbA0KCQlkZWZpbmUNCgkJCW1pbi16b29tIDogMTMNCgkJCWxpbmUtc3R5>> maprule_blob.txt
ECHO bGUgOiBkYXNobG9uZw0KCQkJbGluZS1jb2xvciA6IHdoaXRlDQoJCQlsaW5lLXdp>> maprule_blob.txt
ECHO ZHRoIDogMg0KCQkJYm9yZGVyLXN0eWxlIDogc29saWQNCgkJCWJvcmRlci1jb2xv>> maprule_blob.txt
ECHO ciA6IGdyYXkNCgkJCWJvcmRlci13aWR0aCA6IDI1JQ0KCQlkcmF3IDogbGluZQ0K>> maprule_blob.txt
ECHO CQlkZWZpbmUNCgkJCW1pbi16b29tIDogNg0KCQkJbWF4LXpvb20gOiAxMw0KCQkJ>> maprule_blob.txt
ECHO bGluZS1zdHlsZSA6IG5vbmUNCgkJCWxpbmUtY29sb3IgOiB3aGl0ZSBibGFjayAz>> maprule_blob.txt
ECHO MCUNCgkJCWxpbmUtd2lkdGggOiA2OjE7ODoxOzEyOjEuNQ0KCQlkcmF3IDogbGlu>> maprule_blob.txt
ECHO ZQ0KCXRhcmdldCA6IHJhaWx3YXkqDQoJCWRlZmluZQ0KCQkJbWluLXpvb20gOiAx>> maprule_blob.txt
ECHO Mw0KCQkJbGluZS1jb2xvciA6IGdyYXkNCgkJCWxpbmUtd2lkdGggOiAyDQoJCWRy>> maprule_blob.txt
ECHO YXcgOiBsaW5lDQoJCWRlZmluZQ0KCQkJbWluLXpvb20gOiAxNQ0KCQkJdGV4dC1h>> maprule_blob.txt
ECHO bGlnbi1ob3Jpem9udGFsIDogY2VudGVyDQoJCQl0ZXh0LWFsaWduLXZlcnRpY2Fs>> maprule_blob.txt
ECHO IDogY2VudGVyDQoJCWRyYXc6dGV4dA0KDQoJdGFyZ2V0IDogaGlnaHdheSBhY2Nl>> maprule_blob.txt
ECHO c3MqDQoJCWRlZmluZQ0KCQkJbWluLXpvb20gOiAxMw0KCQkJbGluZS13aWR0aCA6>> maprule_blob.txt
ECHO IDEzOjE7MTU6MjsxODo0DQoJCQlsaW5lLXN0eWxlIDogZGFzaA0KCQkJbGluZS1j>> maprule_blob.txt
ECHO b2xvciA6ICNGN0Q0RDQNCgkJZm9yIDogYWNjZXNzPWRlc3RpbmF0aW9uDQoJCQlk>> maprule_blob.txt
ECHO ZWZpbmUNCgkJCQlsaW5lLWNvbG9yIDogbGlnaHRibHVlIHdoaXRlIDUwJQ0KCQlk>> maprule_blob.txt
ECHO cmF3IDogbGluZQ0KDQoJdGFyZ2V0IDogaGlnaHdheSBjb25zdHJ1Y3Rpb24NCgkJ>> maprule_blob.txt
ECHO ZGVmaW5lDQoJCQltaW4tem9vbSA6IDEzDQoJCQlsaW5lLXdpZHRoIDogMTM6Mjsx>> maprule_blob.txt
ECHO NTo0OzE4OjEwDQoJCQlsaW5lLXN0eWxlIDogZG90DQoJCQlsaW5lLWNvbG9yIDog>> maprule_blob.txt
ECHO eWVsbG93DQoJCWZvciA6IGNvbnN0cnVjdGlvbj10ZXJ0aWFyeSBPUiBjb25zdHJ1>> maprule_blob.txt
ECHO Y3Rpb249c2Vjb25kYXJ5IE9SIGNvbnN0cnVjdGlvbj1wcmltYXJ5DQoJCQlkZWZp>> maprule_blob.txt
ECHO bmUNCgkJCQlsaW5lLWNvbG9yIDogd2hpdGUNCgkJZHJhdyA6IGxpbmUNCg0KCXRh>> maprule_blob.txt
ECHO cmdldCA6IG1vdG9yd2F5X2p1bmN0aW9uDQoJCWRlZmluZQ0KCQkJZm9udC1zaXpl>> maprule_blob.txt
ECHO IDogMTEgDQoJCQltaW4tem9vbSA6IDEzDQoJCQl0ZXh0LWNvbG9yIDogIzg0OUJC>> maprule_blob.txt
ECHO RA0KCQkJdGV4dC1oYWxvLXdpZHRoIDogMjUlDQoJCQl0ZXh0LW9mZnNldC12ZXJ0>> maprule_blob.txt
ECHO aWNhbCA6IDE1MCUNCgkJZHJhdzogdGV4dA0KDQoJdGFyZ2V0IDogaGlnaHdheSoN>> maprule_blob.txt
ECHO CgkJZGVmaW5lDQoJCQlmb250LXNpemUgOiAxMzoxOzE4OjE1DQoJCQlmb250LXdl>> maprule_blob.txt
ECHO aWdodCA6IGJvbGQNCgkJCWZvbnQtc3RyZXRjaCA6IDAuNg0KCQkJbWFwLnJlbmRl>> maprule_blob.txt
ECHO cmluZy5sZmxwLm1pbi1idWZmZXItc3BhY2UgOiAxDQoJCQltYXAucmVuZGVyaW5n>> maprule_blob.txt
ECHO LmxmbHAubWF4LWFsbG93ZWQtY29ybmVyLWFuZ2xlIDogODANCg0KCQlmb3IgOiBv>> maprule_blob.txt
ECHO bmV3YXk9eWVzIE9SIG9uZXdheT10cnVlDQoJCQlkZWZpbmUNCgkJCQltaW4tem9v>> maprule_blob.txt
ECHO bSA6IDEzDQoJCQkJc2hhcGUgOiBjdXN0b20NCgkJCQlzaGFwZS1kZWYgOiA2MCww>> maprule_blob.txt
ECHO LDIwLC00MCwyMCwtMTUsLTYwLC0xNSwtNjAsMTUsMjAsMTUsMjAsNDA7Wg0KCQkJ>> maprule_blob.txt
ECHO CXNoYXBlLXNpemUgOiAxNTo2OzE4OjEyDQoJCQkJc2hhcGUtYXNwZWN0IDogMC43>> maprule_blob.txt
ECHO NQ0KCQkJCXNoYXBlLXNwYWNpbmcgOiA2DQoJCQkJZmlsbC1jb2xvciA6ICM2Qzcw>> maprule_blob.txt
ECHO ZDQNCgkJCQlsaW5lLXN0eWxlIDogbm9uZQ0KCQkJZm9yIDogb25ld2F5PS0xDQoJ>> maprule_blob.txt
ECHO CQkJZGVmaW5lDQoJCQkJCWFuZ2xlIDogMTgwDQoJCQlkcmF3IDogc2hhcGUNCg0K>> maprule_blob.txt
ECHO CQlkZWZpbmUNCgkJCWxpbmUtc3R5bGUgOiBzb2xpZA0KCQkJbGluZS1qb2luIDog>> maprule_blob.txt
ECHO cm91bmQNCgkJCWxpbmUtc3RhcnQtY2FwIDogcm91bmQNCgkJCWxpbmUtZW5kLWNh>> maprule_blob.txt
ECHO cCA6IHJvdW5kDQoNCgkJaWYgOiAqbW90b3J3YXkqDQoJCQlpZiA6ICpsaW5rDQoJ>> maprule_blob.txt
ECHO CQkJZGVmaW5lDQoJCQkJCWxpbmUtd2lkdGggOiA3OjE7MTI6MzsxMzo0OzE2OjU7>> maprule_blob.txt
ECHO MTg6Ng0KCQkJZWxzZQ0KCQkJCWRlZmluZQ0KCQkJCQlsaW5lLXdpZHRoIDogNzox>> maprule_blob.txt
ECHO Ozk6MjsxMjozOzEzOjc7MTY6MTA7MTg6MTINCgkJCWRlZmluZQ0KCQkJCW1pbi16>> maprule_blob.txt
ECHO b29tIDogMTINCgkJCQlsaW5lLWNvbG9yIDogIzg0OUJCRA0KCQkJCWJvcmRlci1z>> maprule_blob.txt
ECHO dHlsZSA6IHNvbGlkDQoJCQkJYm9yZGVyLWNvbG9yIDogIzg0OUJCRCBibGFjayAy>> maprule_blob.txt
ECHO MCUNCgkJCQlib3JkZXItd2lkdGggOiAxNSUNCgkJCWRyYXcgOiBsaW5lDQoJCQlk>> maprule_blob.txt
ECHO ZWZpbmUNCgkJCQltaW4tem9vbSA6IDcNCgkJCQltYXgtem9vbSA6IDEyDQoJCQkJ>> maprule_blob.txt
ECHO Ym9yZGVyLXN0eWxlIDogbm9uZQ0KCQkJZHJhdyA6IGxpbmUNCgkJCWRlZmluZQ0K>> maprule_blob.txt
ECHO CQkJCW1pbi16b29tIDogMTANCgkJCQltYXgtem9vbSA6IDIwDQoJCQkJZm9udC1m>> maprule_blob.txt
ECHO YW1pbHkgOiBUYWhvbWENCgkJCQl0ZXh0LWFsaWduLWhvcml6b250YWwgOiBjZW50>> maprule_blob.txt
ECHO ZXINCgkJCQl0ZXh0LWFsaWduLXZlcnRpY2FsIDogY2VudGVyDQoJCQkJdGV4dCA6>> maprule_blob.txt
ECHO IHJlZg0KCQkJCWZvbnQtc2l6ZSA6IDEyDQoJCQkJdGV4dC1jb2xvciA6ICNmY2Zj>> maprule_blob.txt
ECHO ZmINCgkJCQl0ZXh0LWhhbG8td2lkdGggOiAwDQoJCQkJc2hhcGUgOiBjdXN0b20N>> maprule_blob.txt
ECHO CgkJCQlzaGFwZS1kZWYgOiBwOiM4MDliYzA7cHc6NTtmOiM4MDliYzA7bTotMTAs>> maprule_blob.txt
ECHO LTEwO2w6MTAsLTEwO2E6MTAsMTAsMTAsMTA7bDotMTAsMTA7YToxMCwxMCwtMTAs>> maprule_blob.txt
ECHO LTEwO3o7cDojZmNmY2ZiO3B3OjI7bTotMTAsLTEwO2w6MTAsLTEwO2E6MTAsMTAs>> maprule_blob.txt
ECHO MTAsMTA7bDotMTAsMTA7YToxMCwxMCwtMTAsLTEwO3oNCgkJCQlzaGllbGQtcGFk>> maprule_blob.txt
ECHO ZGluZy1sZWZ0IDogNQ0KCQkJCXNoaWVsZC1wYWRkaW5nLXJpZ2h0IDogNQ0KCQkJ>> maprule_blob.txt
ECHO CXNoaWVsZC1wYWRkaW5nLXRvcCA6IDcNCgkJCQlzaGllbGQtcGFkZGluZy1ib3R0>> maprule_blob.txt
ECHO b20gOiA3DQoJCQkJc2hpZWxkLXJlc2l6ZS1tb2RlIDogZnJlZQ0KCQkJZHJhdyA6>> maprule_blob.txt
ECHO IHNoaWVsZA0KCQllbHNlaWYgOiAqdHJ1bmsqDQoJCQlkZWZpbmUNCgkJCQltaW4t>> maprule_blob.txt
ECHO em9vbSA6IDEyDQoJCQkJbGluZS1jb2xvciA6ICM5NkQyOTYNCgkJCQlsaW5lLXdp>> maprule_blob.txt
ECHO ZHRoIDogMTE6MTsxMzoyOzE1OjEwOzE4OjEyDQoJCQkJYm9yZGVyLXN0eWxlIDog>> maprule_blob.txt
ECHO c29saWQNCgkJCQlib3JkZXItY29sb3IgOiAjOTZEMjk2IGJsYWNrIDIwJQ0KCQkJ>> maprule_blob.txt
ECHO CWJvcmRlci13aWR0aCA6IDE1JQ0KCQkJZm9yIDogdHVubmVsPXllcw0KCQkJCWRl>> maprule_blob.txt
ECHO ZmluZQ0KCQkJCQlib3JkZXItc3R5bGUgOiBkb3QNCgkJCWRyYXcgOiBsaW5lDQoJ>> maprule_blob.txt
ECHO CQlkZWZpbmUNCgkJCQltaW4tem9vbSA6IDcNCgkJCQltYXgtem9vbSA6IDEyDQoJ>> maprule_blob.txt
ECHO CQkJYm9yZGVyLXN0eWxlIDogbm9uZQ0KCQkJZHJhdyA6IGxpbmUNCgkJZWxzZWlm>> maprule_blob.txt
ECHO IDogKnByaW1hcnkqDQoJCQlkZWZpbmUNCgkJCQltaW4tem9vbSA6IDExDQoJCQkJ>> maprule_blob.txt
ECHO bGluZS1jb2xvciA6ICNFQ0EyQTMNCgkJCQlsaW5lLXdpZHRoIDogMTE6MjsxMjoy>> maprule_blob.txt
ECHO OzE1OjEwOzE4OjEyDQoJCQkJYm9yZGVyLXN0eWxlIDogc29saWQNCgkJCQlib3Jk>> maprule_blob.txt
ECHO ZXItY29sb3IgOiAjRUNBMkEzIGJsYWNrIDIwJQ0KCQkJCWJvcmRlci13aWR0aCA6>> maprule_blob.txt
ECHO IDE1JQ0KCQkJZm9yIDogdHVubmVsPXllcw0KCQkJCWRlZmluZQ0KCQkJCQlib3Jk>> maprule_blob.txt
ECHO ZXItc3R5bGUgOiBkb3QNCgkJCWRyYXcgOiBsaW5lDQoJCQlkZWZpbmUNCgkJCQlt>> maprule_blob.txt
ECHO aW4tem9vbSA6IDcNCgkJCQltYXgtem9vbSA6IDExDQoJCQkJYm9yZGVyLXN0eWxl>> maprule_blob.txt
ECHO IDogbm9uZQ0KCQkJZHJhdyA6IGxpbmUNCgkJCWRlZmluZQ0KCQkJCW1pbi16b29t>> maprule_blob.txt
ECHO IDogMTMNCgkJCQltYXgtem9vbSA6IDIwDQoJCQlkcmF3IDogdGV4dA0KCQllbHNl>> maprule_blob.txt
ECHO aWYgOiAqc2Vjb25kYXJ5DQoJCQlkZWZpbmUNCgkJCQltaW4tem9vbSA6IDEyDQoJ>> maprule_blob.txt
ECHO CQkJbGluZS1jb2xvciA6ICNGREQ2QTQNCgkJCQlsaW5lLXdpZHRoIDogMTA6MTsx>> maprule_blob.txt
ECHO MToyOzEzOjI7MTU6MTA7MTg6MTINCgkJCQlib3JkZXItc3R5bGUgOiBzb2xpZA0K>> maprule_blob.txt
ECHO CQkJCWJvcmRlci1jb2xvciA6ICNDQUEzNkYNCgkJCQlib3JkZXItd2lkdGggOiA1>> maprule_blob.txt
ECHO JQ0KCQkJZm9yIDogdHVubmVsPXllcw0KCQkJCWRlZmluZQ0KCQkJCQlib3JkZXIt>> maprule_blob.txt
ECHO c3R5bGUgOiBkb3QNCgkJCWZvciA6IGJyaWRnZT15ZXMNCgkJCQlkZWZpbmUNCgkJ>> maprule_blob.txt
ECHO CQkJYm9yZGVyLWNvbG9yIDogIzAwMA0KCQkJCQlib3JkZXItd2lkdGggOiA4JQ0K>> maprule_blob.txt
ECHO CQkJZHJhdyA6IGxpbmUNCgkJCWRlZmluZQ0KCQkJCW1pbi16b29tIDogOC41DQoJ>> maprule_blob.txt
ECHO CQkJbWF4LXpvb20gOiAxMg0KCQkJCWJvcmRlci1zdHlsZSA6IG5vbmUNCgkJCWRy>> maprule_blob.txt
ECHO YXcgOiBsaW5lDQoJCQlkZWZpbmUNCgkJCQltaW4tem9vbSA6IDEzDQoJCQkJbWF4>> maprule_blob.txt
ECHO LXpvb20gOiAyMA0KCQkJZHJhdyA6IHRleHQNCgkJZWxzZWlmIDogKnRlcnRpYXJ5>> maprule_blob.txt
ECHO DQoJCQlkZWZpbmUNCgkJCQltaW4tem9vbSA6IDEzDQoJCQkJbGluZS1jb2xvciA6>> maprule_blob.txt
ECHO ICNGRUZFQjINCgkJCQlsaW5lLXdpZHRoIDogMTA6MTsxMzoyOzE1OjEwOzE4OjEy>> maprule_blob.txt
ECHO DQoJCQkJYm9yZGVyLXN0eWxlIDogc29saWQNCgkJCQlib3JkZXItY29sb3IgOiAj>> maprule_blob.txt
ECHO RkVGRUIyIGJsYWNrIDIwJQ0KCQkJCWJvcmRlci13aWR0aCA6IDE1JQ0KCQkJZm9y>> maprule_blob.txt
ECHO IDogdHVubmVsPXllcw0KCQkJCWRlZmluZQ0KCQkJCQlib3JkZXItc3R5bGUgOiBk>> maprule_blob.txt
ECHO b3QNCgkJCWZvciA6IGJyaWRnZT15ZXMNCgkJCQlkZWZpbmUNCgkJCQkJYm9yZGVy>> maprule_blob.txt
ECHO LWNvbG9yIDogIzAwMA0KCQkJZHJhdyA6IGxpbmUNCgkJCWRlZmluZQ0KCQkJCW1p>> maprule_blob.txt
ECHO bi16b29tIDogMTANCgkJCQltYXgtem9vbSA6IDEzDQoJCQkJbGluZS1jb2xvciA6>> maprule_blob.txt
ECHO IHdoaXRlIGJsYWNrIDI1JQ0KCQkJCWJvcmRlci1zdHlsZSA6IG5vbmUNCgkJCWRy>> maprule_blob.txt
ECHO YXcgOiBsaW5lDQoJCQlkZWZpbmUNCgkJCQltaW4tem9vbSA6IDEzDQoJCQkJbWF4>> maprule_blob.txt
ECHO LXpvb20gOiAyMA0KCQkJZHJhdyA6IHRleHQNCgkJZWxzZWlmIDogKnNlcnZpY2UN>> maprule_blob.txt
ECHO CgkJCWRlZmluZQ0KCQkJCW1pbi16b29tIDogMTMNCgkJCQlsaW5lLWNvbG9yIDog>> maprule_blob.txt
ECHO d2hpdGUNCgkJCQlsaW5lLXdpZHRoIDogMTI6MC41OzEzOjE7MTU6MzsxODo1DQoJ>> maprule_blob.txt
ECHO CQkJYm9yZGVyLXN0eWxlIDogc29saWQNCgkJCQlib3JkZXItY29sb3IgOiAjRkVG>> maprule_blob.txt
ECHO RUIyIGJsYWNrIDIwJQ0KCQkJCWJvcmRlci13aWR0aCA6IDE1JQ0KCQkJZm9yIDog>> maprule_blob.txt
ECHO dHVubmVsPXllcw0KCQkJCWRlZmluZQ0KCQkJCQlib3JkZXItc3R5bGUgOiBkb3QN>> maprule_blob.txt
ECHO CgkJCWZvciA6IGJyaWRnZT15ZXMNCgkJCQlkZWZpbmUNCgkJCQkJYm9yZGVyLWNv>> maprule_blob.txt
ECHO bG9yIDogIzAwMA0KCQkJZHJhdyA6IGxpbmUNCgkJCWRyYXcgOiB0ZXh0DQoJCWVs>> maprule_blob.txt
ECHO c2VpZiA6ICpwZWRlc3RyaWFuDQoJCQlmb3IgOiBub3QgYXJlYQ0KCQkJCWRlZmlu>> maprule_blob.txt
ECHO ZQ0KCQkJCQltaW4tem9vbSA6IDEzDQoJCQkJCWxpbmUtY29sb3IgOiAjRURFREVE>> maprule_blob.txt
ECHO DQoJCQkJCWxpbmUtd2lkdGggOiA3OjAuNjs5OjE7MTA6MS4yOzEyOjIuNTsxMzoz>> maprule_blob.txt
ECHO OzE2OjU7MTg6Ng0KCQkJCQlib3JkZXItc3R5bGUgOiBzb2xpZA0KCQkJCQlib3Jk>> maprule_blob.txt
ECHO ZXItY29sb3IgOiAjQjFCMUIxIGJsYWNrIDIwJQ0KCQkJCQlib3JkZXItd2lkdGgg>> maprule_blob.txt
ECHO OiAxNSUNCgkJCQlmb3IgOiB0dW5uZWw9eWVzDQoJCQkJCWRlZmluZQ0KCQkJCQkJ>> maprule_blob.txt
ECHO Ym9yZGVyLXN0eWxlIDogZG90DQoJCQkJZm9yIDogYnJpZGdlPXllcw0KCQkJCQlk>> maprule_blob.txt
ECHO ZWZpbmUNCgkJCQkJCWJvcmRlci1jb2xvciA6ICMwMDANCgkJCQlkcmF3IDogbGlu>> maprule_blob.txt
ECHO ZQ0KCQkJCWRyYXcgOiB0ZXh0DQoNCgkJZWxzZWlmIDogJHJlZ2V4KCIoLipyZXNp>> maprule_blob.txt
ECHO ZGVudGlhbCl8KC4qdW5jbGFzc2lmaWVkKSIpDQoJCQlkZWZpbmUNCgkJCQltaW4t>> maprule_blob.txt
ECHO em9vbSA6IDEzDQoJCQkJbGluZS1jb2xvciA6IHdoaXRlDQoJCQkJbGluZS13aWR0>> maprule_blob.txt
ECHO aCA6IDEyOjE7MTM6MS41OzE1OjY7MTg6MTUNCgkJCQlib3JkZXItc3R5bGUgOiBz>> maprule_blob.txt
ECHO b2xpZA0KCQkJCWJvcmRlci1jb2xvciA6IHdoaXRlIGJsYWNrIDI1JQ0KCQkJCWJv>> maprule_blob.txt
ECHO cmRlci13aWR0aCA6IDE1JQ0KCQkJZm9yIDogdHVubmVsPXllcw0KCQkJCWRlZmlu>> maprule_blob.txt
ECHO ZQ0KCQkJCQlib3JkZXItc3R5bGUgOiBkb3QNCgkJCWZvciA6IGJyaWRnZT15ZXMN>> maprule_blob.txt
ECHO CgkJCQlkZWZpbmUNCgkJCQkJYm9yZGVyLWNvbG9yIDogIzAwMA0KCQkJZHJhdyA6>> maprule_blob.txt
ECHO IGxpbmUNCgkJCWRlZmluZQ0KCQkJCW1pbi16b29tIDogMTANCgkJCQltYXgtem9v>> maprule_blob.txt
ECHO bSA6IDEzDQoJCQkJYm9yZGVyLXN0eWxlIDogbm9uZQ0KCQkJCWxpbmUtY29sb3Ig>> maprule_blob.txt
ECHO OiB3aGl0ZSBibGFjayAyNSUNCgkJCWRyYXcgOiBsaW5lDQoJCQlkZWZpbmUNCgkJ>> maprule_blob.txt
ECHO CQltaW4tem9vbSA6IDE0DQoJCQkJbWF4LXpvb20gOiAyMA0KCQkJZHJhdyA6IHRl>> maprule_blob.txt
ECHO eHQNCgkJZWxzZWlmIDogKmxpdmluZ19zdHJlZXQNCgkJCWRlZmluZQ0KCQkJCW1p>> maprule_blob.txt
ECHO bi16b29tIDogMTMNCgkJCQlsaW5lLWNvbG9yIDogd2hpdGUgYmxhY2sgMjUlDQoJ>> maprule_blob.txt
ECHO CQkJbGluZS13aWR0aCA6IDEyOjE7MTM6MS41OzE1OjY7MTg6MTUNCgkJCQlib3Jk>> maprule_blob.txt
ECHO ZXItc3R5bGUgOiBub25lDQoJCQlmb3IgOiB0dW5uZWw9eWVzDQoJCQkJZGVmaW5l>> maprule_blob.txt
ECHO DQoJCQkJCWJvcmRlci1zdHlsZSA6IGRvdA0KCQkJZm9yIDogYnJpZGdlPXllcw0K>> maprule_blob.txt
ECHO CQkJCWRlZmluZQ0KCQkJCQlib3JkZXItY29sb3IgOiAjMDAwDQoJCQlkcmF3IDog>> maprule_blob.txt
ECHO bGluZQ0KCQkJZGVmaW5lDQoJCQkJbWluLXpvb20gOiAxNA0KCQkJCW1heC16b29t>> maprule_blob.txt
ECHO IDogMjANCgkJCWRyYXcgOiB0ZXh0DQoJCWVsc2VpZiA6ICp0cmFjaw0KCQkJZGVm>> maprule_blob.txt
ECHO aW5lDQoJCQkJbWluLXpvb20gOiAxMi41DQoJCQkJbGluZS1jb2xvciA6ICM5RDc1>> maprule_blob.txt
ECHO MTcNCgkJCQlsaW5lLXdpZHRoIDogMTIuNTowLjM7MTM6MC41OzE1OjE7MTg6MS41>> maprule_blob.txt
ECHO DQoJCQkJbGluZS1zdHlsZSA6IGRhc2gNCgkJCQlib3JkZXItc3R5bGUgOiBzb2xp>> maprule_blob.txt
ECHO ZA0KCQkJCWJvcmRlci1jb2xvciA6IHdoaXRlDQoJCQkJYm9yZGVyLXdpZHRoIDog>> maprule_blob.txt
ECHO MTAwJQ0KCQkJCWJvcmRlci1vcGFjaXR5IDogMC4zDQoJCQlmb3IgOiB0cmFja3R5>> maprule_blob.txt
ECHO cGU9Z3JhZGUxDQoJCQkJZGVmaW5lDQoJCQkJCWxpbmUtc3R5bGUgOiBzb2xpZA0K>> maprule_blob.txt
ECHO CQkJCQlsaW5lLXdpZHRoIDogMTIuNTowLjU7MTM6MTsxNToxLjU7MTg6Mg0KCQkJ>> maprule_blob.txt
ECHO Zm9yIDogdHJhY2t0eXBlPWdyYWRlMg0KCQkJCWRlZmluZQ0KCQkJCQlsaW5lLXN0>> maprule_blob.txt
ECHO eWxlOiBkYXNobG9uZw0KCQkJZm9yIDogdHJhY2t0eXBlPWdyYWRlMw0KCQkJCWRl>> maprule_blob.txt
ECHO ZmluZQ0KCQkJCQlsaW5lLXN0eWxlOiBkYXNoDQoJCQlmb3IgOiB0cmFja3R5cGU9>> maprule_blob.txt
ECHO Z3JhZGU0DQoJCQkJZGVmaW5lDQoJCQkJCWxpbmUtc3R5bGU6IGRhc2hkb3QNCgkJ>> maprule_blob.txt
ECHO CWZvciA6IHRyYWNrdHlwZT1ncmFkZTUNCgkJCQlkZWZpbmUNCgkJCQkJbGluZS1z>> maprule_blob.txt
ECHO dHlsZTogZGFzaGRvdGRvdA0KCQkJZm9yIDogdHVubmVsPXllcw0KCQkJCWRlZmlu>> maprule_blob.txt
ECHO ZQ0KCQkJCQlib3JkZXItc3R5bGUgOiBkb3QNCgkJCWZvciA6IGJyaWRnZT15ZXMN>> maprule_blob.txt
ECHO CgkJCQlkZWZpbmUNCgkJCQkJYm9yZGVyLWNvbG9yIDogIzAwMA0KCQkJZHJhdyA6>> maprule_blob.txt
ECHO IGxpbmUNCgkJCWRyYXcgOiB0ZXh0DQoJCWVsc2VpZiA6ICpmb290d2F5DQoJCQlk>> maprule_blob.txt
ECHO ZWZpbmUNCgkJCQltaW4tem9vbSA6IDEzDQoJCQkJbGluZS1jb2xvciA6ICNGNjg0>> maprule_blob.txt
ECHO NzQNCgkJCQlsaW5lLXdpZHRoIDogMTM6MC41OzE1OjE7MTg6MS41DQoJCQkJbGlu>> maprule_blob.txt
ECHO ZS1zdHlsZSA6IGRvdA0KCQkJCWJvcmRlci1zdHlsZSA6IHNvbGlkDQoJCQkJYm9y>> maprule_blob.txt
ECHO ZGVyLWNvbG9yIDogd2hpdGUNCgkJCQlib3JkZXItd2lkdGggOiAxMDAlDQoJCQkJ>> maprule_blob.txt
ECHO Ym9yZGVyLW9wYWNpdHkgOiAwLjMNCgkJCWZvciA6IHR1bm5lbD15ZXMNCgkJCQlk>> maprule_blob.txt
ECHO ZWZpbmUNCgkJCQkJYm9yZGVyLXN0eWxlIDogZG90DQoJCQlmb3IgOiBicmlkZ2U9>> maprule_blob.txt
ECHO eWVzDQoJCQkJZGVmaW5lDQoJCQkJCWJvcmRlci1jb2xvciA6ICMwMDANCgkJCWRy>> maprule_blob.txt
ECHO YXcgOiBsaW5lDQoJCQlkcmF3IDogdGV4dA0KCQllbHNlaWYgOiAqY3ljbGV3YXkN>> maprule_blob.txt
ECHO CgkJCWRlZmluZQ0KCQkJCW1pbi16b29tIDogMTMNCgkJCQlsaW5lLWNvbG9yIDog>> maprule_blob.txt
ECHO Ymx1ZQ0KCQkJCWxpbmUtd2lkdGggOiAxMzowLjU7MTU6MTsxODoxLjUNCgkJCQls>> maprule_blob.txt
ECHO aW5lLXN0eWxlIDogZG90DQoJCQkJYm9yZGVyLXN0eWxlIDogc29saWQNCgkJCQli>> maprule_blob.txt
ECHO b3JkZXItY29sb3IgOiB3aGl0ZQ0KCQkJCWJvcmRlci13aWR0aCA6IDEwMCUNCgkJ>> maprule_blob.txt
ECHO CQlib3JkZXItb3BhY2l0eSA6IDAuMw0KCQkJZm9yIDogdHVubmVsPXllcw0KCQkJ>> maprule_blob.txt
ECHO CWRlZmluZQ0KCQkJCQlib3JkZXItc3R5bGUgOiBkb3QNCgkJCWZvciA6IGJyaWRn>> maprule_blob.txt
ECHO ZT15ZXMNCgkJCQlkZWZpbmUNCgkJCQkJYm9yZGVyLWNvbG9yIDogIzAwMA0KCQkJ>> maprule_blob.txt
ECHO CQlib3JkZXItb3BhY2l0eSA6IDENCgkJCWRyYXcgOiBsaW5lDQoJCQlkcmF3IDog>> maprule_blob.txt
ECHO dGV4dA0KCQllbHNlaWYgOiAqcGF0aA0KCQkJZGVmaW5lDQoJCQkJbWluLXpvb20g>> maprule_blob.txt
ECHO OiAxMw0KCQkJCWxpbmUtY29sb3IgOiAjNkU3QzZEDQoJCQkJbGluZS13aWR0aCA6>> maprule_blob.txt
ECHO IDEzOjAuNTsxNToxOzE4OjEuNQ0KCQkJCWxpbmUtc3R5bGUgOiBkYXNoDQoJCQkJ>> maprule_blob.txt
ECHO Ym9yZGVyLXN0eWxlIDogc29saWQNCgkJCQlib3JkZXItY29sb3IgOiB3aGl0ZQ0K>> maprule_blob.txt
ECHO CQkJCWJvcmRlci13aWR0aCA6IDEwMCUNCgkJCQlib3JkZXItb3BhY2l0eSA6IDAu>> maprule_blob.txt
ECHO Mw0KCQkJZm9yIDogdHVubmVsPXllcw0KCQkJCWRlZmluZQ0KCQkJCQlib3JkZXIt>> maprule_blob.txt
ECHO c3R5bGUgOiBkb3QNCgkJCWZvciA6IGJyaWRnZT15ZXMNCgkJCQlkZWZpbmUNCgkJ>> maprule_blob.txt
ECHO CQkJYm9yZGVyLWNvbG9yIDogIzAwMA0KCQkJZHJhdyA6IGxpbmUNCgkJCWRyYXcg>> maprule_blob.txt
ECHO OiB0ZXh0DQoJCWVsc2UNCgkJCXN0b3ANCg0KCXRhcmdldCA6IGhpZ2h3YXkgc3Rl>> maprule_blob.txt
ECHO cHMNCgkJZGVmaW5lDQoJCQltaW4tem9vbSA6IDE0DQoJCQlzaGFwZSA6IGN1c3Rv>> maprule_blob.txt
ECHO bQ0KCQkJc2hhcGUtZGVmIDogLTEsMSwgLTEsLTEsIDEsLTEsIDEsMTtaDQoJCQlz>> maprule_blob.txt
ECHO aGFwZS1zcGFjaW5nIDogMg0KCQkJc2hhcGUtc2l6ZSA6IDE2OjE7MjA6Mw0KCQkJ>> maprule_blob.txt
ECHO c2hhcGUtYXNwZWN0IDogMw0KCQkJZmlsbC1jb2xvciA6ICNGOTgwNzINCgkJCWxp>> maprule_blob.txt
ECHO bmUtc3R5bGUgOiBub25lDQoJCWRyYXcgOiBzaGFwZQ0KCXRhcmdldCA6IHBpZXIN>> maprule_blob.txt
ECHO CgkJZGVmaW5lDQoJCQlsaW5lLWNvbG9yIDogI0YxRUVFOA0KCQkJbGluZS13aWR0>> maprule_blob.txt
ECHO aCA6IDE6MTsyMDo4DQoJCWRyYXcgOiBsaW5lDQoNCgl0YXJnZXQgOiBsaW5lIGJh>> maprule_blob.txt
ECHO cnJpZXINCgkJZGVmaW5lDQoJCQltaW4tem9vbSA6IDEzDQoJCQlsaW5lLWNvbG9y>> maprule_blob.txt
ECHO IDogYmxhY2sNCgkJCWxpbmUtd2lkdGggOiAxDQoJCWZvcjpiYXJyaWVyPWZlbmNl>> maprule_blob.txt
ECHO DQoJCQlkZWZpbmUNCgkJCQltaW4tem9vbToxNg0KCQkJCWxpbmUtY29sb3I6Izc3>> maprule_blob.txt
ECHO Nw0KCQlkcmF3IDogbGluZQ0KDQoJdGFyZ2V0IDogYnJpZGdlIGZvb3QNCgkJZGVm>> maprule_blob.txt
ECHO aW5lDQoJCQltaW4tem9vbSA6IDEzDQoJCQlsaW5lLWNvbG9yIDogd2hpdGUNCgkJ>> maprule_blob.txt
ECHO CWxpbmUtd2lkdGggOiA3OjAuNjs5OjE7MTA6MS4yOzEyOjIuNTsxMzozOzE2OjU7>> maprule_blob.txt
ECHO MTg6Ng0KCQkJYm9yZGVyLXN0eWxlIDogc29saWQNCgkJCWJvcmRlci1jb2xvciA6>> maprule_blob.txt
ECHO ICNGRUZFQjIgYmxhY2sgMjAlDQoJCQlib3JkZXItd2lkdGggOiAxNSUNCgkJZHJh>> maprule_blob.txt
ECHO dyA6IGxpbmUNCgkJZHJhdyA6IHRleHQNCg0KCXRhcmdldCA6IGhpc3RvcmljIGNp>> maprule_blob.txt
ECHO dHl3YWxscw0KCQlkZWZpbmUNCgkJCW1pbi16b29tIDogMTMNCgkJCWxpbmUtY29s>> maprule_blob.txt
ECHO b3IgOiAjOEQ5NjhEDQoJCQlsaW5lLXdpZHRoIDogNzowLjY7OToxOzEwOjEuMjsx>> maprule_blob.txt
ECHO MjoyLjU7MTM6MzsxNjoxMA0KCQlkcmF3IDogbGluZQ0KCQlkcmF3IDogdGV4dA0K>> maprule_blob.txt
ECHO DQoJCWRlZmluZQ0KDQoJdGFyZ2V0IDogcml2ZXINCgkJZGVmaW5lDQoJCQlsaW5l>> maprule_blob.txt
ECHO LWNvbG9yIDogI0I1RDBEMA0KCQkJbGluZS13aWR0aCA6IDc6MTsxMjoyOzE0OjUN>> maprule_blob.txt
ECHO CgkJZHJhdyA6IGxpbmUNCgkJZGVmaW5lDQoJCQltaW4tem9vbToxMw0KCQkJZm9u>> maprule_blob.txt
ECHO dC1zaXplOjEzOjE7MTg6MTUNCgkJCXRleHQtY29sb3I6IzAwNjg4Qg0KCQkJZm9u>> maprule_blob.txt
ECHO dC13ZWlnaHQ6bm9ybWFsDQoJCWRyYXc6dGV4dA0KCXRhcmdldCA6IHN0cmVhbQ0K>> maprule_blob.txt
ECHO CQlkZWZpbmUNCgkJCWxpbmUtY29sb3IgOiAjQjVEMEQwDQoJCQlsaW5lLXdpZHRo>> maprule_blob.txt
ECHO IDogMTM6MTsxNToyDQoJCWRyYXcgOiBsaW5lDQoJCWRlZmluZQ0KCQkJbWluLXpv>> maprule_blob.txt
ECHO b206MTMNCgkJCWZvbnQtc2l6ZToxMzoxOzE4OjE1DQoJCQl0ZXh0LWNvbG9yOiMw>> maprule_blob.txt
ECHO MDY4OEINCgkJCWZvbnQtd2VpZ2h0Om5vcm1hbA0KCQlkcmF3OnRleHQNCg0KCXRh>> maprule_blob.txt
ECHO cmdldCA6IGNhbmFsDQoJCWRlZmluZQ0KCQkJbWluLXpvb20gOiAxMg0KCQkJbGlu>> maprule_blob.txt
ECHO ZS1jb2xvciA6ICNCNUQwRDANCgkJCWxpbmUtd2lkdGggOiAxMjoxOzE3OjgNCgkJ>> maprule_blob.txt
ECHO ZHJhdyA6IGxpbmUNCgkJZGVmaW5lDQoJCQltaW4tem9vbToxMw0KCQkJZm9udC1z>> maprule_blob.txt
ECHO aXplOjEzOjg7MTY6MTINCgkJCXRleHQtY29sb3I6I0I1RDBEMA0KCQkJZm9udC13>> maprule_blob.txt
ECHO ZWlnaHQ6bm9ybWFsDQoJCWRyYXc6dGV4dA0KDQoJdGFyZ2V0IDogZHJhaW4NCgkJ>> maprule_blob.txt
ECHO ZGVmaW5lDQoJCQltaW4tem9vbSA6IDEzDQoJCQlsaW5lLWNvbG9yIDogI0I1RDBE>> maprule_blob.txt
ECHO MA0KCQkJbGluZS13aWR0aCA6IDENCgkJZHJhdyA6IGxpbmUNCg0KCXRhcmdldDog>> maprule_blob.txt
ECHO cGFya2luZw0KCQlkZWZpbmUNCgkJCWljb24taW1hZ2UgOiBpY29ucy9TSkpCL3Bu>> maprule_blob.txt
ECHO Zy90cmFuc3BvcnRfcGFya2luZy5wLjMyLnBuZw0KCQkJbWluLXpvb20gOiAxNQ0K>> maprule_blob.txt
ECHO CQkJaWNvbi13aWR0aCA6IDE1OjY7MTg6MTYNCgkJZHJhdyA6IGljb24NCgl0YXJn>> maprule_blob.txt
ECHO ZXQ6IGJ1cyBzdG9wDQoJCWRlZmluZQ0KCQkJaWNvbi1pbWFnZSA6IGljb25zL1NK>> maprule_blob.txt
ECHO SkIvcG5nL3RyYW5zcG9ydF9idXNfc3RvcC5wLjMyLnBuZw0KCQkJbWluLXpvb20g>> maprule_blob.txt
ECHO OiAxNQ0KCQkJaWNvbi13aWR0aCA6IDE1OjY7MTg6MTYNCgkJZHJhdyA6IGljb24N>> maprule_blob.txt
ECHO Cgl0YXJnZXQ6IHJhaWx3YXkgc3RhdGlvbg0KCQlkZWZpbmUNCgkJCW1pbi16b29t>> maprule_blob.txt
ECHO IDogMTINCgkJCXNoYXBlIDogc3F1YXJlDQoJCQlsaW5lLWNvbG9yIDogIzc5ODFC>> maprule_blob.txt
ECHO MA0KCQkJZmlsbC1jb2xvciA6ICM3OTgxQjANCgkJCXNoYXBlLXNpemUgOiAxMjo1>> maprule_blob.txt
ECHO OzE4OjgNCgkJZHJhdyA6IHNoYXBlDQoJCWRlZmluZQ0KCQkJbWluLXpvb20gOiAx>> maprule_blob.txt
ECHO NA0KCQkJZm9udC1zaXplIDogMTINCgkJCXRleHQtY29sb3IgOiAjNzk4MUIwDQoJ>> maprule_blob.txt
ECHO CQl0ZXh0LW9mZnNldC12ZXJ0aWNhbCA6IC0xNTAlDQoJCWRyYXcgOiB0ZXh0DQoJ>> maprule_blob.txt
ECHO dGFyZ2V0OiBwb3N0Ym94DQoJCWRlZmluZQ0KCQkJaWNvbi1pbWFnZSA6IGljb25z>> maprule_blob.txt
ECHO L1NKSkIvcG5nL2FtZW5pdHlfcG9zdF9ib3gucC4zMi5wbmcNCgkJCW1pbi16b29t>> maprule_blob.txt
ECHO IDogMTYNCgkJCWljb24td2lkdGggOiAxNg0KCQlkcmF3IDogaWNvbg0KCXRhcmdl>> maprule_blob.txt
ECHO dDogcG9zdG9mZmljZQ0KCQlkZWZpbmUNCgkJCWljb24taW1hZ2UgOiBpY29ucy9T>> maprule_blob.txt
ECHO SkpCL3BuZy9hbWVuaXR5X3Bvc3Rfb2ZmaWNlLnAuMzIucG5nDQoJCQltaW4tem9v>> maprule_blob.txt
ECHO bSA6IDE0DQoJCQlpY29uLXdpZHRoIDogMTMNCgkJZHJhdyA6IGljb24NCgl0YXJn>> maprule_blob.txt
ECHO ZXQ6IHRlbGVwaG9uZQ0KCQlkZWZpbmUNCgkJCWljb24taW1hZ2UgOiBpY29ucy9T>> maprule_blob.txt
ECHO SkpCL3BuZy9hbWVuaXR5X3RlbGVwaG9uZS5wLjMyLnBuZw0KCQkJbWluLXpvb20g>> maprule_blob.txt
ECHO OiAxNg0KCQkJaWNvbi13aWR0aCA6IDE2DQoJCWRyYXcgOiBpY29uDQoNCgl0YXJn>> maprule_blob.txt
ECHO ZXQ6IGZpcmUgc3RhdGlvbg0KCQlkZWZpbmUNCgkJCWljb24taW1hZ2UgOiBpY29u>> maprule_blob.txt
ECHO cy9TSkpCL3BuZy9hbWVuaXR5X2ZpcmVzdGF0aW9uLnAuMzIucG5nDQoJCQltaW4t>> maprule_blob.txt
ECHO em9vbSA6IDE0DQoJCQlpY29uLXdpZHRoIDogMTMNCgkJZHJhdyA6IGljb24NCgl0>> maprule_blob.txt
ECHO YXJnZXQ6IGhvc3BpdGFsDQoJCWRlZmluZQ0KCQkJaWNvbi1pbWFnZSA6IGljb25z>> maprule_blob.txt
ECHO L1NKSkIvcG5nL2hlYWx0aF9ob3NwaXRhbC5wLjMyLnBuZw0KCQkJbWluLXpvb20g>> maprule_blob.txt
ECHO OiAxNA0KCQkJaWNvbi13aWR0aCA6IDEzDQoJCWRyYXcgOiBpY29uDQoJCWRlZmlu>> maprule_blob.txt
ECHO ZQ0KCQkJbWluLXpvb20gOiAxNA0KCQkJZm9udC1zaXplIDogMTQ6NTsxODoxMA0K>> maprule_blob.txt
ECHO CQkJdGV4dC1vZmZzZXQtdmVydGljYWwgOiAxNTAlDQoJCQl0ZXh0LWNvbG9yIDog>> maprule_blob.txt
ECHO I0RBMDA5Mg0KCQlkcmF3IDogdGV4dA0KCXRhcmdldDogcG9saWNlIHN0YXRpb24N>> maprule_blob.txt
ECHO CgkJZGVmaW5lDQoJCQlpY29uLWltYWdlIDogaWNvbnMvU0pKQi9wbmcvYW1lbml0>> maprule_blob.txt
ECHO eV9wb2xpY2UucC4zMi5wbmcNCgkJCW1pbi16b29tIDogMTQNCgkJCWljb24td2lk>> maprule_blob.txt
ECHO dGggOiAxMw0KCQlkcmF3IDogaWNvbg0KCXRhcmdldDogY2FmZQ0KCQlkZWZpbmUN>> maprule_blob.txt
ECHO CgkJCWljb24taW1hZ2UgOiBpY29ucy9TSkpCL3BuZy9mb29kX2NhZmUucC4zMi5w>> maprule_blob.txt
ECHO bmcNCgkJCW1pbi16b29tIDogMTYNCgkJCWljb24td2lkdGggOiAxNg0KCQlkcmF3>> maprule_blob.txt
ECHO IDogaWNvbg0KCXRhcmdldDogcmVjeWNsaW5nDQoJCWRlZmluZQ0KCQkJaWNvbi1p>> maprule_blob.txt
ECHO bWFnZSA6IGljb25zL1NKSkIvcG5nL2FtZW5pdHlfcmVjeWNsaW5nLnAuMzIucG5n>> maprule_blob.txt
ECHO DQoJCQltaW4tem9vbSA6IDE2DQoJCQlpY29uLXdpZHRoIDogMTYNCgkJZHJhdyA6>> maprule_blob.txt
ECHO IGljb24NCgl0YXJnZXQ6IHN1cGVybWFya2V0DQoJCWRlZmluZQ0KCQkJaWNvbi1p>> maprule_blob.txt
ECHO bWFnZSA6IGljb25zL1NKSkIvcG5nL3Nob3BwaW5nX3N1cGVybWFya2V0LnAuMzIu>> maprule_blob.txt
ECHO cG5nDQoJCQltaW4tem9vbSA6IDE2DQoJCQlpY29uLXdpZHRoIDogMTYNCgkJZHJh>> maprule_blob.txt
ECHO dyA6IGljb24NCgl0YXJnZXQ6IGRpeQ0KCQlkZWZpbmUNCgkJCWljb24taW1hZ2Ug>> maprule_blob.txt
ECHO OiBpY29ucy9TSkpCL3BuZy9zaG9wcGluZ19kaXkucC4zMi5wbmcNCgkJCW1pbi16>> maprule_blob.txt
ECHO b29tIDogMTYNCgkJCWljb24td2lkdGggOiAxNg0KCQlkcmF3IDogaWNvbg0KCXRh>> maprule_blob.txt
ECHO cmdldDogY29udmVuaWVuY2UNCgkJZGVmaW5lDQoJCQlpY29uLWltYWdlIDogaWNv>> maprule_blob.txt
ECHO bnMvU0pKQi9wbmcvc2hvcHBpbmdfY29udmVuaWVuY2UucC4zMi5wbmcNCgkJCW1p>> maprule_blob.txt
ECHO bi16b29tIDogMTYNCgkJCWljb24td2lkdGggOiAxNg0KCQlkcmF3IDogaWNvbg0K>> maprule_blob.txt
ECHO DQoJdGFyZ2V0OiBtaW5pIHJvdW5kYWJvdXQNCgkJZGVmaW5lDQoJCQlpY29uLWlt>> maprule_blob.txt
ECHO YWdlIDogaWNvbnMvU0pKQi9wbmcvdHJhbnNwb3J0X3JvdW5kYWJvdXRfYW50aWNs>> maprule_blob.txt
ECHO b2Nrd2lzZS5wLjMyLnBuZw0KCQkJbWluLXpvb20gOiAxNg0KCQkJaWNvbi13aWR0>> maprule_blob.txt
ECHO aCA6IDkNCgkJZHJhdyA6IGljb24NCgl0YXJnZXQ6IGNodXJjaA0KCQlkZWZpbmUN>> maprule_blob.txt
ECHO CgkJCWljb24taW1hZ2UgOiBpY29ucy9TSkpCL3BuZy9wbGFjZV9vZl93b3JzaGlw>> maprule_blob.txt
ECHO X2NocmlzdGlhbjMucC4zMi5wbmcNCgkJCW1pbi16b29tIDogMTYuMg0KCQkJaWNv>> maprule_blob.txt
ECHO bi13aWR0aCA6IDEyDQoJCWRlZmluZQ0KCQkJdGV4dC1vZmZzZXQtdmVydGljYWwg>> maprule_blob.txt
ECHO OiA3MCUNCgkJZHJhdyA6IHRleHQNCgkJZHJhdyA6IGljb24NCgl0YXJnZXQ6IGRy>> maprule_blob.txt
ECHO aW5raW5nIHdhdGVyDQoJCWRlZmluZQ0KCQkJaWNvbi1pbWFnZSA6IGljb25zL1NK>> maprule_blob.txt
ECHO SkIvcG5nL2Zvb2RfZHJpbmtpbmd0YXAucC4zMi5wbmcNCgkJCW1pbi16b29tIDog>> maprule_blob.txt
ECHO MTYNCgkJCWljb24td2lkdGggOiAxNg0KCQlkcmF3IDogaWNvbg0KCXRhcmdldDog>> maprule_blob.txt
ECHO YmFuaw0KCQlkZWZpbmUNCgkJCW1pbi16b29tIDogMTcNCgkJCXRleHQtY29sb3Ig>> maprule_blob.txt
ECHO OiAjMDAwMDAwDQoJCQl0ZXh0LW9mZnNldC12ZXJ0aWNhbCA6IDE1MCUNCgkJZHJh>> maprule_blob.txt
ECHO dyA6IHRleHQNCgkJZGVmaW5lDQoJCQlpY29uLWltYWdlIDogaWNvbnMvU0pKQi9w>> maprule_blob.txt
ECHO bmcvbW9uZXlfYmFuazIucC4zMi5wbmcNCgkJCW1pbi16b29tIDogMTYNCgkJCWlj>> maprule_blob.txt
ECHO b24td2lkdGggOiAxNg0KCQlkcmF3IDogaWNvbg0KCXRhcmdldDogYXRtDQoJCWRl>> maprule_blob.txt
ECHO ZmluZQ0KCQkJbWluLXpvb20gOiAxNw0KCQkJdGV4dC1jb2xvciA6ICMwMDAwMDAN>> maprule_blob.txt
ECHO CgkJCXRleHQtb2Zmc2V0LXZlcnRpY2FsIDogMTUwJQ0KCQlkcmF3IDogdGV4dA0K>> maprule_blob.txt
ECHO CQlkZWZpbmUNCgkJCWljb24taW1hZ2UgOiBpY29ucy9TSkpCL3BuZy9tb25leV9h>> maprule_blob.txt
ECHO dG0yLnAuMzIucG5nDQoJCQltaW4tem9vbSA6IDE2DQoJCQlpY29uLXdpZHRoIDog>> maprule_blob.txt
ECHO MTYNCgkJZHJhdyA6IGljb24NCgl0YXJnZXQ6IHJlc3RhdXJhbnQNCgkJZGVmaW5l>> maprule_blob.txt
ECHO DQoJCQltaW4tem9vbSA6IDE3DQoJCQl0ZXh0LWNvbG9yIDogIzczNGEwOA0KCQkJ>> maprule_blob.txt
ECHO dGV4dC1vZmZzZXQtdmVydGljYWwgOiAxNTAlDQoJCQlmb250LXNpemUgOiAxMA0K>> maprule_blob.txt
ECHO CQlkcmF3IDogdGV4dA0KCQlkZWZpbmUNCgkJCWljb24taW1hZ2UgOiBpY29ucy9T>> maprule_blob.txt
ECHO SkpCL3BuZy9mb29kX3Jlc3RhdXJhbnQucC4zMi5wbmcNCgkJCW1pbi16b29tIDog>> maprule_blob.txt
ECHO MTYNCgkJCWljb24td2lkdGggOiAxNg0KCQlkcmF3IDogaWNvbg0KCXRhcmdldDog>> maprule_blob.txt
ECHO aGFpciBkcmVzc2VyDQoJCWRlZmluZQ0KCQkJaWNvbi1pbWFnZSA6IGljb25zL1NK>> maprule_blob.txt
ECHO SkIvcG5nL3Nob3BwaW5nX2hhaXJkcmVzc2VyLnAuMzIucG5nDQoJCQltaW4tem9v>> maprule_blob.txt
ECHO bSA6IDE2DQoJCQlpY29uLXdpZHRoIDogMTYNCgkJZHJhdyA6IGljb24NCg0KCXRh>> maprule_blob.txt
ECHO cmdldDogdG9pbGV0cw0KCQlkZWZpbmUNCgkJCWljb24taW1hZ2UgOiBpY29ucy9T>> maprule_blob.txt
ECHO SkpCL3BuZy9hbWVuaXR5X3RvaWxldHMucC4zMi5wbmcNCgkJCW1pbi16b29tIDog>> maprule_blob.txt
ECHO MTYNCgkJCWljb24td2lkdGggOiAxNg0KCQlkcmF3IDogaWNvbg0KCXRhcmdldDog>> maprule_blob.txt
ECHO cGhhcm1hY3kNCgkJZGVmaW5lDQoJCQlpY29uLWltYWdlIDogaWNvbnMvU0pKQi9w>> maprule_blob.txt
ECHO bmcvaGVhbHRoX3BoYXJtYWN5LnAuMzIucG5nDQoJCQltaW4tem9vbSA6IDE2DQoJ>> maprule_blob.txt
ECHO CQlpY29uLXdpZHRoIDogMTYNCgkJZHJhdyA6IGljb24NCgl0YXJnZXQ6IGxpYnJh>> maprule_blob.txt
ECHO cnkNCgkJZGVmaW5lDQoJCQlpY29uLWltYWdlIDogaWNvbnMvU0pKQi9wbmcvYW1l>> maprule_blob.txt
ECHO bml0eV9saWJyYXJ5LnAuMzIucG5nDQoJCQltaW4tem9vbSA6IDE2DQoJCQlpY29u>> maprule_blob.txt
ECHO LXdpZHRoIDogMTYNCgkJZHJhdyA6IGljb24NCgl0YXJnZXQ6IGJha2VyeQ0KCQlk>> maprule_blob.txt
ECHO ZWZpbmUNCgkJCW1pbi16b29tIDogMTcNCgkJCXRleHQtY29sb3IgOiAjMkI4MEZF>> maprule_blob.txt
ECHO DQoJCQl0ZXh0LW9mZnNldC12ZXJ0aWNhbCA6IDE1MCUNCgkJZHJhdyA6IHRleHQN>> maprule_blob.txt
ECHO CgkJZGVmaW5lDQoJCQlpY29uLWltYWdlIDogaWNvbnMvU0pKQi9wbmcvc2hvcHBp>> maprule_blob.txt
ECHO bmdfYmFrZXJ5LnAuMzIucG5nDQoJCQltaW4tem9vbSA6IDE2DQoJCQlpY29uLXdp>> maprule_blob.txt
ECHO ZHRoIDogMTYNCgkJZHJhdyA6IGljb24NCgkJZGVmaW5lDQoJCQltaW4tem9vbSA6>> maprule_blob.txt
ECHO IDE3DQoJCQl0ZXh0LWNvbG9yIDogI0FBMzNBQQ0KCQkJdGV4dC1vZmZzZXQtdmVy>> maprule_blob.txt
ECHO dGljYWwgOiAxNTAlDQoJCQlmb250LXNpemUgOiAxMA0KCQlkcmF3IDogdGV4dA0K>> maprule_blob.txt
ECHO CXRhcmdldDogdHJlZQ0KCQlkZWZpbmUNCgkJCWljb24taW1hZ2UgOiBodHRwOi8v>> maprule_blob.txt
ECHO c3ZuLm9wZW5zdHJlZXRtYXAub3JnL2FwcGxpY2F0aW9ucy9yZW5kZXJpbmcvbWFw>> maprule_blob.txt
ECHO bmlrL3N5bWJvbHMvdHJlZTIucG5nDQoJCQltaW4tem9vbSA6IDE2DQoJCQlpY29u>> maprule_blob.txt
ECHO LXdpZHRoIDogNg0KCQlkcmF3IDogaWNvbg0KCXRhcmdldDogbWVtb3JpYWwNCgkJ>> maprule_blob.txt
ECHO ZGVmaW5lDQoJCQlpY29uLWltYWdlIDogaWNvbnMvU0pKQi9wbmcvdG91cmlzdF9t>> maprule_blob.txt
ECHO ZW1vcmlhbC5wLjMyLnBuZw0KCQkJbWluLXpvb20gOiAxNg0KCQkJaWNvbi13aWR0>> maprule_blob.txt
ECHO aCA6IDE2DQoJCWRyYXcgOiBpY29uDQoJdGFyZ2V0OiBzY2hvb2wNCgkJZGVmaW5l>> maprule_blob.txt
ECHO DQoJCQlpY29uLWltYWdlIDogaWNvbnMvU0pKQi9wbmcvZWR1Y2F0aW9uX3NjaG9v>> maprule_blob.txt
ECHO bC5wLjMyLnBuZw0KCQkJbWluLXpvb20gOiAxNg0KCQkJaWNvbi13aWR0aCA6IDE2>> maprule_blob.txt
ECHO DQoJCWRyYXcgOiBpY29uDQoJCWRlZmluZQ0KCQkJdGV4dC1vZmZzZXQtdmVydGlj>> maprule_blob.txt
ECHO YWwgOiAxNTAlDQoJCWRyYXcgOiB0ZXh0DQoJdGFyZ2V0IDogcHVmZmluDQoJCWRl>> maprule_blob.txt
ECHO ZmluZQ0KCQkJaWNvbi1pbWFnZSA6IGljb25zL1NKSkIvcG5nL3RyYW5zcG9ydF90>> maprule_blob.txt
ECHO cmFmZmljX2xpZ2h0cy5wLjMyLnBuZw0KCQkJbWluLXpvb20gOiAxNg0KCQkJaWNv>> maprule_blob.txt
ECHO bi13aWR0aCA6IDE2DQoJCWRyYXcgOiBpY29uDQoNCgl0YXJnZXQgOiBnYXRlDQoJ>> maprule_blob.txt
ECHO CWRlZmluZQ0KCQkJaWNvbi1pbWFnZSA6IGljb25zL1NKSkIvcG5nL2JhcnJpZXJf>> maprule_blob.txt
ECHO Z2F0ZS5wLjMyLnBuZw0KCQkJbWluLXpvb20gOiAxNg0KCQkJaWNvbi13aWR0aCA6>> maprule_blob.txt
ECHO IDcNCgkJZHJhdyA6IGljb24NCg0KCXRhcmdldCA6IHRvdXJpc20qDQoJCWRlZmlu>> maprule_blob.txt
ECHO ZQ0KCQkJbWluLXpvb20gOiAxNw0KCQkJdGV4dC1jb2xvciA6ICMyQjgwRkUNCgkJ>> maprule_blob.txt
ECHO CXRleHQtb2Zmc2V0LXZlcnRpY2FsIDogMTUwJQ0KCQlkcmF3IDogdGV4dA0KCQlp>> maprule_blob.txt
ECHO ZiA6ICpob3RlbA0KCQkJZGVmaW5lDQoJCQkJaWNvbi1pbWFnZSA6IGljb25zL1NK>> maprule_blob.txt
ECHO SkIvcG5nL2FjY29tbW9kYXRpb25faG90ZWwyLnAuMzIucG5nDQoJCQkJbWluLXpv>> maprule_blob.txt
ECHO b20gOiAxNg0KCQkJCWljb24td2lkdGggOiAxNg0KDQoJCWVsc2VpZiA6ICp2aWV3>> maprule_blob.txt
ECHO cG9pbnQNCgkJCWRlZmluZQ0KCQkJCWljb24taW1hZ2UgOiBpY29ucy9TSkpCL3Bu>> maprule_blob.txt
ECHO Zy90b3VyaXN0X3ZpZXdfcG9pbnQucC4zMi5wbmcNCgkJCQltaW4tem9vbSA6IDE2>> maprule_blob.txt
ECHO DQoJCQkJaWNvbi13aWR0aCA6IDE2DQoNCgkJZWxzZWlmIDogKm11c2V1bQ0KCQkJ>> maprule_blob.txt
ECHO ZGVmaW5lDQoJCQkJaWNvbi1pbWFnZSA6IGljb25zL1NKSkIvcG5nL3RvdXJpc3Rf>> maprule_blob.txt
ECHO bXVzZXVtLnAuMzIucG5nDQoJCQkJbWluLXpvb20gOiAxNg0KCQkJCWljb24td2lk>> maprule_blob.txt
ECHO dGggOiAxNg0KCQllbHNlDQoJCQlzdG9wDQoJCWRyYXcgOiBpY29uDQoNCgl0YXJn>> maprule_blob.txt
ECHO ZXQgOiBhbWVuaXR5Kg0KCQlkZWZpbmUNCgkJCW1pbi16b29tIDogMTcNCgkJCXRl>> maprule_blob.txt
ECHO eHQtY29sb3IgOiAjODU2OTUxDQoJCQl0ZXh0LW9mZnNldC12ZXJ0aWNhbCA6IDE1>> maprule_blob.txt
ECHO MCUNCgkJZHJhdyA6IHRleHQNCg0KCQlkZWZpbmUNCgkJCW1pbi16b29tIDogMTYN>> maprule_blob.txt
ECHO CgkJCWljb24td2lkdGggOiAxNg0KCQlpZiA6ICpwdWINCgkJCWRlZmluZQ0KCQkJ>> maprule_blob.txt
ECHO CWljb24taW1hZ2UgOiBpY29ucy9TSkpCL3BuZy9mb29kX3B1Yi5wLjMyLnBuZw0K>> maprule_blob.txt
ECHO CQllbHNlaWYgOiAqZmFzdF9mb29kDQoJCQlkZWZpbmUNCgkJCQlpY29uLWltYWdl>> maprule_blob.txt
ECHO IDogaWNvbnMvU0pKQi9wbmcvZm9vZF9mYXN0Zm9vZDIucC4zMi5wbmcNCgkJZWxz>> maprule_blob.txt
ECHO ZQ0KCQkJc3RvcA0KCQlkcmF3IDogaWNvbg0KDQoNCgl0YXJnZXQ6IGNvbnRvdXIq>> maprule_blob.txt
ECHO DQoJCWRlZmluZQ0KCQkJbGluZS1jb2xvciA6ICM3ZjMzMDANCgkJCWxpbmUtb3Bh>> maprule_blob.txt
ECHO Y2l0eSA6IDAuMzUNCgkJCWN1cnZlZCA6IHRydWUNCgkJaWYgOiAqbWFqb3INCgkJ>> maprule_blob.txt
ECHO CWRlZmluZQ0KCQkJCW1hcC5yZW5kZXJpbmcuY29udG91ci5sYWJlbCA6IHRydWUN>> maprule_blob.txt
ECHO CgkJCQltaW4tem9vbSA6IDkNCgkJCQlsaW5lLXdpZHRoIDogMTE6MC4xOzExLjk6>> maprule_blob.txt
ECHO MTsxMjoyDQoJCQkJZm9udC1zaXplIDogMTANCgkJCQlmb250LXN0eWxlIDogaXRh>> maprule_blob.txt
ECHO bGljDQoJCQkJZm9udC13ZWlnaHQgOiBub3JtYWwNCgkJCQl0ZXh0LWhhbG8td2lk>> maprule_blob.txt
ECHO dGggOiAzNSUNCgkJCQl0ZXh0LWhhbG8tb3BhY2l0eSA6IDENCgkJCQl0ZXh0LWhh>> maprule_blob.txt
ECHO bG8tY29sb3IgOiAjRjFFRUU4DQoJCWVsc2UNCgkJCWRlZmluZQ0KCQkJCW1pbi16>> maprule_blob.txt
ECHO b29tIDogMTINCgkJCQlsaW5lLXdpZHRoIDogMQ0KCQlkcmF3IDogY29udG91cg0K>> maprule_blob.txt
ECHO DQoJdGFyZ2V0OiBjb2FzdGxpbmUNCgkJZGVmaW5lDQoJCQlsaW5lLWNvbG9yIDog>> maprule_blob.txt
ECHO I0I1RDBEMA0KCQkJbGluZS13aWR0aCA6IDINCgkJZHJhdyA6IGxpbmU=>> maprule_blob.txt
ECHO -----END CERTIFICATE----->> maprule_blob.txt
SET MAPRULE_OUTPUT=%2
IF [%2]==[] SET MAPRULE_OUTPUT=%STD_RULE_FILE%
certutil -decode maprule_blob.txt %MAPRULE_OUTPUT% >nul
DEL maprule_blob.txt
ECHO MAPRULE-File exported to %MAPRULE_OUTPUT%.
IF DEFINED BUILDING GOTO BUILD_STEP_2
GOTO DONE


:MAPRULE_IMPORT
IF NOT EXIST %2 GOTO MAPRULE_IMPORT_ERROR
SET MAPRULE_INPUT=%2

REM Kopiere BATCH-Datei ohne enkodiertes maprule_blob
SET EXCLUDE_STR="maprule_blob.txt"
TYPE %SELFNAME% | findstr /v /c:">> %EXCLUDE_STR%" > %SELFNAME%.cpy

REM Erstelle blob aus svg -> tmp2.bin
certutil -encode -f %MAPRULE_INPUT% tmp.bin
FOR /f "delims=" %%a in (tmp.bin) do >> tmp2.bin (ECHO(ECHO %%a^>^> %EXCLUDE_STR:"=%)
DEL tmp.bin

REM Füge blob (tmp2.bin) an entsprechender Stelle in kopiertes Batch ein
REM https://stackoverflow.com/questions/155932/how-do-you-loop-through-each-line-in-a-text-file-using-a-windows-batch-file
SET NEWFILE=%SELF%_%DATE:~6,6%%DATE:~3,2%%DATE:~0,2%_%time:~0,2%-%time:~3,2%-%time:~6,2%.bat
SETLOCAL DisableDelayedExpansion
FOR /F "usebackq delims=" %%a in (`"findstr /n ^^ %SELFNAME%.cpy"`) do (
    SET "var=%%a"
	SETLOCAL EnableDelayedExpansion
	SET "var=!var:*:=!"
	ECHO(!var!>> %NEWFILE%
	IF "!var!" == ":MAPRULE_EXPORT" (
        TYPE tmp2.bin >> %NEWFILE%
	)
	ENDLOCAL
)
DEL %SELFNAME%.cpy
DEL tmp2.bin
GOTO DONE


:MAPRULE_IMPORT_ERROR
ECHO File does not exist: %2
GOTO DONE


:: ****************************************************************************
:: ****************************************************************************
:: ****************************************************************************
:NORTH_IMG_EXPORT
ECHO -----BEGIN CERTIFICATE----->> north_blob.txt
ECHO iVBORw0KGgoAAAANSUhEUgAAANUAAADYCAQAAADW127WAAAACXBIWXMAAAsTAAAL>> north_blob.txt
ECHO EwEAmpwYAAAAAmJLR0QA/4ePzL8AABKdSURBVHja7Z15gBTFFYffzHT3dM8uh3KD>> north_blob.txt
ECHO IChRBAKeKIi3RDERI8ql4gnhVDABIgpBlGAEPIIaBQ9WNHgR5AYRVETjgQIRBUHi>> north_blob.txt
ECHO AQiBhQUW2Ll25qWm1WVnd44+qqp7ZuvHnzLY9b75uqaru14D5GPqgkhuxDsHOosq>> north_blob.txt
ECHO 5EJaA8rbRBlyINqcs8t9MegkKuF6p3zR2SihtkaUwu1O/fOGyFsI6I3B2aIabs7J>> north_blob.txt
ECHO vugWXEJQEa/eE+Vws1Mv9Q0jLiCodK/OFBVxa07yRb9GxH/pqIhXq0RJ3OrU7D7E>> north_blob.txt
ECHO KcTXdFS6Vx1FVdyYVr7yzQlSOOdnVDIG3hZlcWHUot66U4izf0ZFvIpDB1EZt6Wl>> north_blob.txt
ECHO L7rpJ1L4QgUqGdVlojQuS6Co189OIc6sQKV71U5Ux0058ZhTiP+ohIrMV4tFedw0>> north_blob.txt
ECHO T71wfYVTiNMrodK9aisq5Ja08EW/OkYKH0tCpWBgoSiRW5x6rmclpxCnJqEC9MSh>> north_blob.txt
ECHO jaiSS5zaWJkUPlQFlYLaPFEmNzj17LVJTiE+WAWVvm5xiqiU02le1SnECdVQEa/m>> north_blob.txt
ECHO ilI57dTMa0JVSOF91VDpXrUW1XIyJ0jRL6qSwntSoCJevSrK5aRTM3pUcwpxVApU>> north_blob.txt
ECHO ulcniYo5lWZS9D/VSeHIlKj8qP5TlMwpp565OoVTiMNTotK9aimq5kSaStENqUjh>> north_blob.txt
ECHO 4DSoiFezRdkciP+p36V0CnFAGlS6Vy1E5Rxwan1qUnhrWlT+uDpLlI63U09elcYp>> north_blob.txt
ECHO xP5pUeleNRfV45kmUmRdOlLYLwMq4tXzonw8nXqie1qnEHtlQKV71UxUkFcaS5HP>> north_blob.txt
ECHO 05PCazOiUuP+GaKEvJyafmUGpxCvzohK96qpqCInpz7LRAq7Z0FFvPqHKCMPp/5+>> north_blob.txt
ECHO RUanEH+TBRXxqhwai0qyTiMpvDYzKbw0Kyri1ZOilKyderxbMAspvDArKuJVFBqJ>> north_blob.txt
ECHO arJMQyn8aTZS2MUAKjUuPybKydKpRy/P6hRiJwOoAH1RaCAqytCpT7KTwjMNoSJe>> north_blob.txt
ECHO PSJKyijytMsMOIXY0RAqfb6qL6rKIg3k8MdGSGE7g6jUuDJFlJVBlKmXGHIK8VSD>> north_blob.txt
ECHO qMh8FYHjRWVpp74U+rcxUniyYVRqXJosSkvbqSkXG3QK8UTDqIhXYThOVJeqU3Lo>> north_blob.txt
ECHO Q6OksJkJVMSrSaK8NJ16+CLDTiE2NoEKUAqLpnT0Uk8OfWCcFNY3hYp4NVGUmJZT>> north_blob.txt
ECHO D11owinEuqZQEa9CUEdUmUaOl4NrzJDCQpOoiFcTRJlpODX5AlNOIaomUele1RKV>> north_blob.txt
ECHO puDU++ZIoWQalRqTxolS24w0qatJpxA9plEBykEoFNW2k+PkstUmQcUsgEp45R0r>> north_blob.txt
ECHO ym3HqQfPN+1U2BIq4lUZFIiKW01dpew9s6TwqEVUxKsxouRWnXqgs2mnEA9ZREW8>> north_blob.txt
ECHO OgoBUXWLTr1rnhTut4yKePUnUXYrTt1/bpkFUrjHMiri1RHQROXNpo5y9B0rpHCX>> north_blob.txt
ECHO DVTEq5Gi9GadmnBuMG4J1XYbqACVw6CK6pt0ahVay7e2UBGv7hLlN+PUX84pi1tE>> north_blob.txt
ECHO tdUWKuJVqfDKeGorR95Gq9lkExXxaphAYNSp8Wdbdgpxo01UxKuD4BcUjDl1eAVa>> north_blob.txt
ECHO zwbbqIhXQwQGI06NO8uGU4jrbKMiXh0ARZDIllrK4bfQTtZSQOWP+f4gUGRz6t4z>> north_blob.txt
ECHO bTmF+AkFVOQkWAKyoJEphf7Dy9Fe/k0FFfFqgMCRyamxp9t0CvEDKqiIV/uFVxmd>> north_blob.txt
ECHO WoZ2s5oSKn8MbhVI0jl1T0fbTiG+SwkV8aoYJEEltVOlS9F+VlJDRby6WWBJEe+Y>> north_blob.txt
ECHO DhScQlxBDRXxao/wqnoK/IcWI40sp4hKicFNAk1Vp0b/mopTqL9qlqJXu8En6CQ7>> north_blob.txt
ECHO dXAR0skiqqiIV/0EnspOjWpPySnE+VRREa92Ca+OJeA/uBBpZR5lVMSrPgLRL079>> north_blob.txt
ECHO sR01pxDfoIyKeLUTvILST04dWID08hp1VMSr6wWmhFN3n0bRqWMvcKb3x4PqduEV>> north_blob.txt
ECHO gKYdmI808zJ1VIByDHoKp0a2oeoU4osMUBGvvgdPTXeq5E2km1kMUOleXVOznRpx>> north_blob.txt
ECHO KmWnEJ9jgop49W1N9krVSuYh7cxkgkr36uqa69Rdp5TFqKN6hhEqD2rf1FSvVG3/>> north_blob.txt
ECHO XKSfpxih0r26qmY6NfxXDJxCfIIZKuLVlprolV/b9wayyOPMUOleXVnznBrWmolT>> north_blob.txt
ECHO iI8yROVFbXNN88qvFb+ObDKVISpAKQbdapZTQ09m5BTiw0xReTHwZU3yyq/tfQ1Z>> north_blob.txt
ECHO ZTJTVLpXl9Ucp4acxMwpxEmMURGvvqgpXina3leRXSYyRgXoi8HFNcOpwa3Kyhmi>> north_blob.txt
ECHO msAcFfFqfc1was8ryDLjmKPSvbow70n5/tCSqVOI93JARbz6PO+dCuyZg2xzDwdU>> north_blob.txt
ECHO uldd89upgaydQhzNBxUGPs1nUnLgfy8j6/yJCyrdq87569SAFsydQhzJCxVqH+Wx>> north_blob.txt
ECHO Uy8h+9zFCZXu1bn56dQdLcqiHFAN44ZKQm1Nfjq1azbyyBBuqHSvzsk/p25vzsUp>> north_blob.txt
ECHO xEEcURGvVucbKSnw44uIeYeKXAzH4Kz8cuq2Ezg5hTiYKyri1Tt55lQR8soQrqh0>> north_blob.txt
ECHO r07PH1Q3N+PmFH9UMmor88epnbOQX4ZyRqV71SE/UPVvytEpJ1DJGHgrP5za8Tzy>> north_blob.txt
ECHO zDDuqIhXcWif+6huahqM5D0q4tXSnP+VHtj+HPLNcAdQ6V61zW1UNzbh7JRTqIhX>> north_blob.txt
ECHO C3PbqR+eRd650xFUuldtchfVDU2C4RqDSkHtzdx16vuZyD93OYRKv746JTdR9W3k>> north_blob.txt
ECHO gFOIIxxDRbyam5tOfTcDnchox1DpXrXOPVR9nHGKx4PQGb16PddAeQu+ewadySMO>> north_blob.txt
ECHO otK9Ojm3UPVu6JBTiDMcRUW8eiWnnAr892l0Ki87ikr3qlXuoOrVIBhyCNRWrB3z>> north_blob.txt
ECHO OIrKj+pLuePUtqccArUcA2Hfx/Jh2WmvTswNVNfXd8SpOE6LyxHfbeQImqgb/XEH>> north_blob.txt
ECHO vYqrL+aEU4XbnnQAVBn2i6j7K552VdRZUsxRr5q7H1XP+sEgd1A7sH0wsAGaJl2D>> north_blob.txt
ECHO 3+4r9zjn1Qvud+qbJ7iD+gDrhtSXU7wi9hzlkOycVye4G9W19bg79SzKUe+INHve>> north_blob.txt
ECHO G2rrnZm1/HH/THc7tXU6V0wRHBJVDmfsIyH7ZzgzaxGvmroX1e/rhXg6tRc7B7Vv>> north_blob.txt
ECHO 4KSsK8f9feVe7qjUuP9pt4LyFG75O0dQ67FxMLAYCg0d2xlKicLfq3Jo4k5U1xwX>> north_blob.txt
ECHO KuMG6nVUIsr9Jrqf19fWKjHuXj3lTqe+fpwTphiOjclB0x2aJf90X4y7V43ch6oH>> north_blob.txt
ECHO L6cO4hUhbSe0s3S/s58v6uXr1XT3ObX5MS6gtmCrYMH7cLzlI+3gL1Y4/nz3RqGh>> north_blob.txt
ECHO u1BdXZeLU8swEPY/bvP9h8drH/GbtdS4/Ki7nNr0CIfl2CmJ5Vga7xT1ydP4zVrE>> north_blob.txt
ECHO q/ruQfXbOqGjzJdje4fVYoqbpHv6Il5OXilT3ePUV9MYg9qO7YKBddCY6nG39e/h>> north_blob.txt
ECHO M2v5olDPHaiuqhM6whTUGqwTUl8EP/Ujr6uu5jFrqXHpIXc49eVUxo+1yBHvcEYt>> north_blob.txt
ECHO SL3KZB6zli9i4zcrtXSvzdCpMA6KKqWM24/28EV87L2a5LxTX0xhBmoPnhfUtkBL>> north_blob.txt
ECHO 5qM41b+L9awlhaGus6iurMXMqXXYKBhYAAVcxlFbXcl21iJePeCsU/95mBGoVxPL>> north_blob.txt
ECHO seM5Nsn2Kvd7mcKSQlDHOVRX1AodZoCpHMeUy2UOvNiruxT2sfRqgnNObfhbnD6o>> north_blob.txt
ECHO g9gtpG2H0xwZU2t1B7tZi3hV2xlU3WqF6Tv1NbYMFrwHxzl2pihUl8mMToRqTBrv>> north_blob.txt
ECHO jFPrJ1N3aglqYf+j4HP2V600ltWsJQWhFv8BXV4YLqW8HPu3uBz23eiKFZhuUlBi>> north_blob.txt
ECHO 49V9/J1a91eqTh3F68NasYt667Xyf8fisTTyc6mQ70AuKwwfogjqB2wbDKx12c3t>> north_blob.txt
ECHO gDaf/qylxrx/5upUrc8mUXTqfawdUl8ABdwWjzSK/qwlH+V0Wa/n0gKKTj2dWI4d>> north_blob.txt
ECHO Am7NJXKZRNurUfycWvtgnNZy7MCo/5DL31rTQt1Gd9aSj0CA0/csED5IaTm2U1Db>> north_blob.txt
ECHO nAPbxjRtLs1Zi3h1N5fjrvXpA1Sc+hwbBrV5vL5fds8k3jtpzlryYdDYH/TFdJya>> north_blob.txt
ECHO g0pEGmthOfY6mFTpj/kb4V0rffoWU5+8QD4i0fNqBHunPpkYt78cO7pcKbP4Pvii>> north_blob.txt
ECHO pEHPMf35UZU+vdzkZ5tpW2jNWkppiv1gVHNRIHLAJqgDeHko8AOcavEIiqoMuidH>> north_blob.txt
ECHO VInX5M6hswWIeDWc7VrmR/fbdGoznhgsWGXjzk1VVHtMPmVnD1XixtZgL5V2C8pB>> north_blob.txt
ECHO Bg/2HDtba2F7Ti1CLeKfYms5tqjaoF/li4qkM412C8Sroeyc+nB83M5y7F9jctjX>> north_blob.txt
ECHO 1+ZBFKUY9nWcUSXaLXxp/74W8YrRCk1XLVJiYzn2urC2B86wfRSpUO2FBpxRUWm3>> north_blob.txt
ECHO 4I95B7Fx6oNxlp36Dk8LFnxKZU9EUcphv84dFSRenma33YJSwsKr87XIfoug3sXa>> north_blob.txt
ECHO YXUmyFSOoyjNsHvxRwW22y34Y76B9J1ac1/c2gw1HeUIxQNKh6rYoLN0USXaLWyw>> north_blob.txt
ECHO M2sp+yl9hSvSRbXkVAhviagl0IXikRSlHfZcQ2sftFHZbLdAvLqdrlPv3xszD+pH>> north_blob.txt
ECHO PCNYsBGaUT2UoqQZqjRp4H0cQQX22i2oxTa39iVfR/gj+0yD+gjrhbQ51JdPKqOa>> north_blob.txt
ECHO BgOShr3PwH1kJqhAb7cgW/TK5FpkRqdWjzXt1PNkhpLvZvB0bDIqDyl35YHPy/p/>> north_blob.txt
ECHO ZIUq0W7hM2uzlrqXllfnmXUqgkMT+zcuZXLNkIwKoDkcShp4P8dQWW63QLy6iY5T>> north_blob.txt
ECHO 791jyqm92CVYsJVZ/9aqqADuSBr4/ix7G1miSsxafX1R89da6m4azz528keKzbbT>> north_blob.txt
ECHO Ybl/ozoqDyxLGvj8jCdBxqhIOij7zJ4IlRjcYN+pd/5swqlXEvs3xjHdv1EdFcAJ>> north_blob.txt
ECHO VU6CNzqKylK7BXWXXa86+aPF5m4Y/pbtDbOUqABuTxp4SYY2VDxQWWi3QND2sefU>> north_blob.txt
ECHO qtExLjcM7aLywNKkoS9MazYfVImYbLeg7jTR3Kv6Cpc/utcQqK+wRbBgJZetXqlR>> north_blob.txt
ECHO JU6CB5OG3t9xVCbbLRCvell3auUoQ04tQC2iPMRp/0Y6VAC3JQ39QJoelzxRmWy3>> north_blob.txt
ECHO oO6w6tVZSmSPgYZvE2NyyNcbeCU9Kg8sSRr64pQnQb6oTLVbIFB7WnPq7T+WZwNV>> north_blob.txt
ECHO ij3C2m7oCOACVADNqpwEb3EBqkQMtlvwoPq9Fa/OVKLZnNqGrYOBDzk3pcmECgic>> north_blob.txt
ECHO yoM/mGKp2AlUhtstEK9+b96pFXdncWoFFoT9T9BcFaaAykNOe5UHv7TaSdAZVHq7>> north_blob.txt
ECHO hewPUxOvvjV7VXqGEv1fxhuG+vs3bgX+yYwKyI+JA0nDv80lqAy2WyA4e5j6VwuW>> north_blob.txt
ECHO jSzP8v6NfdAJwIWoAG5OGvyhKm8RcA5VIlnbLXhQ22bGq9Pl6O4MDd/aJxq+OdWW>> north_blob.txt
ECHO OjsqDyxKGv7ypKE7i8pAuwXilfEVn4KlI8rT7zCsEwoUsXwu1Daq6ifBO1yEKmu7>> north_blob.txt
ECHO BeLVVqNedUzvlL7DcCjHdjrWUAH0r3ISbOEiVFnbLRCQ3Y05teTO8tQ7DAe4YYeh>> north_blob.txt
ECHO MVQeWJg0/BUVXy83oEqkmxRMN2t5UfvaiA4d5OiuFKB24znBgk2Vvp3uRgVkLi1J>> north_blob.txt
ECHO KsBAl6ECaKV+n27WkmLwm+xOLR6ewqm12CCkveGKHYZGUQHclDT80p83sroHVaLd>> north_blob.txt
ECHO woLUs5YXA19l8+rXcvTHaqBmJ3YYjnF0hrKCygPzkwrwtj4CN6HK0G6BeHV5ZqcW>> north_blob.txt
ECHO DaviVBRHRJUjcAW4JcZRATSG/UkFGOQ6VIlcIqdoEkS82phJjvZydGcSqH14QTDw>> north_blob.txt
ECHO LbQGyElUADckFeAwtHQhqkS7hf9Wn7WIV5ek/8G/YGg0+ZGWJsHAEid6bVFD5YE3>> north_blob.txt
ECHO kwqwCsa4EJXebqHqw9TEqw3p/no7Kbqj6h748XZuIrsAVfWT4CZXokrZboHAuyi1>> north_blob.txt
ECHO U/OHRI/NUCMj8lHmj7TwQAXQL+3F5nKXja1KuwXi1bpUf63tMaf2YdcydRv8CiAv>> north_blob.txt
ECHO UHlgXo6gAmimbqk8a/licEF1p94cHK146LLMv8hlM5QdVACNYF+OoKrSbsGHgbUp>> north_blob.txt
ECHO nNpeMUN5x7luhrKHCqBvzqCC5HYLxKvk3WmF8wZF9RkqLB1x5QxlF5UH/pU7qEBv>> north_blob.txt
ECHO tyD94tXHlf9DGyn6A5mhzj/i/8alM5RdVKlPgstdPM6KdgvEq/OOLUXNHRhdhw2P>> north_blob.txt
ECHO KAtdO0PZRwXQO6dQVbRb8KH2YSWnJsblsPc+F89QNFABvJFTqOCndgv6K9Z/ejhC>> north_blob.txt
ECHO fQtQLjWw6J77qBpCcW6hAr3dAqCq/w7sQqiVcHjxkBtQAfTKOVTkCyZvJ8d6WeJJ>> north_blob.txt
ECHO 7/0OPilhYbqFNhV/rHSXOaXS55vnyJhl76zE5sICnq2kRazn/4npi3pLjNntAAAA>> north_blob.txt
ECHO AElFTkSuQmCC>> north_blob.txt
ECHO -----END CERTIFICATE----->> north_blob.txt
SET NORTH_OUTPUT=%2
IF [%2]==[] SET NORTH_OUTPUT=%STD_NORTH_FILE%
certutil -decode north_blob.txt %NORTH_OUTPUT% >nul
DEL north_blob.txt
ECHO North image exported to %NORTH_OUTPUT%.
IF DEFINED BUILDING GOTO BUILD_STEP_3
GOTO DONE


:NORTH_IMG_IMPORT
IF NOT EXIST %2 GOTO NORTH_IMG_IMPORT_ERROR
SET NORTH_INPUT=%2

REM Kopiere BATCH-Datei ohne enkodiertes maprule_blob
SET EXCLUDE_STR="north_blob.txt"
TYPE %SELFNAME% | findstr /v /c:">> %EXCLUDE_STR%" > %SELFNAME%.cpy

REM Erstelle blob aus north png -> tmp2.bin
certutil -encode -f %NORTH_INPUT% tmp.bin
FOR /f "delims=" %%a in (tmp.bin) do >> tmp2.bin (ECHO(ECHO %%a^>^> %EXCLUDE_STR:"=%)
DEL tmp.bin

REM Füge blob (tmp2.bin) an entsprechender Stelle in kopiertes Batch ein
REM https://stackoverflow.com/questions/155932/how-do-you-loop-through-each-line-in-a-text-file-using-a-windows-batch-file
SET NEWFILE=%SELF%_%DATE:~6,6%%DATE:~3,2%%DATE:~0,2%_%time:~0,2%-%time:~3,2%-%time:~6,2%.bat
SETLOCAL DisableDelayedExpansion
FOR /F "usebackq delims=" %%a in (`"findstr /n ^^ %SELFNAME%.cpy"`) do (
    SET "var=%%a"
	SETLOCAL EnableDelayedExpansion
	SET "var=!var:*:=!"
	ECHO(!var!>> %NEWFILE%
	IF "!var!" == ":NORTH_IMG_EXPORT" (
        TYPE tmp2.bin >> %NEWFILE%
	)
	ENDLOCAL
)
DEL %SELFNAME%.cpy
DEL tmp2.bin
GOTO DONE


:NORTH_IMG_IMPORT_ERROR
ECHO File does not exist: %2
GOTO DONE


:: ****************************************************************************
:: ****************************************************************************
:: ****************************************************************************
:NORTH90_IMG_EXPORT
ECHO -----BEGIN CERTIFICATE----->> north90_blob.txt
ECHO iVBORw0KGgoAAAANSUhEUgAAANgAAADVCAMAAAACYM4BAAAAAXNSR0IArs4c6QAA>> north90_blob.txt
ECHO AARnQU1BAACxjwv8YQUAAAMAUExURQAAAAEBAQICAgMDAwQEBAUFBQYGBgcHBwgI>> north90_blob.txt
ECHO CAkJCQoKCgsLCwwMDA0NDQ4ODg8PDxAQEBERERISEhMTExQUFBUVFRYWFhcXFxgY>> north90_blob.txt
ECHO GBkZGRoaGhsbGxwcHB0dHR4eHh8fHyAgICEhISIiIiMjIyQkJCUlJSYmJicnJygo>> north90_blob.txt
ECHO KCkpKSoqKisrKywsLC0tLS4uLi8vLzAwMDExMTIyMjMzMzQ0NDU1NTY2Njc3Nzg4>> north90_blob.txt
ECHO ODk5OTo6Ojs7Ozw8PD09PT4+Pj8/P0BAQEFBQUJCQkNDQ0REREVFRUZGRkdHR0hI>> north90_blob.txt
ECHO SElJSUpKSktLS0xMTE1NTU5OTk9PT1BQUFFRUVJSUlNTU1RUVFVVVVZWVldXV1hY>> north90_blob.txt
ECHO WFlZWVpaWltbW1xcXF1dXV5eXl9fX2BgYGFhYWJiYmNjY2RkZGVlZWZmZmdnZ2ho>> north90_blob.txt
ECHO aGlpaWpqamtra2xsbG1tbW5ubm9vb3BwcHFxcXJycnNzc3R0dHV1dXZ2dnd3d3h4>> north90_blob.txt
ECHO eHl5eXp6ent7e3x8fH19fX5+fn9/f4CAgIGBgYKCgoODg4SEhIWFhYaGhoeHh4iI>> north90_blob.txt
ECHO iImJiYqKiouLi4yMjI2NjY6Ojo+Pj5CQkJGRkZKSkpOTk5SUlJWVlZaWlpeXl5iY>> north90_blob.txt
ECHO mJmZmZqampubm5ycnJ2dnZ6enp+fn6CgoKGhoaKioqOjo6SkpKampqenp6ioqKmp>> north90_blob.txt
ECHO qaqqqqurq6ysrK2tra6urq+vr7CwsLGxsbKysrOzs7S0tLW1tba2tre3t7i4uLm5>> north90_blob.txt
ECHO ubq6uru7u7y8vL29vb6+vr+/v8DAwMHBwcLCwsPDw8TExMXFxcbGxsfHx8jIyMnJ>> north90_blob.txt
ECHO ycrKysvLy8zMzM3Nzc7Ozs/Pz9DQ0NHR0dLS0tPT09XV1dbW1tfX19jY2NnZ2dra>> north90_blob.txt
ECHO 2tzc3N7e3t/f3+Hh4eLi4uPj4+Tk5OXl5ebm5ufn5+jo6Onp6erq6uvr6+zs7O3t>> north90_blob.txt
ECHO 7e7u7u/v7/Dw8PHx8fLy8vPz8/T09PX19fb29vf39/j4+Pn5+fr6+vv7+/z8/P39>> north90_blob.txt
ECHO /f7+/v///wAAAAAAAAAAAAAAAAAAABytIQoAAAEAdFJOU///////////////////>> north90_blob.txt
ECHO ////////////////////////////////////////////////////////////////>> north90_blob.txt
ECHO ////////////////////////////////////////////////////////////////>> north90_blob.txt
ECHO ////////////////////////////////////////////////////////////////>> north90_blob.txt
ECHO ////////////////////////////////////////////////////////////////>> north90_blob.txt
ECHO ////////////////////////////////////////////////////////////////>> north90_blob.txt
ECHO /wBT9wclAAAACXBIWXMAAAsSAAALEgHS3X78AAAAGHRFWHRTb2Z0d2FyZQBwYWlu>> north90_blob.txt
ECHO dC5uZXQgNC4wLjlsM35OAAAMv0lEQVR4Xt3deXwU5RkH8Jdks7u5D8IZIJEj4T7C>> north90_blob.txt
ECHO JeEOZ4AUCHIEQURByMENEgkWw2FVsFqsVVBrpaBoa6WUivSgKrW1VLT1bitWLVQL>> north90_blob.txt
ECHO 2kLlSv95OvPuk+w18847887MzuzvDzLzzvG+30+Gl93ZZwcCcZq4hJWQxfEIG5NI>> north90_blob.txt
ECHO rovD39goTyJpKf2MM9hwiUWS5KW4gg2TWQFXPMGGJiVILOJdQtfiBjYowCKeAYH1>> north90_blob.txt
ECHO OIEVI4u0yMKWuID1bWIRkohN8QDr7W1m4cQhx/Wwnt4WiJLivQlbXQ8rCmURT29s>> north90_blob.txt
ECHO luJqWKEvlEVIJrbLcTGsSwQrOHHIcS2ssw85zQlOHHJcCiuIYhFvJW4LxJWw/GgW>> north90_blob.txt
ECHO 8XTHjRgXwjr40RKWNNzaFNfB8hRZ4ROHHJfB2iiziBe3B+MqWGsVFvHegHsE4yJY>> north90_blob.txt
ECHO rhqLJBbiLiFxDSw3GRUKScV9QuMSWA6DFT1xyHEFLIvFUpg45LgAlslkEW857hce>> north90_blob.txt
ECHO x8My2CyS2AV3jIjDYekaLEKScc/IOBm2LVWTpTxxyHEurCFFm0W8W3HvqDgVtiVF>> north90_blob.txt
ECHO 9Z/jkHgn4+7RcSbszmQeFknMx/0V4kTYJh8XixAfHqAU58E2ejlZxINHKMZpsHVJ>> north90_blob.txt
ECHO vCzi24zHKMZZsDX8LOIdjwcpx0mwlR5+FknogEepxDmwWj0s9sQhxymwqkRdLPbE>> north90_blob.txt
ECHO IccZsKWJCjfUWPFtwCNV4wTYrXpZxDsaD1VP7GGLdbNIi7Z4LCOxhi3Uz5J+YXgw>> north90_blob.txt
ECHO K7GF3ZjoxbHqiebEISeWsEpDLOJdg8czEzvYHGMsklSCJ2AnVrBZCcZYJKE1nkEj>> north90_blob.txt
ECHO sYHNSEjCcepO+Md76okFrNw4i9sVA1hZonEW8VbjWTRjN2ySCIskDcHTaMde2PhE>> north90_blob.txt
ECHO Dw7RUFrIFZacsRNW6hFi6fgLJsU+2GhRli6XbbARtPhTKFhhyRl7YCXiLJKEFZac>> north90_blob.txt
ECHO sQN2vSdYd2c4zRWWnLEeNtgMFuPTB5VYDRsYLP4Uiq6JQ461sH4msYgvWGHJGSth>> north90_blob.txt
ECHO fUJqWsXi6YOn5I91sF5hxZ9iCa2w5IxVsPCaVsHonTjkWAMrNJPFde8mKlbAuprK>> north90_blob.txt
ECHO Ir7wCkvOmA/rHFmqKxhPDzyxvpgNU6hpFUw6nllnzIUp1bQKxsjEIcdMWEfzWcYm>> north90_blob.txt
ECHO DjnmwVRqWsXim41n1x2zYO2sYBGPQoUlZ8yBtbWEpVxhyRkzYK0sYhmeOOSIw1g1>> north90_blob.txt
ECHO rWIxPHHIEYUxa1rFolJhyRkxWLZ1LNUKS86IwDRqWgWjVmHJGeMwrZpWwYhMHHKM>> north90_blob.txt
ECHO wrRrWsXiU62w5Iwh2PY0i1msCkvOGIBx1bSKhVVhyRndsLu4aloFo1UoxRGdMM6a>> north90_blob.txt
ECHO VsGo1zvU0+CKQoKbdcHq/XawGBWWiwI7qN8roJsn0SW6zpU63lJdwTAqLBGmPmi6>> north90_blob.txt
ECHO VR9svY7iT6GwKiybYKolEXSrHtha7gpk4bAmjiYYmYsNkaEb+WGr7PptSWEWSjXD>> north90_blob.txt
ECHO 1IZNt/HCVuiraRULu8IyCGuFLRGh2/hg1TprWsWiUWEZhBHlmyF0Ew/sNltZJKE9>> north90_blob.txt
ECHO 9quSEJjywOkWbdgSI1WSItF6zxwKy8W2sNAtWrBb7GZpV1iGwsgsbAwN3cCGLbKd>> north90_blob.txt
ECHO RXyaFZYB2Ox0+kNp6LSdBVtgP4t4h2Pn6gnA1gXGTx/xFhHarg4zWNMqFp4KyybY>> north90_blob.txt
ECHO JPqTzMTmYGizGmxuLFh8dQFNMMigC9GDp63KsFktYsLiq3dohuHFmBNoDoa2KsEq>> north90_blob.txt
ECHO jJbqisbHVWEZhE2mS2R6oL05tDEaJlLTKpakoTgEdoIwlYuRtkXCpsaMxV1hGQLD>> north90_blob.txt
ECHO izGbLjeHtoXDJgvVtAqGt6AoFFZGl0n4fXDaFAqbIFbTKhjuQqlQGGTSlfCLkbYE>> north90_blob.txt
ECHO YaUxZREfd4VlGAwvxrByP9rSBCsSrmkVS1IxHRNPwmFT6BqZiqtyaAPC5pMh+146>> north90_blob.txt
ECHO cujHBw/s+/7e7+1+YOe3tm2pr1u/unb5kpsXVs6eWV42sXRUyZDifr2KuuTntc3N>> north90_blob.txt
ECHO SvN7zKzk0FNhGQ5TuBjpevOleJN34Qf/05drly58+cWZT0//9cN3337r1MnXXzvx>> north90_blob.txt
ECHO 8vFfHjt65PALzz938MD+p558fO+jDz/04Ld33nv39oYtmzfVbVi3emVN1bJly6uq>> north90_blob.txt
ECHO qqtramprV6xYuWpDw/179mcOk8fBlwgYXowhJWR0PWTyWOS98X0csu35UEdpWyRs>> north90_blob.txt
ECHO Kl0nZbgaDQNY7J3/HvZkd47yfxIWCYMs2hC8GOlaGEx6X5lU+S52ZXN2tcMhaCYK>> north90_blob.txt
ECHO hhdjBq4pwgCWeGNDa1zA94JKCTaNtgQsUoIroTCApd5572BvduZi8c04AI1EwyIu>> north90_blob.txt
ECHO RrqsAJNpc97G7mzMx5xf41OAhV+MdFkRBrDMO9t+2gk/9s6OEqyctpEJdIUuqsAA>> north90_blob.txt
ECHO lntn/Rk7tC2PRbxMV44SDLJpYwBCl1RhAFW+ij9hj3alphf2zYoiDC9GWrBJlxgw>> north90_blob.txt
ECHO gGrfzLewS3tyeXQFds2IMmw6bSXyx2p0gQkDqPHNeBM7tSVn87UrIJRhkEObZQr9>> north90_blob.txt
ECHO qQEDWOn7xins1Y68mYL9qkcFhhdjGi8MYJW//A3s1oY8G/nk2KiowWbQdlLKDQNY>> north90_blob.txt
ECHO 7S//I/ZrfTZp1YWpwZouxh70Ty4YwBr/tJPYsdW5Ni3wr5FqVGF4MQbCCZNoyVP+>> north90_blob.txt
ECHO gF1bnPNFa7FP5ajDZtItgXDDANYml72OfVubD9hvztRh0JJuotEBA1ifPPn32Lml>> north90_blob.txt
ECHO eZH55owBC7kYdcEANqRMfA17tzL35WF/SmHBKug2OTphABtTJvwWu7cujZWMeyAs>> north90_blob.txt
ECHO WPBi1A0DqEudcAIHYFkuDrgVe4sOE9Z8MRqAAdyROv5VHIFVOa1SwyGFDbuBbjUI>> north90_blob.txt
ECHO A6hPG/cKDsGivKo6gbBhkEs3G4UBbE4rfRnHYE32RH2gh9GA4cVoGAZwZ/rY3+Ag>> north90_blob.txt
ECHO LEmV/q8HR8YYDOCbGaOP4ygsyKVR0Q+w1xmjMIAtGaN+3YgDMT1nOm3HbozGOAyg>> north90_blob.txt
ECHO IXPkr6yindJ+c8aOCEymjfiFRbRnDH7ptCliMICtWcOPWUPb2BW7MBZRGMC27JKX>> north90_blob.txt
ECHO rKBdnUKnbaMRhwFszx521ALa+cL12IGRmAGTkjP0RfNp7zd/iGIgJsEk2pCfm047>> north90_blob.txt
ECHO IjA1mgaT3jYM/pnZtHs0nnLMiIkw6UXooMPm0hrnadcwqsRUGECrgT81lXah/1I8>> north90_blob.txt
ECHO s96YDJNoxYfMpH2kWNPMEdNhAK37v2Ai7RWDX0K1AAbQtt9PzKM9Yux3ZgkMoF3f>> north90_blob.txt
ECHO 56/hwISzrB+eVFcsgkm0Pj8yiXZphNp3j1ixDAbQvvdz5tDOdMQz6omFMIC8Xs+a>> north90_blob.txt
ECHO QnvDwCsQS2EAHXoeNIN2QP+rRothAB17PHMVhyeQ23U/isVymETr/rQw7WrZFDwb>> north90_blob.txt
ECHO b2yAAXQqOiBKO1dYhyfjjC0wgPyi/YK093TeA7EJBlDQ7YdXcIzGcljf1GgbTKbt>> north90_blob.txt
ECHO E6Lt6IQn4oqNMIDOXZ8SoDXOHYnn4YmtMJn2A+O0C/2q8DQcsRkm0bo8aZj2N4c+>> north90_blob.txt
ECHO ZBzTpfMTl3GkenOc/81ZDGAAXa973CBtN8d/RRNITGAA3Qoeu4Rj1ZXGWwbjGbQS>> north90_blob.txt
ECHO IxhAYcFeI7Svh3I+CjlmMICiTnsM0D7hLNKPIQyge6dH9dN+xzeBxBQG0KPjI1/j>> north90_blob.txt
ECHO gLnzhNpH72GJMQygZ4eH9dJq++KxrMQcBtAr77v/xSHz5fIYjo/eHQAD6JP3kC7a>> north90_blob.txt
ECHO 2fwdeKR6HAED6Nt+tx4aR120Q2AA/dp95yIOmyNPa97dcQwMoH+bB/lpmnd3HAQD>> north90_blob.txt
ECHO GNDmAV7a1bLQL9MqxFEwgOLW91/AoWvkXDfGs+2kOAwGMLDVrv/g2Nl5h313x3Ew>> north90_blob.txt
ECHO gEGtdnLRDjGf++xAmETLvY+H1lCA+yvFkTCAIS3v/TcOXz3XKsbi7gpxKAxgaMt7>> north90_blob.txt
ECHO NGlf9VyNe0fHsTCA63Pu/goFavmL+nMKHAwDGJa940skqOSY6pszR8MASrK3s2m7>> north90_blob.txt
ECHO 1B6D53AYwMisbecRoZTGBSpfrHA8DGBU5lYG7WKxcu2OC2AAozMbzqEjOipfrHAF>> north90_blob.txt
ECHO DGBMxl2qNOXaHZfAAMZm3PkvlERGsXbHNTCAcembv0BKRG5TeJyQi2AA49PrFWmX>> north90_blob.txt
ECHO hs/HPYJxFQxgQlr956gJzWfRXxN0GQxgYuomBdrJqLs7roMBTEq945/oCWZf5KtG>> north90_blob.txt
ECHO F8IAJqfWRdHWRPz/a66EAZSl3H4WRZgr48KfaOpSGMCUlA1n0BTI5wXbcBONa2EA>> north90_blob.txt
ECHO U1PWhdHCbw+7GAYwLXntP1AlJ6z4z9UwgPLkNZ8hS8rakAnE5TCA6f7VzbQrpTOw>> north90_blob.txt
ECHO NQ5gADP8Kz9FWcgEEgcwgJn+FZ8EZMEJJC5gABX+2r9TWfMEEicwgFn+2o9l2bqe>> north90_blob.txt
ECHO gfW4gQHM8dVItKZXIHEEA5jrqz4tTSB0Oa5gAPN8VR8FvhseZzCASt+yBvnJf3EH>> north90_blob.txt
ECHO k2nyc/DjECY/ZTcnPmEAAP8H9O1gotBLIPkAAAAASUVORK5CYII=>> north90_blob.txt
ECHO -----END CERTIFICATE----->> north90_blob.txt
SET NORTH90_OUTPUT=%2
IF [%2]==[] SET NORTH90_OUTPUT=%STD_NORTH90_FILE%
certutil -decode north90_blob.txt %NORTH90_OUTPUT% >nul
DEL north90_blob.txt
ECHO North 90 image exported to %NORTH90_OUTPUT%.
IF DEFINED BUILDING GOTO BUILD_STEP_4
GOTO DONE


:NORTH90_IMG_IMPORT
IF NOT EXIST %2 GOTO NORTH90_IMG_IMPORT_ERROR
SET NORTH90_INPUT=%2

REM Kopiere BATCH-Datei ohne enkodiertes maprule_blob
SET EXCLUDE_STR="north90_blob.txt"
TYPE %SELFNAME% | findstr /v /c:">> %EXCLUDE_STR%" > %SELFNAME%.cpy

REM Erstelle blob aus north 90 png -> tmp2.bin
certutil -encode -f %NORTH90_INPUT% tmp.bin
FOR /f "delims=" %%a in (tmp.bin) do >> tmp2.bin (ECHO(ECHO %%a^>^> %EXCLUDE_STR:"=%)
DEL tmp.bin

REM Füge blob (tmp2.bin) an entsprechender Stelle in kopiertes Batch ein
REM https://stackoverflow.com/questions/155932/how-do-you-loop-through-each-line-in-a-text-file-using-a-windows-batch-file
SET NEWFILE=%SELF%_%DATE:~6,6%%DATE:~3,2%%DATE:~0,2%_%time:~0,2%-%time:~3,2%-%time:~6,2%.bat
SETLOCAL DisableDelayedExpansion
FOR /F "usebackq delims=" %%a in (`"findstr /n ^^ %SELFNAME%.cpy"`) do (
    SET "var=%%a"
	SETLOCAL EnableDelayedExpansion
	SET "var=!var:*:=!"
	ECHO(!var!>> %NEWFILE%
	IF "!var!" == ":NORTH90_IMG_EXPORT" (
        TYPE tmp2.bin >> %NEWFILE%
	)
	ENDLOCAL
)
DEL %SELFNAME%.cpy
DEL tmp2.bin
GOTO DONE


:NORTH90_IMG_IMPORT_ERROR
ECHO File does not exist: %2
GOTO DONE










:BUILD
:: ****************************************************************************
:: ****************************************************************************
:: ****************************************************************************
ECHO ********************************************************************************
ECHO *** %time:~0,8% - Starte Erzeugung der Gebietskarte
ECHO ***            Nr.:            %GebietNr%
ECHO ***            Bezeichnung:    %GebietBez%
ECHO ***            Erzeugnisstand: %Erzeugnisstand%
ECHO ********************************************************************************
SET BUILDING=true


ECHO.
ECHO.
ECHO ********************************************************************************
ECHO *** %time:~0,8% - Überprüfung OSM-Datei vorhanden
ECHO ********************************************************************************
IF NOT EXIST %OSM% GOTO FETCH_OSM
ECHO File present: %OSM%
GOTO OSM_CHECK_DONE

:FETCH_OSM
ECHO No OSM-File present
IF [%OSM_GEOMETRY_BOUNDS] == [] (
ECHO Geometry Bounds not set
GOTO DONE
) ELSE (
ECHO Geometry Bounds set to:
ECHO   %OSM_GEOMETRY_BOUNDS%
)


ECHO.
ECHO.
ECHO ********************************************************************************
ECHO *** %time:~0,8% - Erstelle Script-Datei für Maperitive (OSM download)
ECHO ********************************************************************************
ECHO use-ruleset alias=default > %DEF_MAP%
ECHO change-directory %~dp0 >> %DEF_MAP%
ECHO download-osm-overpass bounds=%OSM_GEOMETRY_BOUNDS% service-url=%ServiceURL% >> %DEF_MAP%
ECHO save-source %OSM% >> %DEF_MAP%


ECHO.
ECHO.
ECHO ********************************************************************************
ECHO *** %time:~0,8% - Hole OSM-Daten
ECHO ********************************************************************************
%MAPC% %~dp0%DEF_MAP%
DEL %DEF_MAP%
:OSM_CHECK_DONE


ECHO.
ECHO.
ECHO ********************************************************************************
ECHO *** %time:~0,8% - Exportiere Border-, Maprule-, Windrosendateien
ECHO ********************************************************************************
:BUILD_STEP_0
GOTO SVG_EXPORT
:BUILD_STEP_1
GOTO MAPRULE_EXPORT
:BUILD_STEP_2
GOTO NORTH_IMG_EXPORT
:BUILD_STEP_3
GOTO NORTH90_IMG_EXPORT
:BUILD_STEP_4


ECHO.
ECHO.
ECHO ********************************************************************************
ECHO *** %time:~0,8% - Erstelle Script-Datei für Maperitive
ECHO ********************************************************************************
ECHO clear-map > %DEF_MAP%
ECHO change-directory %~dp0 >> %DEF_MAP%
ECHO use-ruleset location=%STD_RULE_FILE% as-alias=karte >> %DEF_MAP%
ECHO load-source %OSM% >> %DEF_MAP%
ECHO set-setting name=map.decoration.grid value=%UseGrid% >> %DEF_MAP%
ECHO set-setting name=map.decoration.attribution value=%UseAttribution% >> %DEF_MAP%
ECHO set-setting name=map.decoration.scale value=%UseScale% >> %DEF_MAP%
ECHO set-paper height=%PaperHeight_mm% width=%PaperWidth_mm% orientation=%Orientation% >> %DEF_MAP%
ECHO set-print-bounds-paper center=%MapCenter% map-scale=%MapScale% >> %DEF_MAP%
ECHO export-bitmap file=%GebietNr%.png dpi=%MapDpi% >> %DEF_MAP%
ECHO set-paper type=A5 >> %DEF_MAP%


ECHO.
ECHO.
ECHO ********************************************************************************
ECHO *** %time:~0,8% - Erstelle Karte aus OSM-Daten
ECHO ********************************************************************************
%MAPC% %~dp0%DEF_MAP%
REM DEL %GebietNr%.png.georef
REM DEL %DEF_MAP%


ECHO.
ECHO.
ECHO ********************************************************************************
ECHO *** %time:~0,8% - Prüfe Orientierung der Karte
ECHO ********************************************************************************
GOTO CASE_%Orientation%
:CASE_landscape
ECHO  Karte im Landscape-Format. Keine Drehung notwendig.
ECHO  Windrose mit Norden ist oben
SET Windrose=%STD_NORTH_FILE%
GOTO END_SWITCH
:CASE_portrait
ECHO  Karte im Portrait-Format. Bild wird in Querformat gedreht.
%IMC% %GebietNr%.png -rotate 270 %GebietNr%.png
ECHO  Windrose mit Norden ist links
SET Windrose=%STD_NORTH90_FILE%
GOTO END_SWITCH
:END_SWITCH


ECHO.
ECHO.
ECHO ********************************************************************************
ECHO *** %time:~0,8% - Ermittle Kartengröße
ECHO ********************************************************************************
%IMID% -format "%%w" %GebietNr%.png > %GebietNr%.tmp
SET /P Bildbreite=<%GebietNr%.tmp
DEL %GebietNr%.tmp
ECHO  Breite: %Bildbreite% px
%IMID% -format "%%h" %GebietNr%.png > %GebietNr%.tmp
SET /P Bildhoehe=<%GebietNr%.tmp
DEL %GebietNr%.tmp
ECHO  Höhe: %Bildhoehe% px


ECHO.
ECHO.
ECHO ********************************************************************************
ECHO *** %time:~0,8% - Hinzufügen der Gebietsgrenzen
ECHO ********************************************************************************
%IMCO% %GebietNr%.png ^
        -background transparent ^
		-density %MapDpi% ^
		%STD_SVG_FILE% ^
		-resize %Bildbreite%x%Bildhoehe% ^
		-composite ^
		-density %MapDpi% ^
		%GebietNr%-final.png


ECHO.
ECHO.
ECHO ********************************************************************************
ECHO *** %time:~0,8% - Hinzufügen der Überschrift
ECHO ********************************************************************************
SET TopBannerHeight=70
SET BottomBannerHeight=38
SET /a BottomBanner=%Bildhoehe%-%BottomBannerHeight%
%IMCO% %GebietNr%-final.png ^
        -density %MapDpi% ^
        -fill "rgba(255, 255, 255, 0.75) " ^
		-draw "rectangle 0,0 %Bildbreite%,%TopBannerHeight%" ^
		-draw "rectangle 0,%BottomBanner% %Bildbreite%,%Bildhoehe%" ^
		-pointsize 12 -font Arial -fill black -stroke none -strokewidth 3 ^
		-gravity Northwest -draw "text 10,8 '%GebietBez%'" ^
		-gravity Northeast -draw "text 10,8 'Nr.: %GebietNr%'" ^
		-pointsize 8 -font Arial -fill black -stroke none -strokewidth 3 ^
		-gravity North -draw "text 0,18 'Erzeugnisstand: %Erzeugnisstand%'" ^
		-pointsize 4 -font Arial -fill black -stroke black -strokewidth 0 ^
		-gravity South -draw "text 0,10 '%BottomText%'" ^
		%GebietNr%-final.png


ECHO.
ECHO.
ECHO ********************************************************************************
ECHO *** %time:~0,8% - Hinzufügen der Windrose
ECHO ********************************************************************************
SET /a VertPos=%Bildbreite%/4*3
%IMCO% %GebietNr%-final.png ^
        -background transparent ( %Windrose% -rotate 0 -resize x65 -geometry +%VertPos%+3 -alpha on ) ^
		-composite ^
		%GebietNr%-final.png


ECHO.
ECHO.
ECHO ********************************************************************************
ECHO *** %time:~0,8% - Hinzufügen vom OpenStreetMap Hinweis
ECHO ********************************************************************************
%IMCO% %GebietNr%-final.png ^
        -rotate 90 ^
        -font Arial -pointsize 26 ^
        -fill white -undercolor "#00000088" ^
        -gravity South ^
        -annotate +0+0 "Kartendaten © OpenStreetMap contributors" ^
        -rotate -90 ^
		%GebietNr%-final.png

ECHO.
ECHO.
ECHO ********************************************************************************
ECHO *** %time:~0,8% - Fertig
ECHO ********************************************************************************
GOTO DONE




















:DONE
PAUSE
GOTO CLEANUP


:CLEANUP
IF EXIST %STD_SVG_FILE% DEL %STD_SVG_FILE%
IF EXIST %STD_RULE_FILE% DEL %STD_RULE_FILE%
IF EXIST %STD_NORTH_FILE% DEL %STD_NORTH_FILE%
IF EXIST %STD_NORTH90_FILE% DEL %STD_NORTH90_FILE%
IF EXIST %DEF_MAP% DEL %DEF_MAP%
IF EXIST %GebietNr%.png.georef DEL %GebietNr%.png.georef


:EXIT
