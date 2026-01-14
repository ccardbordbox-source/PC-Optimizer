@echo off
title Building PC Optimizer EXE
color 0E

echo ============================================================
echo  Building PC Health & Optimization Tool - Standalone EXE
echo ============================================================
echo.

:: Activate virtual environment and install PyInstaller if needed
call .venv\Scripts\activate.bat

echo Checking for PyInstaller...
python -c "import PyInstaller" 2>nul
if %errorLevel% neq 0 (
    echo PyInstaller not found. Installing...
    pip install pyinstaller
)

echo.
echo Building executable...
echo.

:: Build the EXE with optimal settings
pyinstaller --noconfirm ^
    --onefile ^
    --console ^
    --icon=NONE ^
    --name="PC_Optimizer_v2.2" ^
    --hidden-import=wmi ^
    --hidden-import=win32com ^
    --hidden-import=pythoncom ^
    --hidden-import=psutil ^
    --uac-admin ^
    --clean ^
    pc_optimizer_v2.py

echo.
echo ============================================================

if exist "dist\PC_Optimizer_v2.2.exe" (
    echo.
    echo SUCCESS! Executable created: dist\PC_Optimizer_v2.2.exe
    echo.
    echo File size:
    dir dist\PC_Optimizer_v2.2.exe | find "PC_Optimizer_v2.2.exe"
    echo.
    echo You can now distribute this single .exe file
    echo No Python installation needed on target PCs
    echo.
) else (
    echo.
    echo ERROR: Build failed!
    echo Check the output above for errors
    echo.
)

echo ============================================================
pause
