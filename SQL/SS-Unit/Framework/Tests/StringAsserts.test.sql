/*******************************************************************************
**! \file   StringAsserts.test.sql
**! \brief  Unit tests for the AssertString* functions.
**! \author Chris Oldwood
**/

create procedure test._@Test@_AssertStringEqualTo_ShouldPass_WhenValuesSimilar
as
	declare @actual varchar(max);
	set		@actual = dbo.GetStringValue();

	exec ssunit.AssertStringEqualTo '42', @actual;
go

create procedure test._@Test@_AssertStringEqualTo_ShouldFail_WhenValuesDiffer
as
	declare @actual varchar(max);
	set		@actual = dbo.GetStringValue();

	exec ssunit.AssertStringEqualTo '43', @actual;
go

create procedure test._@Test@_AssertStringEqualTo_ShouldFail_WhenExpectedValueIsNull
as
	declare @actual varchar(max);
	set		@actual = dbo.GetStringValue();

	exec ssunit.AssertStringEqualTo null, @actual;
go

create procedure test._@Test@_AssertStringEqualTo_ShouldFail_WhenActualValueIsNull
as
	declare @actual varchar(max);
	set		@actual = null;

	exec ssunit.AssertStringEqualTo '42', @actual;
go

create procedure test._@Test@_AssertStringNotEqualTo_ShouldPass_WhenValuesDiffer
as
	declare @actual varchar(max);
	set		@actual = dbo.GetStringValue();

	exec ssunit.AssertStringNotEqualTo '43', @actual;
go

create procedure test._@Test@_AssertStringNotEqualTo_ShouldFail_WhenValuesSimilar
as
	declare @actual varchar(max);
	set		@actual = dbo.GetStringValue();

	exec ssunit.AssertStringNotEqualTo '42', @actual;
go

create procedure test._@Test@_AssertStringNotEqualTo_ShouldFail_WhenExpectedValueIsNull
as
	declare @actual varchar(max);
	set		@actual = dbo.GetStringValue();

	exec ssunit.AssertStringNotEqualTo null, @actual;
go

create procedure test._@Test@_AssertStringNotEqualTo_ShouldFail_WhenActualValueIsNull
as
	declare @actual varchar(max);
	set		@actual = null;

	exec ssunit.AssertStringNotEqualTo '43', @actual;
go

create procedure test._@Test@_AssertStringIsNull_ShouldPass_WhenValueIsNull
as
	declare @actual varchar(max);
	set		@actual = null;

	exec ssunit.AssertStringIsNull @actual;
go

create procedure test._@Test@_AssertStringIsNull_ShouldFail_WhenValueIsNotNull
as
	declare @actual varchar(max);
	set		@actual = '42';

	exec ssunit.AssertStringIsNull @actual;
go

exec ssunit.RunTests;
