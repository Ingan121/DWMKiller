@echo off
title DWM ����
tasklist /FI "IMAGENAME eq dwm.exe" 2>NUL | find /I /N "dwm.exe">NUL
if "%ERRORLEVEL%"=="0" (
    echo DWM�� ���� ���Դϴ�.
    echo �����ϰ� DWM ���� ������ �����Ϸ��� �ƹ� Ű�� �����ʽÿ�.
    pause>nul
    echo.
)

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
    pause
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

echo.
echo UWP/Immersive ���� ��� ���� ��...
move C:\Windows\SystemApps\Microsoft.Windows.StartMenuExperienceHost_cw5n1h2txyewy\StartMenuExperienceHost.exe.bak C:\Windows\SystemApps\Microsoft.Windows.StartMenuExperienceHost_cw5n1h2txyewy\StartMenuExperienceHost.exe>nul
if not errorlevel 1 (echo   StartMenuExperienceHost.exe: ����) else echo   StartMenuExperienceHost.exe: ����

move C:\Windows\SystemApps\MicrosoftWindows.Client.CBS_cw5n1h2txyewy\SearchHost.exe.bak C:\Windows\SystemApps\MicrosoftWindows.Client.CBS_cw5n1h2txyewy\SearchHost.exe>nul
if not errorlevel 1 (echo   SearchHost.exe: ����) else echo   SearchHost.exe: ����

move C:\Windows\SystemApps\MicrosoftWindows.Client.CBS_cw5n1h2txyewy\TextInputHost.exe.bak C:\Windows\SystemApps\MicrosoftWindows.Client.CBS_cw5n1h2txyewy\TextInputHost.exe>nul
if not errorlevel 1 (echo   TextInputHost.exe: ����) else echo   TextInputHost.exe: ����

move C:\Windows\SystemApps\ShellExperienceHost_cw5n1h2txyewy\ShellExperienceHost.exe.bak C:\Windows\SystemApps\ShellExperienceHost_cw5n1h2txyewy\ShellExperienceHost.exe>nul
if not errorlevel 1 (echo   ShellExperienceHost.exe: ����) else echo   ShellExperienceHost.exe: ����

move C:\Windows\System32\ApplicationFrameHost.exe.bak C:\Windows\System32\ApplicationFrameHost.exe>nul
if not errorlevel 1 (echo   ApplicationFrameHost.exe: ����) else echo   ApplicationFrameHost.exe: ����

move C:\Windows\ImmersiveControlPanel\SystemSettings.exe.bak C:\Windows\ImmersiveControlPanel\SystemSettings.exe>nul
if not errorlevel 1 (echo   SystemSettings.exe: ����) else echo   SystemSettings.exe: ����

echo.
<nul set /p =UWP �� ��׶��� ���� Ȱ��ȭ ��... 
reg delete HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\BackgroundAccessApplications /v GlobalUserDisabled /f>nul && reg delete HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\BackgroundAccessApplications /v Migrated /f>nul
if not errorlevel 1 (echo ����) else echo ����

echo.
echo ���� UI ��� ��Ȱ��ȭ ��...

:reg delete "HKEY_LOCAL_MACHINE\Software\Microsoft\Windows NT\CurrentVersion\MTCUVC" /v EnableMtcUvc /f>nul
:if not errorlevel 1 (echo   ���� ����â: ����) else echo   ���� ����â: ����

:reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\ImmersiveShell" /v UseWin32BatteryFlyout /f>nul
:if not errorlevel 1 (echo   ���͸� ����â: ����) else echo   ���͸� ����â: ����

:reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\ImmersiveShell" /v UseWin32TrayClockExperience /f>nul
:if not errorlevel 1 (echo   ��¥ �� �ð� â: ����) else echo   ��¥ �� �ð� â: ����

:reg delete "HKEY_CURRENT_USER\SOFTWARE\Policies\Microsoft\Windows\Explorer" /v EnableLegacyBalloonNotifications /f>nul
:if not errorlevel 1 (echo   ǳ�� �˸�â: ����) else echo   ǳ�� �˸�â: ����

:reg delete "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer" /v AltTabSettings /f>nul
:if not errorlevel 1 (echo   Alt+Tab: ����) else echo   Alt+Tab: ����

move C:\Windows\System32\Windows.UI.Logon.dll.bak C:\Windows\System32\Windows.UI.Logon.dll>nul
if not errorlevel 1 (echo   �ܼ� �α���: ����) else echo   �ܼ� �α���: ����

echo.
<nul set /p =dwminit.dll Ȱ��ȭ ��... 
move C:\Windows\System32\dwminit.dll.bak C:\Windows\System32\dwminit.dll>nul
if not errorlevel 1 (echo ����) else echo ����

:echo.
:<nul set /p =�ð� �׸� Ȱ��ȭ ��... 
:move C:\Windows\Resources\Themes\aero\aero.msstyles.bak C:\Windows\Resources\Themes\aero\aero.msstyles>nul
:if not errorlevel 1 (echo ����) else echo ����

echo.
echo �Ϸ�!

echo.
choice /m "Sign out now?"
if %errorlevel% == 1 (
    logoff
    exit
) else (
    echo Press any key to close this window.
    timeout 20 >nul
)