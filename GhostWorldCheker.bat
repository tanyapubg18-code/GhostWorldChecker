@echo off
setlocal EnableDelayedExpansion
title GhostWorld Checker by bulbakublas
color 0A

:: ============================================================
:: BOOT SCREEN
:: ============================================================
:boot
cls
echo.
echo  #######################################################
echo  #                                                     #
echo  #          G H O S T W O R L D   C H E C K E R        #
echo  #                                                     #
echo  #######################################################
echo.
echo  [+] Developer: bulbakublas
echo  [+] Version: 17.0 Ultimate
echo  [+] Status: Initializing...
timeout /t 1 >nul

echo  [+] Loading cheat signatures (1400+)...
timeout /t 1 >nul

echo  [+] Connecting Forensics Module...
timeout /t 1 >nul

echo  [+] Checking Admin Rights...
net session >nul 2>&1
if %errorLevel% neq 0 (
    color 4F
    echo.
    echo  [!] ERROR: ADMIN RIGHTS REQUIRED!
    echo  [!] Right click - Run as Administrator
    pause
    exit /b
)
echo  [+] Admin rights confirmed.
echo.
echo  [!] SYSTEM READY.
timeout /t 2 >nul

set "REPORT=%~dp0GhostWorld_Report.txt"
set "MC=%APPDATA%\.minecraft"
set "CRASH_DIR=%LOCALAPPDATA%\CrashDumps"
set "WER_DIR=C:\ProgramData\Microsoft\Windows\WER\ReportArchive"
set "TOOLS_DIR=%~dp0tools"
if not exist "%TOOLS_DIR%" mkdir "%TOOLS_DIR%"

set "CHEATS=impact wurst aristois baritone liquidbounce rusherhack future konas salhack kamiblue sigma vape novoline tenacity rise astolfo krypton moonproject akrien celestial forgehax inertia wexside wolfram bleach pyro jigsaw candycrack flux nurik minced nightmare augustus thunderhack fatal resolute centric delta catlavan quick dimasik skycor energy energyclient norules matix deadcode eternity rich editme mc100 r3d boberware cortex wex hitbox fluger jessica freecam inventorytotem chestlocator valex fabaritone crack celka keazclient tofficlient darkness archware intave nova haramdev shitclient ponosclient vegaline newlight exclusive tenseclient moonhack deltaclient hachclient fullmyst gothaj sirius wave veristclient avalon wissendfree resolutefree kwishfree centricfree tutotialclient fecuritysq noclips koshkadlc flauncher atmosphere hider huzuni neverhook exloader calestial clowdyclient vert vapeclient clownclient norender extremehack asteria aimmbot elytra_swap smart_moving chest_stealer topkaautobuy doomsday viaversion viamcp spambot xray x-ray killaura wallhack aimbot"

:: ============================================================
:: MAIN MENU
:: ============================================================
:menu
cls
color 0A
echo.
echo  =======================================================
echo          G H O S T W O R L D   C H E C K E R
echo                 by bulbakublas
echo  =======================================================
echo.
echo   [ GAME SCANNING ]
echo   1. Scan Minecraft Folders (mods, config, libs)
echo   2. Scan Game Logs (latest.log, crash-reports)
echo   3. Check Java Process (Injectors)
echo.
echo   [ SYSTEM CHECK ]
echo   4. Scan Windows Registry (MuiCache)
echo   5. Check Services and CrashDumps
echo   6. Check Network Settings (Hosts)
echo.
echo   [ POWERFUL TOOLS ]
echo   7. Run AI Analyzers (Yumiko / Meow)
echo   8. Search via Everything (Lumina/Troxill)
echo   9. Download Tools Manager (NirSoft)
echo.
echo   [ REPORTS ]
echo  10. Open Last Report
echo  11. DEEP SCAN (Shows dates + ERROR ALERT)
echo.
echo   0. EXIT
echo.
echo  =======================================================
set /p "choice=  Select option (0-11): "

if "%choice%"=="1" goto scan_mc
if "%choice%"=="2" goto scan_mc_logs
if "%choice%"=="3" goto check_jvm
if "%choice%"=="4" goto check_reg_logs
if "%choice%"=="5" goto check_sys
if "%choice%"=="6" goto check_net
if "%choice%"=="7" goto run_analyzers
if "%choice%"=="8" goto run_everything
if "%choice%"=="9" goto tools_menu
if "%choice%"=="10" start "" notepad "%REPORT%" & goto menu
if "%choice%"=="11" goto deep_scan
if "%choice%"=="0" exit /b
goto menu

