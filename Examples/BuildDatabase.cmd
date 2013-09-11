@echo off
rem ************************************************************
rem
rem Build the Examples database and install the SS-Unit
rem framework into it.
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

if /i not "%2" == "" set database=%2

echo.
echo ----------------------------------------
echo Creating '%database%' database
echo ----------------------------------------
echo.

sqlcmd -E -S %server% -d master -i CreateDatabase.dbo.sql -v DatabaseName=%database%

for /f "delims=" %%f in (object-scripts.txt) do (
	echo %%f
	sqlcmd -E -S %server% -d %database% -b -i "%%f"
	if errorlevel 1 (
		echo ERROR: Failed to execute SQL script [!ERRORLEVEL!]
		exit /b 1
	)
)

pushd ..\Framework
call Install %server% %database%
popd
if errorlevel 1 (
	echo ERROR: Failed to install SS-Unit [!ERRORLEVEL!]
	exit /b 1
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
echo e.g.   %~n0 .\SQLEXPRESS
echo        %~n0 .\SQLEXPRESS Examples
goto :eof
