/**
 * \file   RunTest.ssunit.sql
 * \brief  The RunTest stored procedure.
 * \author Chris Oldwood
 */

if (object_id('ssunit.RunTest') is not null)
	drop procedure ssunit.RunTest;
go

/**
 * Runs a single unit test.
 */

create procedure ssunit.RunTest
(
	@procedure			ssunit.ProcedureName,	--!< The unit test procedure.
	@setUpProcedure		ssunit.ProcedureName,	--!< The test set up procedure.
	@tearDownProcedure	ssunit.ProcedureName	--!< The test tear down procedure.
)
as
	begin try

		if (@setUpProcedure is not null)
			exec @setUpProcedure;

		exec @procedure;

		if (@tearDownProcedure is not null)
			exec @tearDownProcedure;

		if (ssunit.TestResult_TestOutcome(@procedure) is null)
		begin
			exec ssunit.TestResult_SetTestInconclusive @procedure = @procedure;
		end

	end try
	begin catch

		if (@@trancount != 0)
		begin
			rollback transaction;
		end

		declare @error ssunit.TextMessage;
		set		@error = error_message();

		exec ssunit.AssertFail @error;

	end catch
go
