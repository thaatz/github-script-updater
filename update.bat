@echo off
REM http://stackoverflow.com/questions/24987542/is-there-a-link-to-github-for-downloading-a-file-in-the-latest-release-of-a-repo
rem this also copies a lot of scripting from my ccleaner-autoupdate scripts
:: ================================================================================
set user=porjo
set repo=staticserve
set installdir=ltbl

:: 'bin' for main download, or 'source' for zipball
set type=bin

::this pertains to source zipballs. 'tagname' will download the zipball with the tag name (normal) 'api' will download with the name given by the api
set zipballtype=tagname

:: ================================================================================

:: we find the last version we downloaded
REM echo Checking installed version . . .
REM echo.
REM for /F "delims=" %%a in (lasttag) do set "lasttag=%%a"
REM if not exist "lasttag" ( set lasttag=none )
REM echo.
REM echo current version: %lasttag%


REM we download header information from github api
echo.
REM echo Checking server for updates . . .
"%~dp0bin\wget" -nv -nc --content-disposition https://api.github.com/repos/%user%/%repo%/releases/latest
REM echo %errorlevel%
if not %errorlevel%==0 (
	echo.
	echo Could not contact github. Check your network settings.
	pause
	exit
)
for /F "delims=" %%a in ('findstr /I "browser_download_url" latest') do set "link=%%a"
REM for /F "delims=" %%a in ('findstr /I "tag_name" latest') do set "tag=%%a"
REM set tag=%tag:~15,-2%
del latest


REM if %lasttag%==%tag% (
	REM echo.
	REM echo Already up to date [%lasttag%]
	REM pause
	REM exit
REM ) else (
	REM echo.
	REM echo Update found! [%lasttag% --^> %tag%]
REM )


if %type%==bin (
	goto :bin
) else if %type%==source (
	goto :source
) else (
	echo type is wrong
	exit
)

:source
:: ====================
:: USE THIS PART IF THE RELEASE IS THE SAME AS THE SOURCECODE/ZIPBALL/TARBALL
:: ====================
if %zipballtype%==tagname (
	REM echo https://github.com/%user%/%repo%/archive/%tag%.zip
	"%~dp0bin\wget" -N https://github.com/%user%/%repo%/archive/%tag%.zip
	pause
	goto :finished
) else if %zipballtype%==api (
	"%~dp0bin\wget" -N --content-disposition https://api.github.com/repos/%user%/%repo%/zipball
	pause
	goto :finished
) else (
	echo the source type was wrong
	pause
	exit
)


:bin
REM @echo on
:: ====================
:: USE THIS PART IF THE RELEASE IS LIKE COMPILED OR SOMETHING
:: ====================
"%~dp0bin\wget" -N %link:~30%
pause
goto :finished



:finished
:: we check to see if wget failed
if not %errorlevel%==0 (
	echo.
	echo could not update
	pause
	exit
)
echo.
echo Installing . . .
REM PUT THE INSTALL COMMANDS HERE
REM for /f %%f in ('dir /b /o-d "FILEFILEFILE"') do echo %%f
REM bin\7z x -o "%installdir%" -y "%%~ff"
REM echo %tag% >lasttag
pause
exit