/**
 * \file
 * \brief  The TestResult_SetTestFailed stored procedure.
 * \author Chris Oldwood
 */

if (object_id('ssunit_impl.TestResult_SetTestFailed') is not null)
	drop procedure ssunit_impl.TestResult_SetTestFailed;
go

/**
 * Stores the outcome of the test as having failed.
 */

create procedure ssunit_impl.TestResult_SetTestFailed
(
	@procedure	ssunit.ProcedureName,	--!< The name of the unit test procedure
	@reason		ssunit.TextMessage		--!< The reason why the test failed.
)
as
	--begin try
		begin transaction;

		insert into ssunit_impl.TestResult
		(
			TestProcedure,
			Outcome,
			FailureReason
		)
		values
		(
			@procedure,
			ssunit_impl.TestOutcome_Failed(),
			@reason
		);

		commit transaction;
	--end try
	--begin catch
	--end catch
go
