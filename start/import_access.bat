@echo off
echo Importerar indatauppsättningar fron access databaser till Martes databasen...

REM Load environment variables from .env file
setlocal enabledelayedexpansion
for /f "tokens=1,2 delims==" %%a in ('type .env') do (
    if "%%a"=="MARTES_REMOTE_HOME" set "MARTES_REMOTE_HOME=%%b"
)

REM Kontrollera om variabeln är satt
if "%MARTES_REMOTE_HOME%"=="" (
    echo MARTES_REMOTE_HOME är inte satt. Kontrollera .env-filen.
    pause
    exit /b
)

REM Debug: Print the value of MARTES_REMOTE_HOME
echo MARTES_REMOTE_HOME is set to: %MARTES_REMOTE_HOME%

REM Run the backup script


wsl mkdir -p "%MARTES_REMOTE_HOME%/msaccess/"
wsl cp -r /mnt/c/martes_win/access/* /home/martin/martes_setup/msaccess/
wsl sh "%MARTES_REMOTE_HOME%/import_from_access.sh"
 

pause