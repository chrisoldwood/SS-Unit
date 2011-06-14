@echo off
rem ************************************************************
rem
rem Build a database and run a set of unit tests for the SS-Unit
rem framework.
rem
rem NB: Many of the tests are supposed to fail and so we cannot
rem use the "-b" switch and "errorlevel" to return a definitive
rem test suite result.
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
set database=SSUnit_Tests

:check_optional_args
if /i "%2" == "--testsonly" goto :run_tests

echo.
echo ----------------------------------------
echo Creating '%database%' database
echo ----------------------------------------
echo.

sqlcmd -E -S %server% -d master -i CreateDatabase.dbo.sql

for /f "delims=" %%f in (object-scripts.txt) do (
	echo %%f
	sqlcmd -E -S %server% -d %database% -b -i "%%f"
	if errorlevel 1 (
		echo ERROR: Failed to execute SQL script [!ERRORLEVEL!]
		exit /b 1
	)
)

pushd ..
call Install %server% %database%
popd
if errorlevel 1 (
	echo ERROR: Failed to install SS-Unit [!ERRORLEVEL!]
	exit /b 1
)

:run_tests
echo.
echo ----------------------------------------
echo Running unit tests
echo (Failures are to be expected) 
echo ----------------------------------------
echo.

for /f "delims=" %%f in (test-scripts.txt) do (
	echo.
	echo ========================================
	echo %%f
	echo ========================================
	echo.
	sqlcmd -E -S %server% -d %database% -i "%%f"
	if errorlevel 1 (
		echo ERROR: Failed to execute SQL script [!ERRORLEVEL!]
		exit /b 1
	)
)

:success
exit /b 0

rem ************************************************************
rem Functions
rem ************************************************************

:usage
echo.
echo Usage: %~n0 ^<db server^> [--testsonly]
echo.
echo e.g.   %~n0 .\SQLEXPRESS
goto :eof
