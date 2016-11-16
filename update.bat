REM http://stackoverflow.com/questions/24987542/is-there-a-link-to-github-for-downloading-a-file-in-the-latest-release-of-a-repo
rem this also copies a lot of scripting from my ccleaner-autoupdate script
@echo off
set user=natedawg1013
set repo=let-there-be-light

cd /d "%~dp0"
REM pushd "%~dp0"

:: ====================
:: USE THIS PART IF THE RELEASE IS THE SAME AS THE SOURCECODE/ZIPBALL/TARBALL
:: ====================
REM "%~dp0bin\wget" -nc --no-check-certificate --content-disposition https://api.github.com/repos/%user%/%repo%/zipball


REM if %errorlevel%==1 (
	REM echo.
	REM echo could not update
	REM pause
	REM exit
REM )

:: ====================
:: USE THIS PART IF THE RELEASE IS LIKE COMPILED OR SOMETHING
:: ====================
REM this part copies a lot of scripting from the BETAstandarddownloader.bat script also in the ccleaner-autoupdate script
REM "%~dp0bin\curl" -s -O https://api.github.com/repos/natedawg1013/let-there-be-light/releases/latest
"%~dp0bin\wget" -nc --no-check-certificate --content-disposition https://api.github.com/repos/%user%/%repo%/releases/latest
for /F "delims=" %%a in ('findstr /I "browser_download_url" latest') do set "link=%%a"
rem this link will have double quotes around it

REM "%~dp0bin\curl" -L -O %link:~30%
"%~dp0bin\wget" -nc %link:~30%
REM "%~dp0bin\wget" --no-check-certificate --content-disposition https://github.com/natedawg1013/let-there-be-light/releases/download/1.0.0/LetThereBeLight-1.0.0.jar
REM del latest

echo %errorlevel%
pause