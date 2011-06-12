/*******************************************************************************
**! \file   TestOutcome_Failed.ssunit.sql
**! \brief  The TestOutcome_Failed user defined function.
**! \author Chris Oldwood
**/

if (object_id('ssunit.TestOutcome_Failed') is not null)
	drop function ssunit.TestOutcome_Failed;
go

/*******************************************************************************
** The TestOutcome enumeration symbol for a test that has 'passed'.
**/

create function ssunit.TestOutcome_Failed() returns tinyint
as
begin
	return 3;
end
go
