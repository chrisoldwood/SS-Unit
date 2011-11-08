/**
 * \file
 * \brief  Test to ensure alternate schemas can be used.
 * \author Chris Oldwood
 */

create procedure unit_test._@Test@_TestShouldExecuteAnd_ShouldPass_WhenSchemaNamePassedToRunTests
as
	exec ssunit.AssertPass;
go

declare @displayWidth int = case when (isnumeric('$(DisplayWidth)') = 0) then 80 else convert(int, '$(DisplayWidth)') end;

exec ssunit.RunTests @schemaName = 'unit_test',
					 @displayWidth = @displayWidth;
