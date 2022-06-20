@echo off
cd /d "%~dp0"
title DWM 비활성화

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
    echo 처음 DWM을 종료하기 전 반드시 readme.txt를 읽어주시기 바랍니다.
    pause
    echo.
    echo 관리자 권한 요청 중...
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
echo UWP/Immersive 프로세스 종료 중...
taskkill -im ApplicationFrameHost.exe -f>nul 2>nul
if not errorlevel 1 (echo   ApplicationFrameHost.exe: 종료됨) else echo   ApplicationFrameHost.exe: 실행 중이 아님

taskkill -im TextInputHost.exe -f>nul 2>nul
if not errorlevel 1 (echo   TextInputHost.exe: 종료됨) else echo   TextInputHost.exe: 실행 중이 아님

taskkill -im SystemSettings.exe -f>nul 2>nul
if not errorlevel 1 (echo   SystemSettings.exe: 종료됨) else echo   SystemSettings.exe: 실행 중이 아님

taskkill -im ShellExperienceHost.exe -f>nul 2>nul
if not errorlevel 1 (echo   ShellExperienceHost.exe: 종료됨) else echo   ShellExperienceHost.exe: 실행 중이 아님

taskkill -im Winstore.App.exe -f>nul 2>nul
if not errorlevel 1 (echo   Winstore.App.exe: 종료됨) else echo   Winstore.App.exe: 실행 중이 아님

taskkill -im StartMenuExperienceHost.exe -f>nul 2>nul
if not errorlevel 1 (echo   StartMenuExperienceHost.exe: 종료됨) else echo   StartMenuExperienceHost.exe: 실행 중이 아님

taskkill -im SearchHost.exe -f>nul 2>nul
if not errorlevel 1 (echo   SearchHost.exe: 종료됨) else echo   SearchHost.exe: 실행 중이 아님

taskkill -im GameBar.exe -f>nul 2>nul
if not errorlevel 1 (echo   GameBar.exe: 종료됨) else echo   GameBar.exe: 실행 중이 아님

echo.
echo UWP/Immersive 구성 요소 재실행 방지 작업 중...

takeown /a /f C:\Windows\SystemApps\Microsoft.Windows.StartMenuExperienceHost_cw5n1h2txyewy\StartMenuExperienceHost.exe>nul
icacls C:\Windows\SystemApps\Microsoft.Windows.StartMenuExperienceHost_cw5n1h2txyewy\StartMenuExperienceHost.exe /grant Administrators:F>nul
move C:\Windows\SystemApps\Microsoft.Windows.StartMenuExperienceHost_cw5n1h2txyewy\StartMenuExperienceHost.exe C:\Windows\SystemApps\Microsoft.Windows.StartMenuExperienceHost_cw5n1h2txyewy\StartMenuExperienceHost.exe.bak>nul
if not errorlevel 1 (echo   StartMenuExperienceHost.exe: 성공) else echo   StartMenuExperienceHost.exe: 실패

takeown /a /f C:\Windows\SystemApps\MicrosoftWindows.Client.CBS_cw5n1h2txyewy\SearchHost.exe>nul
icacls C:\Windows\SystemApps\MicrosoftWindows.Client.CBS_cw5n1h2txyewy\SearchHost.exe /grant Administrators:F>nul
move C:\Windows\SystemApps\MicrosoftWindows.Client.CBS_cw5n1h2txyewy\SearchHost.exe C:\Windows\SystemApps\MicrosoftWindows.Client.CBS_cw5n1h2txyewy\SearchHost.exe.bak>nul
if not errorlevel 1 (echo   SearchHost.exe: 성공) else echo   SearchHost.exe: 실패

takeown /a /f C:\Windows\SystemApps\MicrosoftWindows.Client.CBS_cw5n1h2txyewy\TextInputHost.exe>nul
icacls C:\Windows\SystemApps\MicrosoftWindows.Client.CBS_cw5n1h2txyewy\TextInputHost.exe /grant Administrators:F>nul
move C:\Windows\SystemApps\MicrosoftWindows.Client.CBS_cw5n1h2txyewy\TextInputHost.exe C:\Windows\SystemApps\MicrosoftWindows.Client.CBS_cw5n1h2txyewy\TextInputHost.exe.bak>nul
if not errorlevel 1 (echo   TextInputHost.exe: 성공) else echo   TextInputHost.exe: 실패

