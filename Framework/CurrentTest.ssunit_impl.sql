/**
 * \file
 * \brief  The CurrentTest table.
 * \author Chris Oldwood
 */

if (object_id('ssunit_impl.CurrentTest') is not null)
	drop table ssunit_impl.CurrentTest;
go

/**
 * The table that stores the details of the currently running test
 */

create table ssunit_impl.CurrentTest
(
	--! The test stored procedure.
	TestProcedure ssunit.ProcedureName not null primary key clustered,
);
go
