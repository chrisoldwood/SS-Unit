/**
 * \file
 * \brief  Unit tests for the version UDF.
 * \author Chris Oldwood
 */

create procedure test._@Test@_Version_ShouldReturnCurrentVersion
as
	declare @expected ssunit.Version = 160;
	declare @actual ssunit.Version = ssunit.Version();

	exec ssunit.AssertIntegerEqualTo @expected, @actual;
go

exec ssunit.RunTests;
