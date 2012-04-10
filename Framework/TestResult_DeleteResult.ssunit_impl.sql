/**
 * \file
 * \brief  The TestResult_DeleteResult stored procedure.
 * \author Chris Oldwood
 */

if (object_id('ssunit_impl.TestResult_DeleteResult') is not null)
	drop procedure ssunit_impl.TestResult_DeleteResult;
go

/**
 * Delete the result of the specified test.
 */

create procedure ssunit_impl.TestResult_DeleteResult
(
	@procedure	ssunit.ProcedureName	--!< The name of the unit test procedure
)
as
	--begin try
		begin transaction;

		delete	ssunit_impl.TestResult
		where	TestProcedure = @procedure;

		commit transaction;
	--end try
	--begin catch
	--end catch
go
