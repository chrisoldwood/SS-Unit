/**
 * \file
 * \brief  The TestResult_TestOutcome user-defined function.
 * \author Chris Oldwood
 */

if (object_id('ssunit_impl.TestResult_TestOutcome') is not null)
	drop function ssunit_impl.TestResult_TestOutcome;
go

/**
 * Retrieves the outcome of the specified test.
 */

create function ssunit_impl.TestResult_TestOutcome
(
	@procedure	ssunit.ProcedureName	--!< The name of the unit test procedure
)
	returns ssunit_impl.TestOutcome
as
begin
	declare	@outcome ssunit_impl.TestOutcome

	select	@outcome = tr.Outcome
	from	ssunit_impl.TestResult tr
	where	tr.TestProcedure = @procedure;

	return @outcome
end
go
