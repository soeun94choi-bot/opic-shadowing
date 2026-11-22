@echo off
cd /d "%~dp0"
where py >nul 2>&1
if errorlevel 1 (
    echo Python launcher not found. Install Python or run: python -m http.server 8000
    pause
    exit /b 1
)
start "OPIc Local Server" cmd /k "py -m http.server 8000"
timeout /t 2 /nobreak >nul
start "" "http://localhost:8000/OPIc_Shadowing_Player_Drive.html"
echo If the player does not open, visit http://localhost:8000/OPIc_Shadowing_Player_Drive.html
