@echo off
cd /d "%~dp0"
title DWM ����
tasklist /FI "IMAGENAME eq dwm.exe" 2>NUL | find /I /N "dwm.exe">NUL
if not "%ERRORLEVEL%"=="0" (
    echo DWM�� �̹� ����Ǿ� �ֽ��ϴ�. DWM ���� ��ũ��Ʈ�� �����մϴ�.
    pause
    echo.
    DWMRestore.bat
    exit /B
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
    echo ó�� DWM�� �����ϱ� �� �ݵ�� readme.txt�� �о��ֽñ� �ٶ��ϴ�.
    pause
    echo.
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
    pushd "%cd%"
    cd /d "%~dp0"
:--------------------------------------
echo.
echo UWP/Immersive ���μ��� ���� ��...
taskkill -im ApplicationFrameHost.exe -f>nul 2>nul
if not errorlevel 1 (echo   ApplicationFrameHost.exe: �����) else echo   ApplicationFrameHost.exe: ���� ���� �ƴ�

taskkill -im TextInputHost.exe -f>nul 2>nul
if not errorlevel 1 (echo   TextInputHost.exe: �����) else echo   TextInputHost.exe: ���� ���� �ƴ�

taskkill -im SystemSettings.exe -f>nul 2>nul
if not errorlevel 1 (echo   SystemSettings.exe: �����) else echo   SystemSettings.exe: ���� ���� �ƴ�

taskkill -im ShellExperienceHost.exe -f>nul 2>nul
if not errorlevel 1 (echo   ShellExperienceHost.exe: �����) else echo   ShellExperienceHost.exe: ���� ���� �ƴ�

taskkill -im Winstore.App.exe -f>nul 2>nul
if not errorlevel 1 (echo   Winstore.App.exe: �����) else echo   Winstore.App.exe: ���� ���� �ƴ�

taskkill -im MicrosoftEdge.exe -f>nul 2>nul
if not errorlevel 1 (echo   MicrosoftEdge.exe: �����) else echo   MicrosoftEdge.exe: ���� ���� �ƴ�

taskkill -im StartMenuExperienceHost.exe -f>nul 2>nul
if not errorlevel 1 (echo   StartMenuExperienceHost.exe: �����) else echo   StartMenuExperienceHost.exe: ���� ���� �ƴ�

taskkill -im SearchApp.exe -f>nul 2>nul
if not errorlevel 1 (echo   SearchApp.exe: �����) else echo   SearchApp.exe: ���� ���� �ƴ�

taskkill -im GameBar.exe -f>nul 2>nul
if not errorlevel 1 (echo   GameBar.exe: �����) else echo   GameBar.exe: ���� ���� �ƴ�

taskkill -im WWAHost.exe -f>nul 2>nul
if not errorlevel 1 (echo   WWAHost.exe: �����) else echo   WWAHost.exe: ���� ���� �ƴ�

echo.
echo UWP/Immersive ���� ��� ����� ���� �۾� ��...

takeown /a /f C:\Windows\SystemApps\Microsoft.Windows.StartMenuExperienceHost_cw5n1h2txyewy\StartMenuExperienceHost.exe>nul
icacls C:\Windows\SystemApps\Microsoft.Windows.StartMenuExperienceHost_cw5n1h2txyewy\StartMenuExperienceHost.exe /grant Administrators:F>nul
move C:\Windows\SystemApps\Microsoft.Windows.StartMenuExperienceHost_cw5n1h2txyewy\StartMenuExperienceHost.exe C:\Windows\SystemApps\Microsoft.Windows.StartMenuExperienceHost_cw5n1h2txyewy\StartMenuExperienceHost.exe.bak>nul
if not errorlevel 1 (echo   StartMenuExperienceHost.exe: ����) else echo   StartMenuExperienceHost.exe: ����

takeown /a /f C:\Windows\SystemApps\Microsoft.Windows.Search_cw5n1h2txyewy\SearchApp.exe>nul
icacls C:\Windows\SystemApps\Microsoft.Windows.Search_cw5n1h2txyewy\SearchApp.exe /grant Administrators:F>nul
move C:\Windows\SystemApps\Microsoft.Windows.Search_cw5n1h2txyewy\SearchApp.exe C:\Windows\SystemApps\Microsoft.Windows.Search_cw5n1h2txyewy\SearchApp.exe.bak>nul
if not errorlevel 1 (echo   SearchApp.exe: ����) else echo   SearchApp.exe: ����

takeown /a /f C:\Windows\SystemApps\MicrosoftWindows.Client.CBS_cw5n1h2txyewy\InputApp\TextInputHost.exe>nul
icacls C:\Windows\SystemApps\MicrosoftWindows.Client.CBS_cw5n1h2txyewy\InputApp\TextInputHost.exe /grant Administrators:F>nul
move C:\Windows\SystemApps\MicrosoftWindows.Client.CBS_cw5n1h2txyewy\InputApp\TextInputHost.exe C:\Windows\SystemApps\MicrosoftWindows.Client.CBS_cw5n1h2txyewy\InputApp\TextInputHost.exe.bak>nul
if not errorlevel 1 (echo   TextInputHost.exe: ����) else echo   TextInputHost.exe: ����

takeown /a /f C:\Windows\SystemApps\ShellExperienceHost_cw5n1h2txyewy\ShellExperienceHost.exe>nul
icacls C:\Windows\SystemApps\ShellExperienceHost_cw5n1h2txyewy\ShellExperienceHost.exe /grant Administrators:F>nul
move C:\Windows\SystemApps\ShellExperienceHost_cw5n1h2txyewy\ShellExperienceHost.exe C:\Windows\SystemApps\ShellExperienceHost_cw5n1h2txyewy\ShellExperienceHost.exe.bak>nul
if not errorlevel 1 (echo   ShellExperienceHost.exe: ����) else echo   ShellExperienceHost.exe: ����

::takeown /a /f C:\Windows\SystemApps\Microsoft.MicrosoftEdge_8wekyb3d8bbwe\MicrosoftEdge.exe>nul
::icacls C:\Windows\SystemApps\Microsoft.MicrosoftEdge_8wekyb3d8bbwe\MicrosoftEdge.exe /grant Administrators:F>nul
::move C:\Windows\SystemApps\Microsoft.MicrosoftEdge_8wekyb3d8bbwe\MicrosoftEdge.exe C:\Windows\SystemApps\Microsoft.MicrosoftEdge_8wekyb3d8bbwe\MicrosoftEdge.exe.bak>nul
::if not errorlevel 1 (echo   MicrosoftEdge.exe: ����) else echo   MicrosoftEdge.exe: ����

takeown /a /f C:\Windows\System32\ApplicationFrameHost.exe>nul
icacls C:\Windows\System32\ApplicationFrameHost.exe /grant Administrators:F>nul
move C:\Windows\System32\ApplicationFrameHost.exe C:\Windows\System32\ApplicationFrameHost.exe.bak>nul
if not errorlevel 1 (echo   ApplicationFrameHost.exe: ����) else echo   ApplicationFrameHost.exe: ����

::takeown /a /f C:\Windows\ImmersiveControlPanel\SystemSettings.exe>nul
::icacls C:\Windows\ImmersiveControlPanel\SystemSettings.exe /grant Administrators:F>nul
::move C:\Windows\ImmersiveControlPanel\SystemSettings.exe C:\Windows\ImmersiveControlPanel\SystemSettings.exe.bak>nul
::if not errorlevel 1 (echo   SystemSettings.exe: ����) else echo   SystemSettings.exe: ����

echo.
<nul set /p =UWP �� ��׶��� ���� ��Ȱ��ȭ ��... 
reg add HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\BackgroundAccessApplications /v GlobalUserDisabled /t REG_DWORD /d 1 /f>nul && reg add HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\BackgroundAccessApplications /v Migrated /t REG_DWORD /d 4 /f>nul
if not errorlevel 1 (echo ����) else echo ����

echo.
echo ���� UI ��� Ȱ��ȭ ��...
takeown /a /f C:\Windows\System32\Windows.UI.Logon.dll>nul
icacls C:\Windows\System32\Windows.UI.Logon.dll /grant Administrators:F>nul
move C:\Windows\System32\Windows.UI.Logon.dll C:\Windows\System32\Windows.UI.Logon.dll.bak>nul
if not errorlevel 1 (echo   �ܼ� �α���: ����) else echo   �ܼ� �α���: ����

echo.
<nul set /p =DWM ���� ��... 
dwmctl stop > nul
echo ����

echo.
echo �Ϸ�!
echo �ƹ� Ű�� ���� â �ݱ�
timeout 10 >nul
