/*******************************************************************************
**! \file   TestResult_DeleteResult.ssunit.sql
**! \brief  The TestResult_DeleteResult stored procedure.
**! \author Chris Oldwood
**/

if (object_id('ssunit.TestResult_DeleteResult') is not null)
	drop procedure ssunit.TestResult_DeleteResult;
go

/*******************************************************************************
** Delete the result of the specified test.
**/

create procedure ssunit.TestResult_DeleteResult
(
	@procedure	ssunit.ProcedureName	-- The name of the unit test procedure
)
as
	--begin try
		begin transaction;

		delete	TestResult
		where	TestProcedure = @procedure;

		commit transaction;
	--end try
	--begin catch
	--end catch
go
