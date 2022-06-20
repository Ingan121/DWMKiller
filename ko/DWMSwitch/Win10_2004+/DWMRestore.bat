@echo off
title DWM 복구
tasklist /FI "IMAGENAME eq dwm.exe" 2>NUL | find /I /N "dwm.exe">NUL
if "%ERRORLEVEL%"=="0" (
    echo DWM이 실행 중입니다.
    echo 무시하고 DWM 종료 절차를 실행하려면 아무 키나 누르십시오.
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
    echo 고전 테마 사용시에는 DWM 복구 전에 고전 테마를 해제하시기 바랍니다.
    pause
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
    pushd "%CD%"
    CD /D "%~dp0"
:--------------------------------------

<nul set /p =DWM 복구 중...
dwmctl start > nul
echo 성공

echo.
echo UWP/Immersive 구성 요소 복구 중...
move C:\Windows\SystemApps\Microsoft.Windows.StartMenuExperienceHost_cw5n1h2txyewy\StartMenuExperienceHost.exe.bak C:\Windows\SystemApps\Microsoft.Windows.StartMenuExperienceHost_cw5n1h2txyewy\StartMenuExperienceHost.exe>nul
if not errorlevel 1 (echo   StartMenuExperienceHost.exe: 성공) else echo   StartMenuExperienceHost.exe: 실패

move C:\Windows\SystemApps\Microsoft.Windows.Search_cw5n1h2txyewy\SearchApp.exe.bak C:\Windows\SystemApps\Microsoft.Windows.Search_cw5n1h2txyewy\SearchApp.exe>nul
if not errorlevel 1 (echo   SearchApp.exe: 성공) else echo   SearchApp.exe: 실패

move C:\Windows\SystemApps\MicrosoftWindows.Client.CBS_cw5n1h2txyewy\TextInputHost.exe.bak C:\Windows\SystemApps\MicrosoftWindows.Client.CBS_cw5n1h2txyewy\TextInputHost.exe>nul
if not errorlevel 1 (echo   TextInputHost.exe: 성공) else echo   TextInputHost.exe: 실패

move C:\Windows\SystemApps\ShellExperienceHost_cw5n1h2txyewy\ShellExperienceHost.exe.bak C:\Windows\SystemApps\ShellExperienceHost_cw5n1h2txyewy\ShellExperienceHost.exe>nul
if not errorlevel 1 (echo   ShellExperienceHost.exe: 성공) else echo   ShellExperienceHost.exe: 실패

::move C:\Windows\SystemApps\Microsoft.MicrosoftEdge_8wekyb3d8bbwe\MicrosoftEdge.exe.bak C:\Windows\SystemApps\Microsoft.MicrosoftEdge_8wekyb3d8bbwe\MicrosoftEdge.exe>nul
::if not errorlevel 1 (echo   MicrosoftEdge.exe: 성공) else echo   MicrosoftEdge.exe: 실패

move C:\Windows\System32\ApplicationFrameHost.exe.bak C:\Windows\System32\ApplicationFrameHost.exe>nul
if not errorlevel 1 (echo   ApplicationFrameHost.exe: 성공) else echo   ApplicationFrameHost.exe: 실패

echo.
<nul set /p =UWP 앱 백그라운드 실행 활성화 중... 
reg delete HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\BackgroundAccessApplications /v GlobalUserDisabled /f>nul && reg delete HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\BackgroundAccessApplications /v Migrated /f>nul
if not errorlevel 1 (echo 성공) else echo 실패

echo.
echo 고전 UI 요소 비활성화 중...

reg delete "HKEY_LOCAL_MACHINE\Software\Microsoft\Windows NT\CurrentVersion\MTCUVC" /v EnableMtcUvc /f>nul
if not errorlevel 1 (echo   볼륨 조절창: 성공) else echo   볼륨 조절창: 실패

reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\ImmersiveShell" /v UseWin32BatteryFlyout /f>nul
if not errorlevel 1 (echo   배터리 정보창: 성공) else echo   배터리 정보창: 실패

reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\ImmersiveShell" /v UseWin32TrayClockExperience /f>nul
if not errorlevel 1 (echo   날짜 및 시간 창: 성공) else echo   날짜 및 시간 창: 실패

reg delete "HKEY_CURRENT_USER\SOFTWARE\Policies\Microsoft\Windows\Explorer" /v EnableLegacyBalloonNotifications /f>nul
if not errorlevel 1 (echo   풍선 알림창: 성공) else echo   풍선 알림창: 실패

reg delete "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer" /v AltTabSettings /f>nul
if not errorlevel 1 (echo   Alt+Tab: 성공) else echo   Alt+Tab: 실패

move C:\Windows\System32\Windows.UI.Logon.dll.bak C:\Windows\System32\Windows.UI.Logon.dll>nul
if not errorlevel 1 (echo   콘솔 로그인: 성공) else echo   콘솔 로그인: 실패

echo.
<nul set /p =탐색기 재시작 중... 
taskkill -im explorer.exe -f>nul
start explorer
echo 완료

:schtasks /run /tn WinCenterTitle

echo.
echo 완료!
echo 아무 키나 눌러 창 닫기
timeout 10 >nul