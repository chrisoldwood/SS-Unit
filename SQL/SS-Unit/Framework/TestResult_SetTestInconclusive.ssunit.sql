/**
 * \file   TestResult_SetTestInconclusive.ssunit.sql
 * \brief  The TestResult_SetTestInconclusive stored procedure.
 * \author Chris Oldwood
 */

if (object_id('ssunit.TestResult_SetTestInconclusive') is not null)
	drop procedure ssunit.TestResult_SetTestInconclusive;
go

/**
 * Stores the outcome of the test as inconclusive.
 */

create procedure ssunit.TestResult_SetTestInconclusive
(
	@procedure	ssunit.ProcedureName	--!< The name of the unit test procedure
)
as
	--begin try
		begin transaction;

		insert into ssunit.TestResult
		(
			TestProcedure,
			Outcome,
			FailureReason
		)
		values
		(
			@procedure,
			ssunit.TestOutcome_Unknown(),
			null
		);

		commit transaction;
	--end try
	--begin catch
	--end catch
go
