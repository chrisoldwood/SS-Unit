@echo off

setlocal
set server=%1
set database=%2

echo Creating 'ssunit' objects...

sqlcmd -E -S %server% -d %database% -i CreateSchema.ssunit.sql

sqlcmd -E -S %server% -d %database% -i ProcedureName.ssunit.sql
sqlcmd -E -S %server% -d %database% -i TestOutcome.ssunit.sql
sqlcmd -E -S %server% -d %database% -i TextMessage.ssunit.sql

sqlcmd -E -S %server% -d %database% -i CurrentTest.ssunit.sql
sqlcmd -E -S %server% -d %database% -i TestResult.ssunit.sql

sqlcmd -E -S %server% -d %database% -i TestOutcome_Unknown.ssunit.sql
sqlcmd -E -S %server% -d %database% -i TestOutcome_Passed.ssunit.sql
sqlcmd -E -S %server% -d %database% -i TestOutcome_Failed.ssunit.sql
sqlcmd -E -S %server% -d %database% -i TestOutcome_ToString.ssunit.sql

sqlcmd -E -S %server% -d %database% -i CurrentTest_SetTest.ssunit.sql
sqlcmd -E -S %server% -d %database% -i CurrentTest_TestName.ssunit.sql
sqlcmd -E -S %server% -d %database% -i TestResult_TestOutcome.ssunit.sql
sqlcmd -E -S %server% -d %database% -i TestResult_Clear.ssunit.sql
sqlcmd -E -S %server% -d %database% -i TestResult_SetTestInconclusive.ssunit.sql
sqlcmd -E -S %server% -d %database% -i TestResult_SetTestPassed.ssunit.sql
sqlcmd -E -S %server% -d %database% -i TestResult_SetTestFailed.ssunit.sql
sqlcmd -E -S %server% -d %database% -i TestResult_DeleteResult.ssunit.sql

sqlcmd -E -S %server% -d %database% -i AssertPass.ssunit.sql
sqlcmd -E -S %server% -d %database% -i AssertFail.ssunit.sql
sqlcmd -E -S %server% -d %database% -i AssertThrew.ssunit.sql

sqlcmd -E -S %server% -d %database% -i FormatIntegerNullFailure.ssunit.sql
sqlcmd -E -S %server% -d %database% -i FormatIntegerCompareFailure.ssunit.sql
sqlcmd -E -S %server% -d %database% -i AssertIntegerEqualTo.ssunit.sql
sqlcmd -E -S %server% -d %database% -i AssertIntegerNotEqualTo.ssunit.sql
sqlcmd -E -S %server% -d %database% -i AssertIntegerIsNull.ssunit.sql

sqlcmd -E -S %server% -d %database% -i AssertTrue.ssunit.sql
sqlcmd -E -S %server% -d %database% -i AssertFalse.ssunit.sql

sqlcmd -E -S %server% -d %database% -i FormatStringNullFailure.ssunit.sql
sqlcmd -E -S %server% -d %database% -i FormatStringCompareFailure.ssunit.sql
sqlcmd -E -S %server% -d %database% -i AssertStringEqualTo.ssunit.sql
sqlcmd -E -S %server% -d %database% -i AssertStringNotEqualTo.ssunit.sql
sqlcmd -E -S %server% -d %database% -i AssertStringIsNull.ssunit.sql

sqlcmd -E -S %server% -d %database% -i FormatDateTimeNullFailure.ssunit.sql
sqlcmd -E -S %server% -d %database% -i FormatDateTimeCompareFailure.ssunit.sql
sqlcmd -E -S %server% -d %database% -i AssertDateTimeEqualTo.ssunit.sql
sqlcmd -E -S %server% -d %database% -i AssertDateTimeNotEqualTo.ssunit.sql
sqlcmd -E -S %server% -d %database% -i AssertDateTimeIsNull.ssunit.sql

sqlcmd -E -S %server% -d %database% -i IsInteractive.ssunit.sql
sqlcmd -E -S %server% -d %database% -i RunTest.ssunit.sql
sqlcmd -E -S %server% -d %database% -i RunTests.ssunit.sql
