/**
 * \file   IntegerAsserts.test.sql
 * \brief  Unit tests for the AssertInteger* functions.
 * \author Chris Oldwood
 */

create procedure test._@Test@_AssertIntegerEqualTo_ShouldPass_WhenValuesAreEqual
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

create procedure test._@Test@_AssertIntegerNotEqualTo_ShouldFail_WhenValuesAreEqual
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

create procedure test._@Test@_AssertIntegerLessThan_ShouldPass_WhenValueLessThan
as
	declare @actual int;
	set		@actual = dbo.GetIntegerValue();

	exec ssunit.AssertIntegerLessThan 43, @actual;
go

create procedure test._@Test@_AssertIntegerLessThan_ShouldFail_WhenValueNotLessThan
as
	declare @actual int;
	set		@actual = dbo.GetIntegerValue();

	exec ssunit.AssertIntegerLessThan 41, @actual;
go

create procedure test._@Test@_AssertIntegerLessThan_ShouldFail_WhenValuesAreEqual
as
	declare @actual int;
	set		@actual = dbo.GetIntegerValue();

	exec ssunit.AssertIntegerLessThan 42, @actual;
go

create procedure test._@Test@_AssertIntegerLessThan_ShouldFail_WhenExpectedValueIsNull
as
	declare @actual int;
	set		@actual = dbo.GetIntegerValue();

	exec ssunit.AssertIntegerLessThan null, @actual;
go

create procedure test._@Test@_AssertIntegerLessThan_ShouldFail_WhenActualValueIsNull
as
	declare @actual int;
	set		@actual = null;

	exec ssunit.AssertIntegerLessThan 42, @actual;
go

create procedure test._@Test@_AssertIntegerGreaterThan_ShouldPass_WhenValueGreaterThan
as
	declare @actual int;
	set		@actual = dbo.GetIntegerValue();

	exec ssunit.AssertIntegerGreaterThan 41, @actual;
go

create procedure test._@Test@_AssertIntegerGreaterThan_ShouldFail_WhenValueNotGreaterThan
as
	declare @actual int;
	set		@actual = dbo.GetIntegerValue();

	exec ssunit.AssertIntegerGreaterThan 43, @actual;
go

create procedure test._@Test@_AssertIntegerGreaterThan_ShouldFail_WhenValuesAreEqual
as
	declare @actual int;
	set		@actual = dbo.GetIntegerValue();

	exec ssunit.AssertIntegerGreaterThan 42, @actual;
go

create procedure test._@Test@_AssertIntegerGreaterThan_ShouldFail_WhenExpectedValueIsNull
as
	declare @actual int;
	set		@actual = dbo.GetIntegerValue();

	exec ssunit.AssertIntegerGreaterThan null, @actual;
go

create procedure test._@Test@_AssertIntegerGreaterThan_ShouldFail_WhenActualValueIsNull
as
	declare @actual int;
	set		@actual = null;

	exec ssunit.AssertIntegerGreaterThan 42, @actual;
go

create procedure test._@Test@_AssertIntegerLessThanOrEqualTo_ShouldPass_WhenValueLessThan
as
	declare @actual int;
	set		@actual = dbo.GetIntegerValue();

	exec ssunit.AssertIntegerLessThanOrEqualTo 43, @actual;
go

create procedure test._@Test@_AssertIntegerLessThanOrEqualTo_ShouldPass_WhenValuesAreEqual
as
	declare @actual int;
	set		@actual = dbo.GetIntegerValue();

	exec ssunit.AssertIntegerLessThanOrEqualTo 42, @actual;
go

create procedure test._@Test@_AssertIntegerLessThanOrEqualTo_ShouldFail_WhenValueNotLessThan
as
	declare @actual int;
	set		@actual = dbo.GetIntegerValue();

	exec ssunit.AssertIntegerLessThanOrEqualTo 41, @actual;
go

create procedure test._@Test@_AssertIntegerLessThanOrEqualTo_ShouldFail_WhenExpectedValueIsNull
as
	declare @actual int;
	set		@actual = dbo.GetIntegerValue();

	exec ssunit.AssertIntegerLessThanOrEqualTo null, @actual;
go

create procedure test._@Test@_AssertIntegerLessThanOrEqualTo_ShouldFail_WhenActualValueIsNull
as
	declare @actual int;
	set		@actual = null;

	exec ssunit.AssertIntegerLessThanOrEqualTo 42, @actual;
go

create procedure test._@Test@_AssertIntegerGreaterThanOrEqualTo_ShouldPass_WhenValueGreaterThan
as
	declare @actual int;
	set		@actual = dbo.GetIntegerValue();

	exec ssunit.AssertIntegerGreaterThanOrEqualTo 41, @actual;
go

create procedure test._@Test@_AssertIntegerGreaterThanOrEqualTo_ShouldPass_WhenValuesAreEqual
as
	declare @actual int;
	set		@actual = dbo.GetIntegerValue();

	exec ssunit.AssertIntegerGreaterThanOrEqualTo 42, @actual;
go

create procedure test._@Test@_AssertIntegerGreaterThanOrEqualTo_ShouldFail_WhenValueNotGreaterThan
as
	declare @actual int;
	set		@actual = dbo.GetIntegerValue();

	exec ssunit.AssertIntegerGreaterThanOrEqualTo 43, @actual;
go

create procedure test._@Test@_AssertIntegerGreaterThanOrEqualTo_ShouldFail_WhenExpectedValueIsNull
as
	declare @actual int;
	set		@actual = dbo.GetIntegerValue();

	exec ssunit.AssertIntegerGreaterThanOrEqualTo null, @actual;
go

create procedure test._@Test@_AssertIntegerGreaterThanOrEqualTo_ShouldFail_WhenActualValueIsNull
as
	declare @actual int;
	set		@actual = null;

	exec ssunit.AssertIntegerGreaterThanOrEqualTo 42, @actual;
go

declare @displayWidth int = case when (isnumeric('$(DisplayWidth)') = 0) then 80 else convert(int, '$(DisplayWidth)') end;

exec ssunit.RunTests @displayWidth = @displayWidth;
