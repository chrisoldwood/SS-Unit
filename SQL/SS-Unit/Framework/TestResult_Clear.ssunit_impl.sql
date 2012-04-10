/**
 * \file
 * \brief  The TestResult_Clear stored procedure.
 * \author Chris Oldwood
 */

if (object_id('ssunit_impl.TestResult_Clear') is not null)
	drop procedure ssunit_impl.TestResult_Clear;
go

/**
 * Clears the table of test results.
 */

create procedure ssunit_impl.TestResult_Clear
as
	--begin try
		begin transaction;

		truncate table ssunit_impl.TestResult;

		commit transaction;
	--end try
	--begin catch
	--end catch
go
