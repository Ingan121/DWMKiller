@echo off
cd /d "%~dp0"
title 고전 UI 구성 요소 활성화

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

<nul set /p =탐색기 종료 중... 
taskkill -im explorer.exe -f>nul
if not errorlevel 1 (echo 성공) else echo 실패

echo.
echo 고전 UI 요소 활성화 중...
reg add "HKEY_LOCAL_MACHINE\Software\Microsoft\Windows NT\CurrentVersion\MTCUVC" /v EnableMtcUvc /t REG_DWORD /d 0 /f>nul
if not errorlevel 1 (echo   볼륨 조절창: 성공) else echo   볼륨 조절창: 실패

reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\ImmersiveShell" /v UseWin32BatteryFlyout /t REG_DWORD /d 1 /f>nul
if not errorlevel 1 (echo   배터리 정보창: 성공) else echo   배터리 정보창: 실패

reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\ImmersiveShell" /v UseWin32TrayClockExperience /t REG_DWORD /d 1 /f>nul
if not errorlevel 1 (echo   날짜 및 시간 창 (StartIsBack++ 2.9 이상 필요^): 성공) else echo   날짜 및 시간 창 (StartIsBack++ 2.9 이상 필요): 실패

reg add "HKEY_CURRENT_USER\SOFTWARE\Policies\Microsoft\Windows\Explorer" /v EnableLegacyBalloonNotifications /t REG_DWORD /d 1 /f>nul
if not errorlevel 1 (echo   풍선 알림창: 성공) else echo   풍선 알림창: 실패

reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer" /v AltTabSettings /t REG_DWORD /d 1 /f>nul
if not errorlevel 1 (echo   Alt+Tab: 성공) else echo   Alt+Tab: 실패

echo.
<nul set /p =탐색기 재시작 중... 
explorer
if not errorlevel 1 (echo 성공) else echo 실패

echo.
echo 완료!
echo 아무 키나 눌러 창 닫기
timeout 10 >nul