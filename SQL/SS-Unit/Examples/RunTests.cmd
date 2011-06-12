@echo off

setlocal
set server=%1
set database=SSUnit_Examples

echo Running tests...
echo.
sqlcmd -E -S %server% -d %database% -i BasicAsserts.test.sql
