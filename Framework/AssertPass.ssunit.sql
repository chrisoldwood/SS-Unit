/**
 * \file
 * \brief  The AssertPass stored procedure.
 * \author Chris Oldwood
 */

if (object_id('ssunit.AssertPass') is not null)
	drop procedure ssunit.AssertPass;
go

/**
 * Asserts that the test has definitely passed.
 * NB: All other asserts are implemented in terms of this assert.
 */

create procedure ssunit.AssertPass
as
	declare @procedure ssunit.ProcedureName;
	set		@procedure = ssunit_impl.CurrentTest_TestName();

	declare	@outcome ssunit_impl.TestOutcome
	select	@outcome = ssunit_impl.TestResult_TestOutcome(@procedure);

	if (@outcome is null)
	begin
		exec ssunit_impl.TestResult_SetTestPassed @procedure = @procedure;
	end
go
