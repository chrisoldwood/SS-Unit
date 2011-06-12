/*******************************************************************************
**! \file   CurrentTest.ssunit.sql
**! \brief  The CurrentTest table.
**! \author Chris Oldwood
**/

if (object_id('ssunit.CurrentTest') is not null)
	drop table ssunit.CurrentTest;
go

/*******************************************************************************
** The table that stores the details of the currently running test
**/

create table ssunit.CurrentTest
(
	-- The test stored procedure.
	TestProcedure ssunit.ProcedureName not null primary key clustered,
);
go
