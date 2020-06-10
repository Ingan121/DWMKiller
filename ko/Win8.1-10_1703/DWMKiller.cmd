@echo off
taskkill /IM explorer.exe /f
pssuspend winlogon.exe
taskkill /IM dwm.exe /f
start explorer.exe
echo ¿Ï·á!