@echo off
chcp 65001 >nul
setlocal EnableDelayedExpansion

set "ENV_FILE=%~dp0..\.env"
for /f "tokens=1,2 delims==" %%a in ('findstr /r "^[^#]" "%ENV_FILE%"') do (
    if "%%a"=="MARTES_REMOTE_HOME" set "MARTES_REMOTE_HOME=%%b"
    if "%%a"=="DISTRO_NAME" set "DISTRO_NAME=%%b"
)

wsl -d %DISTRO_NAME% bash -c "cd '%MARTES_REMOTE_HOME%' && sh update.sh"