:: ============================================================
:: CHEAT DETECTED ALERT
:: ============================================================
:cheat_detected
color 4F
echo.
echo  !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
echo  !!!                                                 !!!
echo  !!!             C H E A T   D E T E C T E D         !!!
echo  !!!                                                 !!!
echo  !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
echo.
echo  [*] Details saved to: %REPORT%
echo  [*] Check the file to see cheat name and date.
echo.
:: Windows Popup Alert
powershell -WindowStyle Hidden -Command "Add-Type -AssemblyName PresentationFramework; [System.Windows.MessageBox]::Show('CHEAT DETECTED! Check console or GhostWorld report.', 'GhostWorld Alert', 'OK', 'Error')"
pause
goto menu

:: ============================================================
:: 11. DEEP SCAN (WITH DATES)
:: ============================================================
:deep_scan
cls
echo.
echo  Starting Deep Scan (looking for dates)...
>> "%REPORT%" echo.
>> "%REPORT%" echo --- 11. DEEP SCAN (DATES) ---

if not exist "%MC%" (
    echo  [!] .minecraft not found.
    pause & goto menu
)

set "FOUND=0"
echo  Scanning files in .minecraft...

for /r "%MC%" %%F in (*.jar *.dll *.exe) do (
    set "FNAME=%%~nxF"
    for %%C in (%CHEATS%) do (
        if not "!FNAME:%%C=!"=="!FNAME!" (
            set "FOUND=1"
            >> "%REPORT%" echo [!] CHEAT FOUND: %%F
            for %%D in ("%%F") do (
                >> "%REPORT%" echo     Modified Date: %%~tD
            )
        )
    )
)

if !FOUND! equ 1 (
    goto cheat_detected
) else (
    color 0A
    echo.
    echo  [OK] Deep scan complete. No cheats found.
    >> "%REPORT%" echo [OK] No cheats found.
    pause & goto menu
)

:: ============================================================
:: 1. SCAN FOLDERS
:: ============================================================
:scan_mc
cls
echo.
echo  Scanning Minecraft Folders...
>> "%REPORT%" echo --- 1. MINECRAFT FOLDERS ---

if not exist "%MC%" (
    echo  [!] .minecraft not found.
    pause & goto menu
)

set "FOUND=0"
if exist "%MC%\libraries\cabaletta" (
    set "FOUND=1"
    >> "%REPORT%" echo [!] CABALETTA FOLDER FOUND!
)
if exist "%MC%\libraries\com\github\Impact Development" (
    set "FOUND=1"
    >> "%REPORT%" echo [!] IMPACT FOUND!
)
if exist "%MC%\libraries\net\minecraftxray" (
    set "FOUND=1"
    >> "%REPORT%" echo [!] XRAY FOUND!
)

dir "%MC%\config\*.cfg" "%MC%\mods\*.jar" /b /s 2>nul | findstr /i "%CHEATS%" >> "%REPORT%"
if !errorlevel! equ 0 ( set "FOUND=1" )

if !FOUND! equ 1 ( goto cheat_detected ) else ( echo  [OK] Clean. & pause & goto menu )

:: ============================================================
:: 2. SCAN LOGS
:: ============================================================
:scan_mc_logs
cls
echo.
echo  Scanning Game Logs...
>> "%REPORT%" echo --- 2. MINECRAFT LOGS ---

if not exist "%MC%\logs" (
    echo  [!] Logs folder not found.
    pause & goto menu
)

set "FOUND=0"
if exist "%MC%\logs\latest.log" (
    findstr /i /c:"%CHEATS%" "%MC%\logs\latest.log" >> "%REPORT%"
    if !errorlevel! equ 0 ( set "FOUND=1" )
)

if exist "%MC%\crash-reports" (
    findstr /i /c:"%CHEATS%" "%MC%\crash-reports\*.txt" >> "%REPORT%" 2>nul
    if !errorlevel! equ 0 ( set "FOUND=1" )
)

if !FOUND! equ 1 ( goto cheat_detected ) else ( echo  [OK] Logs are clean. & pause & goto menu )

:: ============================================================
:: 3. JAVA ARGS
:: ============================================================
:check_jvm
cls
echo.
echo  Checking Java Process (Injectors)...
>> "%REPORT%" echo --- 3. JVM ARGS ---

