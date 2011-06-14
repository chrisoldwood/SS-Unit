@echo off
rem ************************************************************
rem
rem Run the Examples database unit tests.
rem
rem ************************************************************

:handle_help_request
if /i "%1" == "-?"     call :usage & exit /b 0
if /i "%1" == "--help" call :usage & exit /b 0

:check_mandatory_args
if /i "%1" == "" call :usage & exit /b 1

:set_vars
setlocal
setlocal enabledelayedexpansion
set server=%1
set database=SSUnit_Examples
set failed=false

:run_tests
echo.
echo ----------------------------------------
echo Running unit tests
echo ----------------------------------------
echo.

for /f "delims=" %%f in (test-scripts.txt) do (
	echo.
	echo ========================================
	echo %%f
	echo ========================================
	echo.
	sqlcmd -E -S %server% -d %database% -b -i "%%f"
	if errorlevel 1 set failed=true
)

if /i "%failed%" == "true" goto failed

:success
echo.
echo ----------------------------------------
echo --         Test run succeeded         --
echo ----------------------------------------
echo.
exit /b 0

:failed
echo.
echo ****************************************
echo *****        TEST RUN FAILED       *****
echo ****************************************
echo.
exit /b 1

rem ************************************************************
rem Functions
rem ************************************************************

:usage
echo.
echo Usage: %~n0 ^<db server^>
echo.
echo e.g.   %~n0 .\SQLEXPRESS
goto :eof
