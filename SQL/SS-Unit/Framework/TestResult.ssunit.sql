/*******************************************************************************
**! \file   TestResult.ssunit.sql
**! \brief  The TestResult table.
**! \author Chris Oldwood
**/

if (object_id('ssunit.TestResult') is not null)
	drop table ssunit.TestResult;
go

/*******************************************************************************
** The table that stores the results of each unit test that is run.
**/

create table ssunit.TestResult
(
	-- The test stored procedure.
	TestProcedure ssunit.ProcedureName not null primary key clustered,

	-- The test outcome.
	Outcome ssunit.TestOutcome not null,	

	-- The reason the test failed.
	FailureReason ssunit.TextMessage null,	

	-- The order the results were inserted.
	TestOrder int not null identity
);
go
