@echo off
rem ************************************************************
rem
rem Build the Examples database and install the SQL-Unit
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
set database=SQL_Unit_Examples
set usePsInstaller=0

:parse_args
set arg=%2
if /i "%2" == "" goto :build_database

:check_db_name
if /i "%arg:~0,2%" == "--" goto :check_switches
if /i not "%arg%" == "" set database=%2

:check_switches
if /i "%arg%" == "--use-ps" set usePsInstaller=1

shift /2
goto :parse_args

:build_database
echo.
echo ----------------------------------------
echo Creating '%database%' database
echo ----------------------------------------
echo.

sqlcmd -E -S %server% -d master -b -i CreateDatabase.dbo.sql -v DatabaseName=%database%
if !errorlevel! neq 0 exit /b !errorlevel!

if "%usePsInstaller%" == "0" (
	for /f "delims=" %%f in (object-scripts.txt) do (
		echo %%f
		sqlcmd -E -S %server% -d %database% -b -i "%%f"
		if !errorlevel! neq 0 (
			echo ERROR: Failed to execute SQL script [!errorlevel!]
			exit /b !errorlevel!
		)
	)
) else (
	PowerShell -File ..\Framework\ApplyScripts.ps1 %server% %database% object-scripts.txt
	if !errorlevel! neq 0 (
		echo ERROR: Failed to build examples database [!errorlevel!]
		exit /b !errorlevel!
	)
)

pushd ..\Framework
if "%usePsInstaller%" == "0" (
	call Install %server% %database%
) else (
	call Install-ps %server% %database%
)
popd
if !errorlevel! neq 0 (
	echo ERROR: Failed to install SQL-Unit [!errorlevel!]
	exit /b !errorlevel!
)

:success
exit /b 0

rem ************************************************************
rem Functions
rem ************************************************************

:usage
echo.
echo Usage: %~n0 ^<db server^> [^<db name^>] [--use-ps]
echo.
echo e.g.   %~n0 .\SQLEXPRESS
echo        %~n0 .\SQLEXPRESS Examples
echo.
echo Note: The default database name is SQL_Unit_Examples.
goto :eof
