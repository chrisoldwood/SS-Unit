/*******************************************************************************
**! \file   TestOutcome_Passed.ssunit.sql
**! \brief  The TestOutcome_Passed user defined function.
**! \author Chris Oldwood
**/

if (object_id('ssunit.TestOutcome_Passed') is not null)
	drop function ssunit.TestOutcome_Passed;
go

/*******************************************************************************
** The TestOutcome enumeration symbol for a test that has 'passed'.
**/

create function ssunit.TestOutcome_Passed() returns tinyint
as
begin
	return 2;
end
go
