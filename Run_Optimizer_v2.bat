@echo off
title PC Health & Optimization Tool

:: Check for admin rights
net session >nul 2>&1
if %errorLevel% neq 0 (
    echo Requesting Administrator privileges...
    powershell -WindowStyle Hidden -Command "Start-Process '%~f0' -Verb RunAs"
    exit /b
)

:: Run the optimizer directly in CMD
cd /d "%~dp0"
color 0B
cls
.\.venv\Scripts\python.exe pc_optimizer_v2.py

:: Keep window open if there was an error
if %errorLevel% neq 0 (
    echo.
    echo An error occurred. Press any key to exit...
    pause >nul
)
