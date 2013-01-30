@echo off
rem ************************************************************
rem
rem Run the set of tests and apply some filters to try and
rem highlight tests which are actually failing. This is done by
rem matching the test outcome (passed or failed) with the test
rem name that includes the phrase 'ShouldPass' or 'ShouldFail'.
rem
rem We also have a few normal tests that should only ever pass
rem but don't have 'ShouldPass' in the test name so they are
rem manually matched at the end.
rem
rem ************************************************************

call RunTests .\SQLEXPRESS --testsonly ^
     | egrep "^(Passed|FAILED)" ^
     | egrep -v "Passed[ ]+Failed[ ]+Unknown" ^
     | egrep -v "^Passed.*+ShouldPass" ^
     | egrep -v "^FAILED.*+ShouldFail" ^
     | egrep -v "^Passed.*GetFixtureName" ^
     | egrep -v "^Passed.*ShouldReturn" ^
     | egrep -v "^Passed.*ShouldHandle" ^
     | egrep -v "^Passed.*FormatResultTestName" ^
     | egrep -v "^Passed.*Set\w+Default" ^
     | egrep -v "^Passed.*ReportCondition"
