@echo off
title ���� UI ���� ��� ��Ȱ��ȭ

:: BatchGotAdmin
:-------------------------------------
REM  --> Check for permissions
    IF "%PROCESSOR_ARCHITECTURE%" EQU "amd64" (
>nul 2>&1 "%SYSTEMROOT%\SysWOW64\cacls.exe" "%SYSTEMROOT%\SysWOW64\config\system"
) ELSE (
>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"
)

REM --> If error flag set, we do not have admin.
if '%errorlevel%' NEQ '0' (
    echo ������ ���� ��û ��...
    goto UACPrompt
) else ( goto gotAdmin )

:UACPrompt
    echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
    set params= %*
    echo UAC.ShellExecute "cmd.exe", "/c ""%~s0"" %params:"=""%", "", "runas", 1 >> "%temp%\getadmin.vbs"

    "%temp%\getadmin.vbs"
    del "%temp%\getadmin.vbs"
    exit /B

:gotAdmin
    pushd "%CD%"
    CD /D "%~dp0"
:--------------------------------------

<nul set /p =Ž���� ���� ��... 
taskkill -im explorer.exe -f>nul
if not errorlevel 1 (echo ����) else echo ����

echo.
echo ���� UI ��� ��Ȱ��ȭ ��...

reg delete "HKEY_LOCAL_MACHINE\Software\Microsoft\Windows NT\CurrentVersion\MTCUVC" /v EnableMtcUvc /f>nul
if not errorlevel 1 (echo   ���� ����â: ����) else echo   ���� ����â: ����

reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\ImmersiveShell" /v UseWin32BatteryFlyout /f>nul
if not errorlevel 1 (echo   ���͸� ����â: ����) else echo   ���͸� ����â: ����

reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\ImmersiveShell" /v UseWin32TrayClockExperience /f>nul
if not errorlevel 1 (echo   ��¥ �� �ð� â: ����) else echo   ��¥ �� �ð� â: ����

reg delete "HKEY_CURRENT_USER\SOFTWARE\Policies\Microsoft\Windows\Explorer" /v EnableLegacyBalloonNotifications /f>nul
if not errorlevel 1 (echo   ǳ�� �˸�â: ����) else echo   ǳ�� �˸�â: ����

reg delete "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer" /v AltTabSettings /f>nul
if not errorlevel 1 (echo   Alt+Tab: ����) else echo   Alt+Tab: ����

echo.
<nul set /p =Ž���� ����� ��... 
explorer
echo �Ϸ�

echo.
echo �Ϸ�!
echo �ƹ� Ű�� ���� â �ݱ�
timeout 10 >nul