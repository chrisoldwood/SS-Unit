/*******************************************************************************
**! \file   AssertPass.ssunit.sql
**! \brief  The AssertPass stored procedure.
**! \author Chris Oldwood
**/

if (object_id('ssunit.AssertPass') is not null)
	drop procedure ssunit.AssertPass;
go

/*******************************************************************************
** Asserts that the test has definitely passed.
** NB: All other asserts are implemented in terms of this assert.
**/

create procedure ssunit.AssertPass
as
	declare @procedure ssunit.ProcedureName;
	set		@procedure = ssunit.CurrentTest_TestName();

	declare	@outcome ssunit.TestOutcome
	select	@outcome = ssunit.TestResult_TestOutcome(@procedure);

	if (@outcome is null)
	begin
		exec ssunit.TestResult_SetTestPassed @procedure = @procedure;
	end
go
