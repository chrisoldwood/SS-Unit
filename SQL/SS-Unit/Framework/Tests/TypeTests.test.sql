/**
 * \file
 * \brief  Unit tests for the public types.
 * \author Chris Oldwood
 */

create procedure test._@Test@_False_ShouldReturnZero
as
	declare @actual ssunit.Bool = ssunit.False();

	exec ssunit.AssertIntegerEqualTo 0, @actual;
go

create procedure test._@Test@_True_ShouldReturnOne
as
	declare @actual ssunit.Bool = ssunit.True();

	exec ssunit.AssertIntegerEqualTo 1, @actual;
go

create procedure test._@Test@_ToString_ShouldReturnFalseString_WhenZero
as
	declare @false ssunit.Bool = ssunit.False();
	declare @actual ssunit.BoolDisplayString = ssunit.Bool_ToString(@false);

	exec ssunit.AssertStringEqualTo 'false', @actual;
go

create procedure test._@Test@_ToString_ShouldReturnTrueString_WhenOne
as
	declare @true ssunit.Bool = ssunit.True();
	declare @actual ssunit.BoolDisplayString = ssunit.Bool_ToString(@true);

	exec ssunit.AssertStringEqualTo 'true', @actual;
go

exec ssunit.RunTests;
