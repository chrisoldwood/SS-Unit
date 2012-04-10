/**
 * \file   CurrentTest_SetTest.ssunit.sql
 * \brief  The CurrentTest_SetTest stored procedure.
 * \author Chris Oldwood
 */

if (object_id('ssunit.CurrentTest_SetTest') is not null)
	drop procedure ssunit.CurrentTest_SetTest;
go

/**
 * Stores the details of the currently running test so the framework doesn't
 * have to pass them 'through' the test.
 */

create procedure ssunit.CurrentTest_SetTest
(
	@procedure ssunit.ProcedureName		--!< The name of the procedure to execute
)
as
	begin transaction

	truncate table ssunit.CurrentTest

	insert into ssunit.CurrentTest
	(
		TestProcedure
	)
	values
	(
		@procedure
	)

	commit transaction
go
