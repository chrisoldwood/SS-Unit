/**
 * \file   CurrentTest_TestName.ssunit.sql
 * \brief  The CurrentTest_TestName user-defined function.
 * \author Chris Oldwood
 */

if (object_id('ssunit.CurrentTest_TestName') is not null)
	drop function ssunit.CurrentTest_TestName;
go

/**
 * Retrieves the name of the currently running test.
 */

create function ssunit.CurrentTest_TestName() returns ssunit.ProcedureName
as
begin
	declare @procedure ssunit.ProcedureName

	select	@procedure = ct.TestProcedure
	from	ssunit.CurrentTest ct

	return @procedure
end
go
