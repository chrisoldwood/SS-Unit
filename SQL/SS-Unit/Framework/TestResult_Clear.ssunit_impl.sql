/**
 * \file   TestResult_Clear.ssunit.sql
 * \brief  The TestResult_Clear stored procedure.
 * \author Chris Oldwood
 */

if (object_id('ssunit.TestResult_Clear') is not null)
	drop procedure ssunit.TestResult_Clear;
go

/**
 * Clears the table of test results.
 */

create procedure ssunit.TestResult_Clear
as
	--begin try
		begin transaction;

		truncate table ssunit.TestResult;

		commit transaction;
	--end try
	--begin catch
	--end catch
go
