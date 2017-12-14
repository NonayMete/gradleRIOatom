@echo off
title Gradle-Rio
color 0a
< logfile.dat (
  set /p file=
)
:menu
cls
echo.
echo        ~=^> Menu ^<=~    Code folder: %file%
echo.
cmdmenusel 0aa0 " Build & Deploy Code" " Build Code" " Commit changes to local branch" " See changes made since last commit" " Push changes to GitHub" " Options" " Exit"
if %errorlevel% == 1 GOTO deploy
if %errorlevel% == 2 GOTO build
if %errorlevel% == 3 GOTO commit
if %errorlevel% == 4 GOTO diff
if %errorlevel% == 5 GOTO push
if %errorlevel% == 6 GOTO options
if %errorlevel% == 7 exit

:build
cls
echo Building program...
PowerShell -NoProfile -ExecutionPolicy Bypass -Command "& 'C:\Users\jakel\AppData\Local\atom\app-1.23.1\Compiler.ps1'"
set /a code = %errorlevel%
REM PowerShell -NoProfile -ExecutionPolicy Bypass -Command "& {Start-Process PowerShell -ArgumentList '-NoProfile -ExecutionPolicy Bypass -File ""C:\Users\jakel\AppData\Local\atom\app-1.23.1\testCompiler.ps1""' -Verb RunAs}"
if %code% == 0 cmdmenusel a00a "Excellent! :) It appears your code has compiled with no problems! Press enter to return..."
if %code% NEQ 0 cmdmenusel c00c "Ahh.. :( It appears your code has an error, check those pesky semicolons! Press enter to return..."
goto menu

:deploy
cls
echo Building program and attempting to deploy to robot...
PowerShell -NoProfile -ExecutionPolicy Bypass -Command "& 'C:\Users\jakel\AppData\Local\atom\app-1.23.1\Deployer.ps1'"
set /a code = %errorlevel%
if %code% == 0 cmdmenusel a00a "Excellent! :) It appears your code has deployed with no problems, happy driving! Press enter to return..."
if %code% NEQ 0 cmdmenusel c00c "Ahh.. :| It appears there has been an error, check your code and connection to the robot! Press enter to return..."
goto menu

:commit
cls
cd %file%
echo Commit recent changes...
set /p mess="Enter commit message: "
git commit -a -m "%mess%"
cd C:\Users\jakel\AppData\Local\atom\app-1.23.1
pause
echo %errorlevel%
goto menu

:diff
cls
cd %file%
echo Changes made since last commit...
git diff
cd C:\Users\jakel\AppData\Local\atom\app-1.23.1
pause
echo %errorlevel%
goto menu

:push
cls
cd %file%
echo Push commits to branch...
git push
cd C:\Users\jakel\AppData\Local\atom\app-1.23.1
pause
echo %errorlevel%
goto menu

:options
cls
cmdmenusel 0aa0 " Change code path" " Back"
if %errorlevel% == 2 GOTO menu
cls
set /p file="Enter program folder path: "
echo | set /p folder= "%file%" > logfile.dat
goto menu