takeown /a /f C:\Windows\SystemApps\ShellExperienceHost_cw5n1h2txyewy\ShellExperienceHost.exe>nul
icacls C:\Windows\SystemApps\ShellExperienceHost_cw5n1h2txyewy\ShellExperienceHost.exe /grant Administrators:F>nul
move C:\Windows\SystemApps\ShellExperienceHost_cw5n1h2txyewy\ShellExperienceHost.exe C:\Windows\SystemApps\ShellExperienceHost_cw5n1h2txyewy\ShellExperienceHost.exe.bak>nul
if not errorlevel 1 (echo   ShellExperienceHost.exe: 성공) else echo   ShellExperienceHost.exe: 실패

takeown /a /f C:\Windows\System32\ApplicationFrameHost.exe>nul
icacls C:\Windows\System32\ApplicationFrameHost.exe /grant Administrators:F>nul
move C:\Windows\System32\ApplicationFrameHost.exe C:\Windows\System32\ApplicationFrameHost.exe.bak>nul
if not errorlevel 1 (echo   ApplicationFrameHost.exe: 성공) else echo   ApplicationFrameHost.exe: 실패

takeown /a /f C:\Windows\ImmersiveControlPanel\SystemSettings.exe>nul
icacls C:\Windows\ImmersiveControlPanel\SystemSettings.exe /grant Administrators:F>nul
move C:\Windows\ImmersiveControlPanel\SystemSettings.exe C:\Windows\ImmersiveControlPanel\SystemSettings.exe.bak>nul
if not errorlevel 1 (echo   SystemSettings.exe: 성공) else echo   SystemSettings.exe: 실패

echo.
<nul set /p =UWP 앱 백그라운드 실행 비활성화 중... 
reg add HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\BackgroundAccessApplications /v GlobalUserDisabled /t REG_DWORD /d 1 /f>nul && reg add HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\BackgroundAccessApplications /v Migrated /t REG_DWORD /d 4 /f>nul
if not errorlevel 1 (echo 성공) else echo 실패

echo.
echo 고전 UI 요소 활성화 중...
:reg add "HKEY_LOCAL_MACHINE\Software\Microsoft\Windows NT\CurrentVersion\MTCUVC" /v EnableMtcUvc /t REG_DWORD /d 0 /f>nul
:if not errorlevel 1 (echo   볼륨 조절창: 성공) else echo   볼륨 조절창: 실패

:reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\ImmersiveShell" /v UseWin32BatteryFlyout /t REG_DWORD /d 1 /f>nul
:if not errorlevel 1 (echo   배터리 정보창: 성공) else echo   배터리 정보창: 실패

:reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\ImmersiveShell" /v UseWin32TrayClockExperience /t REG_DWORD /d 1 /f>nul
:if not errorlevel 1 (echo   날짜 및 시간 창 (StartIsBack++ 2.9 이상 필요^): 성공) else echo   날짜 및 시간 창 (StartIsBack++ 2.9 이상 필요): 실패

reg add "HKEY_CURRENT_USER\SOFTWARE\Policies\Microsoft\Windows\Explorer" /v EnableLegacyBalloonNotifications /t REG_DWORD /d 1 /f>nul
if not errorlevel 1 (echo   풍선 알림창: 성공) else echo   풍선 알림창: 실패

:reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer" /v AltTabSettings /t REG_DWORD /d 1 /f>nul
:if not errorlevel 1 (echo   Alt+Tab: 성공) else echo   Alt+Tab: 실패

takeown /a /f C:\Windows\System32\Windows.UI.Logon.dll>nul
icacls C:\Windows\System32\Windows.UI.Logon.dll /grant Administrators:F>nul
move C:\Windows\System32\Windows.UI.Logon.dll C:\Windows\System32\Windows.UI.Logon.dll.bak>nul
if not errorlevel 1 (echo   콘솔 로그인: 성공) else echo   콘솔 로그인: 실패

echo.
<nul set /p =dwminit.dll 비활성화 중... 
takeown /a /f C:\Windows\System32\dwminit.dll>nul
icacls C:\Windows\System32\dwminit.dll /grant Administrators:F>nul
move C:\Windows\System32\dwminit.dll C:\Windows\System32\dwminit.dll.bak>nul
if not errorlevel 1 (echo 성공) else echo 실패

:<nul set /p =시각 테마 비활성화 중... 
:takeown /a /f C:\Windows\Resources\Themes\aero\aero.msstyles>nul
:icacls C:\Windows\Resources\Themes\aero\aero.msstyles /grant Administrators:F>nul
:move C:\Windows\Resources\Themes\aero\aero.msstyles C:\Windows\Resources\Themes\aero\aero.msstyles.bak>nul
:if not errorlevel 1 (echo 성공) else echo 실패

echo.
echo 완료!

echo.
choice /m "Sign out now?"
if %errorlevel% == 1 (
    logoff
    exit
) else (
    echo Press any key to close this window.
    timeout 20 >nul
)