@echo off
title Building ENCRYPTED PC Optimizer EXE
color 0B

echo ================================================================
echo.
echo   SneakyBloop's PC Optimizer - ENCRYPTED BUILD v2.2
echo   Copyright (C) 2025-2026 SneakyBloop
echo.
echo ================================================================
echo.
echo This script will create an encrypted .exe using PyInstaller's
echo built-in AES-256 encryption (no PyArmor license required!)
echo.
echo Features:
echo   - AES-256 encryption of Python bytecode
echo   - Random encryption key generated
echo   - Cannot be easily decompiled
echo   - Single standalone .exe file
echo.
echo ================================================================
echo.

:: Activate virtual environment
call .venv\Scripts\activate.bat 2>nul

echo [Step 1/4] Checking dependencies...
echo ----------------------------------------------------------------

python -c "import PyInstaller" 2>nul
if %errorLevel% neq 0 (
    echo ERROR: PyInstaller not found! Installing...
    pip install pyinstaller
) else (
    echo [OK] PyInstaller found
)

echo.
echo [Step 2/4] Cleaning previous builds...
echo ----------------------------------------------------------------

if exist "dist" (
    rmdir /s /q dist
    echo [OK] Removed old dist folder
)

if exist "build" (
    rmdir /s /q build
    echo [OK] Removed old build folder
)

if exist "*.spec" (
    del /q *.spec
    echo [OK] Removed old .spec files
)

echo.
echo [Step 3/4] Generating random encryption key...
echo ----------------------------------------------------------------

:: Generate a random 16-character key using PowerShell
for /f %%i in ('powershell -command "-join ((65..90) + (97..122) + (48..57) | Get-Random -Count 16 | ForEach-Object {[char]$_})"') do set ENCRYPT_KEY=%%i

echo [OK] Encryption key generated: %ENCRYPT_KEY%
echo NOTE: This key will be embedded in the .exe

echo.
echo [Step 4/4] Building encrypted executable...
echo ----------------------------------------------------------------
echo.
echo This may take 1-2 minutes...
echo.

:: Build with PyInstaller using AES-256 encryption
pyinstaller --noconfirm ^
    --onefile ^
    --console ^
    --icon=NONE ^
    --name="PC_Optimizer_v2.2" ^
    --key="%ENCRYPT_KEY%" ^
    --add-data=".venv/Lib/site-packages/wmi;wmi" ^
    --hidden-import=wmi ^
    --hidden-import=win32com ^
    --hidden-import=pythoncom ^
    --hidden-import=psutil ^
    --uac-admin ^
    --clean ^
    --noupx ^
    pc_optimizer_v2.py

echo.
echo ================================================================
echo.

if exist "dist\PC_Optimizer_v2.2.exe" (
    echo [SUCCESS] Encrypted executable created!
    echo.
    echo Location: dist\PC_Optimizer_v2.2.exe
    echo.
    echo File Details:
    for %%A in ("dist\PC_Optimizer_v2.2.exe") do (
        echo   Size: %%~zA bytes
        echo   Date: %%~tA
    )
    echo.
    echo Encryption: AES-256 with key: %ENCRYPT_KEY%
    echo.
    echo ================================================================
    echo.
    echo SECURITY NOTES:
    echo   - Python bytecode is encrypted with AES-256
    echo   - Reverse engineering is significantly harder
    echo   - Source code structure is obfuscated
    echo   - Not as strong as PyArmor PRO, but good protection
    echo.
    echo You can now distribute this .exe file!
    echo No Python installation required on target PCs.
    echo.
    echo ================================================================
) else (
    echo.
    echo [ERROR] Build failed!
    echo.
    echo Troubleshooting:
    echo   1. Check that pc_optimizer_v2.py exists
    echo   2. Make sure virtual environment is activated
    echo   3. Try: pip install --upgrade pyinstaller
    echo   4. Check build.log for details
    echo.
)

echo.
pause
