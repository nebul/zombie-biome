@echo off

REM Check if LÖVE is installed
where love >nul 2>nul
if %errorlevel% neq 0 (
    echo LÖVE is not installed. Please install it to run this game.
    echo You can download it from https://love2d.org
    pause
    exit /b 1
)

REM Run the game
love .

REM Check if the game exited with an error
if %errorlevel% neq 0 (
    echo The game exited with an error. Press any key to close this window.
    pause >nul
)