/**
 * \file
 * \brief  The CurrentTest_TestName user-defined function.
 * \author Chris Oldwood
 */

if (object_id('ssunit_impl.CurrentTest_TestName') is not null)
	drop function ssunit_impl.CurrentTest_TestName;
go

/**
 * Retrieves the name of the currently running test.
 */

create function ssunit_impl.CurrentTest_TestName() returns ssunit.ProcedureName
as
begin
	declare @procedure ssunit.ProcedureName

	select	@procedure = ct.TestProcedure
	from	ssunit_impl.CurrentTest ct

	return @procedure
end
go
