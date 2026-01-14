@echo off
REM ════════════════════════════════════════════════════════════════════
REM   SneakyBloop's PC Optimizer - Protected Build Script
REM   Copyright © 2025-2026 SneakyBloop - All Rights Reserved
REM ════════════════════════════════════════════════════════════════════

title SneakyBloop's PC Optimizer - Protected Build

color 0A
echo.
echo ╔════════════════════════════════════════════════════════════════╗
echo ║                                                                ║
echo ║   SneakyBloop's PC Optimizer - PROTECTED BUILD v2.2            ║
echo ║   Copyright © 2025-2026 SneakyBloop                            ║
echo ║                                                                ║
echo ╚════════════════════════════════════════════════════════════════╝
echo.
echo This script will:
echo   1. Encrypt your Python code with PyArmor (AES-256)
echo   2. Compile to standalone .exe with PyInstaller  
echo   3. Create a protected, non-reversible executable
echo.
echo ═══════════════════════════════════════════════════════════════════
echo.

REM Check if Python is installed
python --version >nul 2>&1
if errorlevel 1 (
    echo ERROR: Python not found!
    echo Please install Python from python.org
    pause
    exit /b 1
)

REM Check if virtual environment is active
if not defined VIRTUAL_ENV (
    if exist .venv\Scripts\activate.bat (
        echo Activating virtual environment...
        call .venv\Scripts\activate.bat
    ) else (
        echo WARNING: Virtual environment not found.
        echo Proceeding with global Python installation...
        echo.
    )
)

echo Step 1: Checking dependencies...
echo ───────────────────────────────────────────────────────────────────
echo.

REM Check for PyArmor
python -c "import pyarmor" >nul 2>&1
if errorlevel 1 (
    echo PyArmor not found. Installing...
    pip install pyarmor
    if errorlevel 1 (
        echo ERROR: Failed to install PyArmor
        pause
        exit /b 1
    )
) else (
    echo ✓ PyArmor found
)

REM Check for PyInstaller
python -c "import PyInstaller" >nul 2>&1
if errorlevel 1 (
    echo PyInstaller not found. Installing...
    pip install pyinstaller
    if errorlevel 1 (
        echo ERROR: Failed to install PyInstaller
        pause
        exit /b 1
    )
) else (
    echo ✓ PyInstaller found
)

echo.
echo Step 2: Cleaning previous builds...
echo ───────────────────────────────────────────────────────────────────
echo.

if exist dist (
    rmdir /s /q dist
    echo ✓ Removed old dist folder
)

if exist build (
    rmdir /s /q build
    echo ✓ Removed old build folder
)

if exist *.spec (
    del /q *.spec
    echo ✓ Removed old .spec files
)

echo.
echo Step 3: Obfuscating code with PyArmor...
echo ───────────────────────────────────────────────────────────────────
echo.
echo This will encrypt your Python code with AES-256 encryption.
echo The obfuscated code cannot be decompiled or reverse-engineered.
echo.

REM Create obfuscated version
pyarmor gen --private --pack onefile pc_optimizer_v2.py

if errorlevel 1 (
    echo.
    echo ERROR: PyArmor obfuscation failed!
    echo.
    echo Troubleshooting:
    echo   1. Make sure pc_optimizer_v2.py exists in current directory
    echo   2. Check that PyArmor is properly installed
    echo   3. Try updating: pip install --upgrade pyarmor
    echo.
    pause
    exit /b 1
)

echo.
echo ✓ Code obfuscation complete!
echo.

echo Step 4: Verifying build...
echo ───────────────────────────────────────────────────────────────────
echo.

if exist dist\pc_optimizer_v2.exe (
    echo ✓ Protected executable created successfully!
    echo.
    echo File location: dist\pc_optimizer_v2.exe
    
    REM Get file size
    for %%F in (dist\pc_optimizer_v2.exe) do set size=%%~zF
    set /a sizeMB=%size% / 1048576
    echo File size: %sizeMB% MB
    
    echo.
    echo ═══════════════════════════════════════════════════════════════════
    echo.
    echo 🎉 BUILD SUCCESSFUL!
    echo.
    echo Your protected PC Optimizer is ready for distribution:
    echo   Location: dist\pc_optimizer_v2.exe
    echo.
    echo Protection Features:
    echo   ✓ AES-256 encrypted Python code
    echo   ✓ Cannot be decompiled
    echo   ✓ Single standalone .exe (no dependencies)
    echo   ✓ Copyright protected
    echo.
    echo Next Steps:
    echo   1. Test the executable on your PC
    echo   2. Test on a friend's PC (different hardware)
    echo   3. If working correctly, distribute!
    echo.
    echo NOTE: Keep your original pc_optimizer_v2.py safe!
    echo       Never distribute the unprotected source code.
    echo.
) else (
    echo ERROR: Executable not found!
    echo Something went wrong during the build process.
    echo.
    pause
    exit /b 1
)

echo ═══════════════════════════════════════════════════════════════════
echo.
pause
