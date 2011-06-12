/*******************************************************************************
**! \file   TestResult_TestOutcome.ssunit.sql
**! \brief  The TestResult_TestOutcome user-defined function.
**! \author Chris Oldwood
**/

if (object_id('ssunit.TestResult_TestOutcome') is not null)
	drop function ssunit.TestResult_TestOutcome;
go

/*******************************************************************************
** Retrieves the outcome of the specified test.
**/

create function ssunit.TestResult_TestOutcome
(
	@procedure	ssunit.ProcedureName	-- The name of the unit test procedure
)
	returns ssunit.TestOutcome
as
begin
	declare	@outcome ssunit.TestOutcome

	select	@outcome = tr.Outcome
	from	TestResult tr
	where	tr.TestProcedure = @procedure;

	return @outcome
end
go