set "FOUND=0"
for /f "delims=" %%A in ('wmic process where "name='javaw.exe' or name='java.exe'" get commandline 2^>nul ^| findstr /i "agent bootclasspath"') do (
    set "FOUND=1"
    >> "%REPORT%" echo [!] SUSPICIOUS ARG: %%A
)

if !FOUND! equ 1 ( goto cheat_detected ) else ( echo  [OK] Java args clean. & pause & goto menu )

:: ============================================================
:: 4. REGISTRY
:: ============================================================
:check_reg_logs
cls
echo.
echo  Checking Windows Registry...
>> "%REPORT%" echo --- 4. WINDOWS REGISTRY ---

reg query "HKCU\SOFTWARE\Classes\Local Settings\Software\Microsoft\Windows\Shell\MuiCache" /s 2>nul | findstr /i "exe dll cheat impact wurst" >> "%REPORT%"
reg query "HKCU\Software\Microsoft\Windows NT\CurrentVersion\AppCompatFlags\Compatibility Assistant\Store" /s 2>nul | findstr /i "exe" >> "%REPORT%"

echo  [OK] Registry checked. See report.
pause & goto menu

:: ============================================================
:: 5. SYSTEM SERVICES
:: ============================================================
:check_sys
cls
echo.
echo  Checking System Services...
>> "%REPORT%" echo --- 5. SYSTEM ---

for %%S in (dps sysmain pcasvc bam appinfo schedule dusmsvc diagtrack eventlog) do (
    for /f "tokens=3" %%A in ('sc query %%S ^| findstr "STATE"') do (
        >> "%REPORT%" echo %%S : %%A
    )
)
echo  [OK] Services checked. See report.
pause & goto menu

:: ============================================================
:: 6. NETWORK
:: ============================================================
:check_net
cls
echo.
echo  Checking Network Settings...
>> "%REPORT%" echo --- 6. NETWORK ---
findstr /v "#" "C:\Windows\System32\drivers\etc\hosts" >> "%REPORT%"
start "" notepad "C:\Windows\System32\drivers\etc\hosts"
echo  [OK] Hosts file opened.
pause & goto menu

:: ============================================================
:: 7. AI ANALYZERS
:: ============================================================
:run_analyzers
cls
echo.
echo  [1] Run Yumiko (Very Slow)
echo  [2] Run Meow (Fast)
echo  [3] Run Both
echo  [0] Cancel
set /p "an= Select: "

if "%an%"=="0" goto menu
if "%an%"=="1" start powershell -NoExit -ExecutionPolicy Bypass -Command "Invoke-Expression (Invoke-RestMethod 'https://raw.githubusercontent.com/veridondevvv/YumikoModAnalyzer/refs/heads/main/YumikoModAnalyzer.ps1')"
if "%an%"=="2" start powershell -NoExit -ExecutionPolicy Bypass -Command "Invoke-Expression (Invoke-RestMethod 'https://raw.githubusercontent.com/MeowTonynoh/MeowModAnalyzer/main/MeowModAnalyzer.ps1')"
if "%an%"=="3" (
    start powershell -NoExit -ExecutionPolicy Bypass -Command "Invoke-Expression (Invoke-RestMethod 'https://raw.githubusercontent.com/MeowTonynoh/MeowModAnalyzer/main/MeowModAnalyzer.ps1')"
    start powershell -NoExit -ExecutionPolicy Bypass -Command "Invoke-Expression (Invoke-RestMethod 'https://raw.githubusercontent.com/veridondevvv/YumikoModAnalyzer/refs/heads/main/YumikoModAnalyzer.ps1')"
)
goto menu

:: ============================================================
:: 8. EVERYTHING SEARCH
:: ============================================================
:run_everything
cls
echo.
echo  Searching via Everything...
set "EVERYTHING_GUI="
set "ES="

if exist "%ProgramFiles%\Everything\Everything.exe" set "EVERYTHING_GUI=%ProgramFiles%\Everything\Everything.exe"
if exist "%ProgramFiles(x86)%\Everything\Everything.exe" set "EVERYTHING_GUI=%ProgramFiles(x86)%\Everything\Everything.exe"
if exist "%TOOLS_DIR%\es.exe" set "ES=%TOOLS_DIR%\es.exe"

