@echo off

setlocal
set server=%1
set database=SSUnit_Examples

echo Creating database...
sqlcmd -E -S %server% -d master -Q "drop database %database%;"
sqlcmd -E -S %server% -d master -Q "create database %database%;"

echo Creating 'dbo' objects...

pushd ..\Framework
call Install %server% %database%
popd

echo Creating 'test' objects...
sqlcmd -E -S %server% -d %database% -i CreateSchema.test.sql
