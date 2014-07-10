@echo off
rem ************************************************************
rem
rem Create the SS-Unit framework objects inside the specified
rem database . This version uses PowerShell to execute the
rem scripts.
rem
rem ************************************************************

:handle_help_request
if /i "%1" == "-?"     call :usage & exit /b 0
if /i "%1" == "--help" call :usage & exit /b 0

:check_mandatory_args
if /i "%1" == "" call :usage & exit /b 1
if /i "%2" == "" call :usage & exit /b 1

:set_vars
setlocal
setlocal enabledelayedexpansion
set server=%1
set database=%2

echo.
echo ----------------------------------------
echo Installing SS-Unit framework
echo ----------------------------------------
echo.
PowerShell -File ApplyScripts.ps1 %server% %database% filelist.txt
if !errorlevel! neq 0 (
	echo ERROR: Failed to install framework [!errorlevel!]
	exit /b !errorlevel!
)

:success
exit /b 0

rem ************************************************************
rem Functions
rem ************************************************************

:usage
echo.
echo Usage: %~n0 ^<db server^> ^<db name^>
echo.
echo e.g.   %~n0 .\SQLEXPRESS SSUnit_Examples
goto :eof
