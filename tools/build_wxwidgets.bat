@ECHO OFF

SET PATH_TO_WXWIDGETS=W:\wxWidgets-3.0.4

REM Extend search path for this batch file
SET PATH=%PATH%;Z:\bin

W:
CD %PATH_TO_WXWIDGETS%\build\msw

:BUILD
TITLE *** build wxwidgets debug
mingw32-make -j1 -f makefile.gcc BUILD=debug   SHARED=0 UNICODE=1 CXXFLAGS="-g -static -mthreads -pipe -std=gnu++17 -m32 -Wall -O0 -DwxDEBUG_LEVEL=1" setup_h
mingw32-make -j9 -f makefile.gcc BUILD=debug   SHARED=0 UNICODE=1 CXXFLAGS="-g -static -mthreads -pipe -std=gnu++17 -m32 -Wall -O0 -DwxDEBUG_LEVEL=1"
TITLE *** build wxwidgets release
mingw32-make -j1 -f makefile.gcc BUILD=release SHARED=0 UNICODE=1 CXXFLAGS="-static -mthreads -pipe -std=gnu++17 -m32 -Wall -O0 -s -DwxDEBUG_LEVEL=0" setup_h
mingw32-make -j9 -f makefile.gcc BUILD=release SHARED=0 UNICODE=1 CXXFLAGS="-static -mthreads -pipe -std=gnu++17 -m32 -Wall -O0 -s -DwxDEBUG_LEVEL=0"
GOTO FINISHED

:ERROR
ECHO *** ERROR
PAUSE

:FINISHED
ECHO *** FINISHED
PAUSE