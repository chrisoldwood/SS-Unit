/**
 * \file   IntegerAsserts.test.sql
 * \brief  Unit tests for the AssertInteger* functions.
 * \author Chris Oldwood
 */

create procedure test._@Test@_AssertIntegerEqualTo_ShouldPass_WhenValuesSimilar
as
	declare @actual int;
	set		@actual = dbo.GetIntegerValue();

	exec ssunit.AssertIntegerEqualTo 42, @actual;
go

create procedure test._@Test@_AssertIntegerEqualTo_ShouldFail_WhenValuesDiffer
as
	declare @actual int;
	set		@actual = dbo.GetIntegerValue();

	exec ssunit.AssertIntegerEqualTo 43, @actual;
go

create procedure test._@Test@_AssertIntegerEqualTo_ShouldFail_WhenExpectedValueIsNull
as
	declare @actual int;
	set		@actual = dbo.GetIntegerValue();

	exec ssunit.AssertIntegerEqualTo null, @actual;
go

create procedure test._@Test@_AssertIntegerEqualTo_ShouldFail_WhenActualValueIsNull
as
	declare @actual int;
	set		@actual = null;

	exec ssunit.AssertIntegerEqualTo 42, @actual;
go

create procedure test._@Test@_AssertIntegerNotEqualTo_ShouldPass_WhenValuesDiffer
as
	declare @actual int;
	set		@actual = dbo.GetIntegerValue();

	exec ssunit.AssertIntegerNotEqualTo 43, @actual;
go

create procedure test._@Test@_AssertIntegerNotEqualTo_ShouldFail_WhenValuesSimilar
as
	declare @actual int;
	set		@actual = dbo.GetIntegerValue();

	exec ssunit.AssertIntegerNotEqualTo 42, @actual;
go

create procedure test._@Test@_AssertIntegerNotEqualTo_ShouldFail_WhenExpectedValueIsNull
as
	declare @actual int;
	set		@actual = dbo.GetIntegerValue();

	exec ssunit.AssertIntegerNotEqualTo null, @actual;
go

create procedure test._@Test@_AssertIntegerNotEqualTo_ShouldFail_WhenActualValueIsNull
as
	declare @actual int;
	set		@actual = null;

	exec ssunit.AssertIntegerNotEqualTo 43, @actual;
go

create procedure test._@Test@_AssertIntegerIsNull_ShouldPass_WhenValueIsNull
as
	declare @actual int;
	set		@actual = null;

	exec ssunit.AssertIntegerIsNull @actual;
go

create procedure test._@Test@_AssertIntegerIsNull_ShouldFail_WhenValueIsNotNull
as
	declare @actual int;
	set		@actual = 42;

	exec ssunit.AssertIntegerIsNull @actual;
go

exec ssunit.RunTests;
