@echo off

setlocal
set server=%1
set database=SSUnit_Tests

echo Creating database...
sqlcmd -E -S %server% -d master -Q "drop database %database%;"
sqlcmd -E -S %server% -d master -Q "create database %database%;"

echo Creating 'dbo' sample objects...
sqlcmd -E -S %server% -d %database% -i GetIntegerValue.dbo.sql
sqlcmd -E -S %server% -d %database% -i GetStringValue.dbo.sql
sqlcmd -E -S %server% -d %database% -i GetDateTimeValue.dbo.sql

pushd ..
call Install %server% %database%
popd


echo Creating 'test' objects...
sqlcmd -E -S %server% -d %database% -i CreateSchema.test.sql

echo Running tests...
echo.
sqlcmd -E -S %server% -d %database% -i BasicAsserts.test.sql
echo.
sqlcmd -E -S %server% -d %database% -i IntegerAsserts.test.sql
echo.
sqlcmd -E -S %server% -d %database% -i StringAsserts.test.sql
echo.
sqlcmd -E -S %server% -d %database% -i DateTimeAsserts.test.sql
