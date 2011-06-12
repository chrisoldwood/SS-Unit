/*******************************************************************************
**! \file   TestResult_SetTestPassed.ssunit.sql
**! \brief  The TestResult_SetTestPassed stored procedure.
**! \author Chris Oldwood
**/

if (object_id('ssunit.TestResult_SetTestPassed') is not null)
	drop procedure ssunit.TestResult_SetTestPassed;
go

/*******************************************************************************
** Stores the outcome of the test as successul.
**/

create procedure ssunit.TestResult_SetTestPassed
(
	@procedure	ssunit.ProcedureName	-- The name of the unit test procedure
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
			ssunit.TestOutcome_Passed(),
			null
		);

		commit transaction;
	--end try
	--begin catch
	--end catch
go
