@echo off
rem ************************************************************
rem
rem Run the set of tests and apply some filters to try and
rem highlight tests which are actually failing. This is done by
rem matching the test outcome (passed or failed) with the test
rem name that includes the phrase ShouldPass or ShouldFail.
rem
rem ************************************************************

call RunTests .\SQLEXPRESS --testsonly ^
     | egrep "^(Passed|FAILED)" ^
     | egrep -v "Passed[ ]+Failed[ ]+Unknown" ^
     | egrep -v "^Passed.*+ShouldPass" ^
     | egrep -v "^FAILED.*+ShouldFail" ^
     | egrep -v "^Passed.*GetFixtureName"
