@echo off
setlocal
cd /d "%~dp0.."

where py >nul 2>nul
if %errorlevel%==0 (
    py scripts\reorganizar_cases.py
) else (
    python scripts\reorganizar_cases.py
)

if errorlevel 1 (
    echo.
    echo A migracao falhou. Nenhum commit foi realizado automaticamente.
    exit /b 1
)

echo.
echo Migracao concluida. Revise com: git status
endlocal