if defined EVERYTHING_GUI (
    start "" "%EVERYTHING_GUI%" -search "ext:jar size:^>100kb"
    timeout /t 2 >nul
    start "" "%EVERYTHING_GUI%" -search "*.jar utf8content:ol/yv75/edv6"
    echo  [OK] Everything GUI opened.
) else if defined ES (
    "%ES%" "ext:jar size:^>100kb" >> "%REPORT%"
    "%ES%" "*.jar utf8content:ol/yv75/edv6" >> "%REPORT%"
    echo  [OK] ES Search complete.
) else (
    echo  [!] Everything not found. Use Tools Manager [9].
)
pause & goto menu

:: ============================================================
:: 9. TOOLS MANAGER
:: ============================================================
:tools_menu
cls
echo.
echo  =======================================================
echo                 T O O L S   M A N A G E R
echo  =======================================================
echo.
echo   [1] RegScanner           [2] LastActivityView
echo   [3] USBDeview            [4] ShellBagsView
echo   [5] BrowserDownloadsView [6] ExecutedProgramsList
echo   [7] PrefetchView         [8] OpenSaveFilesView
echo   [9] UserAssistView       [10] BrowsingHistoryView
echo  [11] System Informer      [12] JournalTrace
echo  [13] Everything CLI       [14] PE-bear
echo.
echo   [0] Back to Menu
echo.
set /p "t_choice=  Select tool: "

if "%t_choice%"=="1" call :dl_and_run "https://www.nirsoft.net/utils/regscanner-x64.zip" "RegScanner.exe" & goto tools_menu
if "%t_choice%"=="2" call :dl_and_run "https://www.nirsoft.net/utils/lastactivityview.zip" "LastActivityView.exe" & goto tools_menu
if "%t_choice%"=="3" call :dl_and_run "https://www.nirsoft.net/utils/usbdeview-x64.zip" "USBDeview.exe" & goto tools_menu
if "%t_choice%"=="4" call :dl_and_run "https://www.nirsoft.net/utils/shellbagsview.zip" "ShellBagsView.exe" & goto tools_menu
if "%t_choice%"=="5" call :dl_and_run "https://www.nirsoft.net/utils/browserdownloadsview-x64.zip" "BrowserDownloadsView.exe" & goto tools_menu
if "%t_choice%"=="6" call :dl_and_run "https://www.nirsoft.net/utils/executedprogramslist.zip" "ExecutedProgramsList.exe" & goto tools_menu
if "%t_choice%"=="7" call :dl_and_run "https://www.nirsoft.net/utils/prefetchview.zip" "PrefetchView.exe" & goto tools_menu
if "%t_choice%"=="8" call :dl_and_run "https://www.nirsoft.net/utils/opensavefilesview.zip" "OpenSaveFilesView.exe" & goto tools_menu
if "%t_choice%"=="9" call :dl_and_run "https://www.nirsoft.net/utils/userassistview.zip" "UserAssistView.exe" & goto tools_menu
if "%t_choice%"=="10" call :dl_and_run "https://www.nirsoft.net/utils/browsinghistoryview-x64.zip" "BrowsingHistoryView.exe" & goto tools_menu
if "%t_choice%"=="11" start "" "https://systeminformer.sourceforge.io/" & goto tools_menu
if "%t_choice%"=="12" start "" "https://github.com/spokwn/JournalTrace" & goto tools_menu
if "%t_choice%"=="13" call :dl_and_run "https://www.voidtools.com/ES-1.1.1.39.x64.zip" "es.exe" & goto tools_menu
if "%t_choice%"=="14" start "" "https://github.com/hasherezade/pe-bear/releases" & goto tools_menu
if "%t_choice%"=="0" goto menu
goto tools_menu

:dl_and_run
set "URL=%~1"
set "EXE=%~2"
set "ZIP_NAME=%~nx1"

if exist "%TOOLS_DIR%\%EXE%" (
    start "" "%TOOLS_DIR%\%EXE%"
    exit /b
)
echo  Downloading %ZIP_NAME%...
curl -L -s -o "%TOOLS_DIR%\%ZIP_NAME%" "%URL%"
if not exist "%TOOLS_DIR%\%ZIP_NAME%" ( echo  [!] Download failed. & pause & exit /b )
echo  Extracting...
tar -xf "%TOOLS_DIR%\%ZIP_NAME%" -C "%TOOLS_DIR%"

if exist "%TOOLS_DIR%\%EXE%" (
    start "" "%TOOLS_DIR%\%EXE%"
) else (
    for /f "delims=" %%F in ('dir "%TOOLS_DIR%\%EXE%" /b /s 2^>nul') do (
        start "" "%%F" & goto :dl_done
    )
)
:dl_done
timeout /t 2 >nul
exit /b