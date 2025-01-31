@echo off
chcp 65001 >nul
 

:: Get the current script directory dynamically
set "CURRENT_PATH=%~dp0"
set "WSL_TAR_PATH=%CURRENT_PATH%ubuntu-profu.tar"
set "WSL_NAME=Ubuntu-Profu"
set "FOUND=false"



wsl -d %WSL_NAME% bash -c "sudo bash -c 'id -u martes &>/dev/null || adduser --disabled-password --gecos \"\" martes; echo \"martin ALL=(martes) NOPASSWD: ALL\" > /etc/sudoers.d/martin; echo \"martes ALL=(ALL) NOPASSWD: ALL\" > /etc/sudoers.d/martes; rm -rf /home/martes/martes_setup'"

REM Clone the repository if it doesn't exist, otherwise pull the latest changes as martes user
wsl -d %WSL_NAME% bash -c "sudo -u martes bash -c 'if [ ! -d ~/martes_setup ]; then git clone https://github.com/mmagnemyr/martes_setup.git ~/martes_setup; else cd ~/martes_setup && git pull; fi'"

REM Run setup.sh in the martes_setup folder as martes user
wsl -d %WSL_NAME% bash -c "sudo -u martes bash -c 'cd ~/martes_setup && bash setup_new.sh'"


call user_access.bat
exit /b

