@ECHO OFF

REM Clear output
REM CLS

REM Extend search path for this batch file
SET PATH=%PATH%;C:\CPP\tools\msys64\mingw64\bin
REM SET PATH=%PATH%;V:\cmake-3.15.2-win64-x64\bin
SET PATH=%PATH%;V:\msys64\usr\bin
SET PATH=%PATH%;V:\doxygen-1.8.15.windows.x64.bin
SET PATH=%PATH%;V:\graphviz-2.38\release\bin
SET PATH=%PATH%;V:\pandoc-2.6-windows-x86_64
SET PATH=%PATH%;V:\upx-3.95-win32
SET PATH=%PATH%;Z:\bin

REM Set Defaults
SET buildtype=Release
SET generator=MinGW Makefiles
SET j_option=9
SET verbose=OFF

REM Handle parameters
:Loop
REM Show help and exit
IF     [%1]==[-h]           GOTO HELP
IF     [%1]==[--help]       GOTO HELP
IF     [%1]==[-r]           GOTO BUILDRELEASE
IF     [%1]==[--release]    GOTO BUILDRELEASE
IF     [%1]==[-d]           GOTO BUILDDEBUG
IF     [%1]==[--debug]      GOTO BUILDDEBUG
IF     [%1]==[-cb]          GOTO BUILDCODEBLOCKS
IF     [%1]==[--codeblocks] GOTO BUILDCODEBLOCKS
IF     [%1]==[-doc]         GOTO DOC
IF     [%1]==[--document]   GOTO DOC
IF     [%1]==[-c]           GOTO CLEAN
IF     [%1]==[--clean]      GOTO CLEAN
::-clean          :löscht build
::-cleanlib       :löscht ext_libs
::-cleanall       :löscht build und ext_libs
IF NOT [%1]==[]             GOTO HELP
GOTO BUILD

:HELP
ECHO Perform a build or a clean.
ECHO:
ECHO bootstrap ^<command^>
ECHO:
ECHO Available options:
ECHO:
ECHO   -r, --release      Build a release application in build directory.
ECHO   -d, --debug        Build a debug application in build directory.
ECHO   -cd, --codeblocks  Creates a code blocks project file.
ECHO   -e ^<component^>, 
ECHO   --externals ^<component^> Fetch (and build) externals. Available components:
ECHO                           boost, libmodbus, smfl, wxwidgets, all
ECHO   -doc, --document   Creates doxygen document
ECHO   -c, --clean        Deletes the build directory.
ECHO:
ECHO:
ECHO Example usage:
ECHO:
ECHO bootstrap -e all (fetch and build all externals and build application)
ECHO bootstrap -d -cb (create a debug codeblocks project and build)
GOTO DONE

:BUILDRELEASE
SET buildtype=Release
SHIFT
GOTO Loop

:BUILDDEBUG
SET buildtype=Debug
SHIFT
GOTO Loop

:BUILDCODEBLOCKS
SET generator=CodeBlocks - MinGW Makefiles
SHIFT
GOTO Loop

:BUILD
IF NOT EXIST build\NUL MKDIR build
CD build
cmake -G "%generator%" -DCMAKE_VERBOSE_MAKEFILE:BOOL=%verbose% -DCMAKE_BUILD_TYPE=%buildtype% -DCMAKE_SH="CMAKE_SH-NOTFOUND" ..
cmake --build . -- -j %j_option%
IF %ERRORLEVEL% GEQ 1 GOTO ERROR
CD ..
GOTO INSTALL

:INSTALL
CD build
REM IF EXIST check.exe cmake -E copy check.exe ..
CD ..
GOTO DONE

:DOC
IF NOT EXIST build\NUL MKDIR build
CD build
cmake -G "%generator%" -DCMAKE_BUILD_TYPE=%buildtype% ..
cmake --build . -- doc
IF %ERRORLEVEL% GEQ 1 GOTO ERROR
CD ..
GOTO DONE

:CLEAN
IF EXIST build\NUL RD /S /Q build
GOTO DONE

:ERROR
ECHO:
ECHO *** ERROR
ECHO Errorcode is %ERRORLEVEL%
PAUSE

:DONE
ECHO:
ECHO beendet