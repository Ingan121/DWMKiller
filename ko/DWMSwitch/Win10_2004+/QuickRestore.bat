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
    echo ���� �׸� ���ÿ��� DWM ���� ���� ���� �׸��� �����Ͻñ� �ٶ��ϴ�.
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

<nul set /p =DWM ���� ��...
dwmctl start > nul
echo ����

echo.
echo UWP/Immersive ���� ��� ���� ��...
move C:\Windows\SystemApps\Microsoft.Windows.StartMenuExperienceHost_cw5n1h2txyewy\StartMenuExperienceHost.exe.bak C:\Windows\SystemApps\Microsoft.Windows.StartMenuExperienceHost_cw5n1h2txyewy\StartMenuExperienceHost.exe>nul
if not errorlevel 1 (echo   StartMenuExperienceHost.exe: ����) else echo   StartMenuExperienceHost.exe: ����

move C:\Windows\SystemApps\Microsoft.Windows.Search_cw5n1h2txyewy\SearchApp.exe.bak C:\Windows\SystemApps\Microsoft.Windows.Search_cw5n1h2txyewy\SearchApp.exe>nul
if not errorlevel 1 (echo   SearchApp.exe: ����) else echo   SearchApp.exe: ����

move C:\Windows\SystemApps\MicrosoftWindows.Client.CBS_cw5n1h2txyewy\InputApp\TextInputHost.exe.bak C:\Windows\SystemApps\MicrosoftWindows.Client.CBS_cw5n1h2txyewy\InputApp\TextInputHost.exe>nul
if not errorlevel 1 (echo   TextInputHost.exe: ����) else echo   TextInputHost.exe: ����

move C:\Windows\SystemApps\ShellExperienceHost_cw5n1h2txyewy\ShellExperienceHost.exe.bak C:\Windows\SystemApps\ShellExperienceHost_cw5n1h2txyewy\ShellExperienceHost.exe>nul
if not errorlevel 1 (echo   ShellExperienceHost.exe: ����) else echo   ShellExperienceHost.exe: ����

::move C:\Windows\SystemApps\Microsoft.MicrosoftEdge_8wekyb3d8bbwe\MicrosoftEdge.exe.bak C:\Windows\SystemApps\Microsoft.MicrosoftEdge_8wekyb3d8bbwe\MicrosoftEdge.exe>nul
::if not errorlevel 1 (echo   MicrosoftEdge.exe: ����) else echo   MicrosoftEdge.exe: ����

move C:\Windows\System32\ApplicationFrameHost.exe.bak C:\Windows\System32\ApplicationFrameHost.exe>nul
if not errorlevel 1 (echo   ApplicationFrameHost.exe: ����) else echo   ApplicationFrameHost.exe: ����

echo.
<nul set /p =UWP �� ��׶��� ���� Ȱ��ȭ ��... 
reg delete HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\BackgroundAccessApplications /v GlobalUserDisabled /f>nul && reg delete HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\BackgroundAccessApplications /v Migrated /f>nul
if not errorlevel 1 (echo ����) else echo ����

echo.
echo ���� UI ��� ��Ȱ��ȭ ��...
move C:\Windows\System32\Windows.UI.Logon.dll.bak C:\Windows\System32\Windows.UI.Logon.dll>nul
if not errorlevel 1 (echo   �ܼ� �α���: ����) else echo   �ܼ� �α���: ����

:schtasks /run /tn WinCenterTitle

echo.
echo �Ϸ�!
echo �ƹ� Ű�� ���� â �ݱ�
timeout 10 >nul