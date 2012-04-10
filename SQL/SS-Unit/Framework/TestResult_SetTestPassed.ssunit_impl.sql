/**
 * \file
 * \brief  The TestResult_SetTestPassed stored procedure.
 * \author Chris Oldwood
 */

if (object_id('ssunit_impl.TestResult_SetTestPassed') is not null)
	drop procedure ssunit_impl.TestResult_SetTestPassed;
go

/**
 * Stores the outcome of the test as successul.
 */

create procedure ssunit_impl.TestResult_SetTestPassed
(
	@procedure	ssunit.ProcedureName	--!< The name of the unit test procedure
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
			ssunit_impl.TestOutcome_Passed(),
			null
		);

		commit transaction;
	--end try
	--begin catch
	--end catch
go
