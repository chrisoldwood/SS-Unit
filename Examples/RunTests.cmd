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
set database=SQL_Unit_Examples
set failed=false

if /i not "%2" == "" set database=%2

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
	if !errorlevel! neq 0 set failed=true
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
echo Usage: %~n0 ^<db server^> [^<db name^>]
echo.
echo e.g.   %~n0 .\SQLEXPRESS
echo        %~n0 .\SQLEXPRESS Examples
echo.
echo Note: The default database name is SQL_Unit_Examples.
goto :eof
