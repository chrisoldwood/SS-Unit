/*******************************************************************************
**! \file   AssertFail.ssunit.sql
**! \brief  The AssertFail stored procedure.
**! \author Chris Oldwood
**/

if (object_id('ssunit.AssertFail') is not null)
	drop procedure ssunit.AssertFail;
go

/*******************************************************************************
** Asserts that the test has failed for some reason.
** NB: All other asserts are implemented in terms of this assert.
**/

create procedure ssunit.AssertFail
(
	@reason	ssunit.TextMessage	-- The reason why the test failed.
)
as
	declare @procedure ssunit.ProcedureName;
	set		@procedure = ssunit.CurrentTest_TestName();

	declare	@outcome ssunit.TestOutcome
	select	@outcome = ssunit.TestResult_TestOutcome(@procedure);

	if (@outcome = ssunit.TestOutcome_Passed())
	begin
		exec ssunit.TestResult_DeleteResult @procedure = @procedure;

		set @outcome = null;
	end

	if (@outcome is null)
	begin
		exec ssunit.TestResult_SetTestFailed @procedure = @procedure,
											 @reason = @reason;
	end
go
