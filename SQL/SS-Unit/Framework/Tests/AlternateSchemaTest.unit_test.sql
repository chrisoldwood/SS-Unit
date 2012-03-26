/**
 * \file
 * \brief  Test to ensure alternate schemas can be used.
 * \author Chris Oldwood
 */

create procedure unit_test._@Test@_TestShouldExecuteAnd_ShouldPass_WhenSchemaNamePassedToRunTests
as
	exec ssunit.AssertPass;
go

exec ssunit.RunTests @schemaName = 'unit_test';
