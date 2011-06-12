/*******************************************************************************
**! \file   TestOutcome_Unknown.ssunit.sql
**! \brief  The TestOutcome_Unknown user defined function.
**! \author Chris Oldwood
**/

if (object_id('ssunit.TestOutcome_Unknown') is not null)
	drop function ssunit.TestOutcome_Unknown;
go

/*******************************************************************************
** The TestOutcome enumeration symbol for a test that is inconclusive.
**/

create function ssunit.TestOutcome_Unknown() returns tinyint
as
begin
	return 1;
end
go
