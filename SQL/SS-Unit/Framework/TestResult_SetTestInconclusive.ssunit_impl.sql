/**
 * \file
 * \brief  The TestResult_SetTestInconclusive stored procedure.
 * \author Chris Oldwood
 */

if (object_id('ssunit_impl.TestResult_SetTestInconclusive') is not null)
	drop procedure ssunit_impl.TestResult_SetTestInconclusive;
go

/**
 * Stores the outcome of the test as inconclusive.
 */

create procedure ssunit_impl.TestResult_SetTestInconclusive
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
			ssunit_impl.TestOutcome_Unknown(),
			null
		);

		commit transaction;
	--end try
	--begin catch
	--end catch
go
