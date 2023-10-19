@echo off
del /f %appdata%\SS\Alts.txt 2>nul
mkdir %appdata%\SS
setlocal enabledelayedexpansion
if exist C:\Users\%username%\.lunarclient\settings\game\accounts.json (
    echo ==Lunar Accounts== >> %appdata%\SS\Alts.txt
    findstr /C:"username" C:\Users\%username%\.lunarclient\settings\game\accounts.json >> %appdata%\SS\Alts.txt
)
if exist %appdata%\.minecraft (
echo ==.minecraft Accounts== >> %appdata%\SS\Alts.txt
findstr /c:"name" "%appdata%\.minecraft\usercache.json" >> %appdata%\SS\Alts.txt
if exist %appdata%\.minecraft\cosmic\accounts.json (
    echo ==Cosmic Client Accounts== >> %appdata%\SS\Alts.txt
    findstr /C:"displayName" "%appdata%\.minecraft\cosmic\accounts.json" >> %appdata%\SS\Alts.txt
    )
)
if exist %appdata%\.tlauncher\legacy\Minecraft\game\tlauncher_profiles.json (
    echo ==Tlauncher Accounts== >> %appdata%\SS\Alts.txt
    findstr /C:"username" "%appdata%\.tlauncher\legacy\Minecraft\game\tlauncher_profiles.json" >> %appdata%\SS\Alts.txt
)
if exist %appdata%\.minecraft\TlauncherProfiles.json (
    echo ==other TLauncher Accounts== >> %appdata%\SS\Alts.txt
    findstr /C:"displayName" "%appdata%\.minecraft\TlauncherProfiles.json" >> %appdata%\SS\Alts.txt
)
if exist %appdata%\Orbit-Launcher\launcher-minecraft\cachedImages\faces\*.png (
    echo ==Orbit Accounts== >> %appdata%\SS\Alts.txt
for %%F in ("%appdata%\Orbit-Launcher\launcher-minecraft\cachedImages\faces\*.png") do (
    set "fileName=%%~nF"
    echo !fileName!>> "%appdata%\SS\Alts.txt"
    )
)
if exist %appdata%\Badlion Client\logs\launcher (
    echo ==Badlion Accounts== >> %appdata%\SS\Alts.txt
for /r "%appdata%\Badlion Client\logs\launcher" %%F in (*) do (
    findstr /C:"Found user" "%%F" >nul
    if not errorlevel 1 (
        for /F "tokens=2 delims=|" %%G in ('findstr /C:"Found user" "%%F"') do (
            echo %%G >> %appdata%\SS\Alts.txt
              )
            )
    )
)
endlocal

notepad %appdata%\SS\Alts.txt
exit /b