/**
 * \file   DateTimeAsserts.test.sql
 * \brief  Unit tests for the AssertDateTime* functions.
 * \author Chris Oldwood
 */

create procedure test._@Test@_AssertDateTimeEqualTo_ShouldPass_WhenValuesSimilar
as
	declare @actual datetime;
	set		@actual = dbo.GetDateTimeValue();

	exec ssunit.AssertDateTimeEqualTo '2001-01-01 01:01:01.010', @actual;
go

create procedure test._@Test@_AssertDateTimeEqualTo_ShouldFail_WhenValuesDiffer
as
	declare @actual datetime;
	set		@actual = dbo.GetDateTimeValue();

	exec ssunit.AssertDateTimeEqualTo '2003-03-03 03:03:03.030', @actual;
go

create procedure test._@Test@_AssertDateTimeEqualTo_ShouldFail_WhenExpectedValueIsNull
as
	declare @actual datetime;
	set		@actual = dbo.GetDateTimeValue();

	exec ssunit.AssertDateTimeEqualTo null, @actual;
go

create procedure test._@Test@_AssertDateTimeEqualTo_ShouldFail_WhenActualValueIsNull
as
	declare @actual datetime;
	set		@actual = null;

	exec ssunit.AssertDateTimeEqualTo '2001-01-01 01:01:01.010', @actual;
go

create procedure test._@Test@_AssertDateTimeNotEqualTo_ShouldPass_WhenValuesDiffer
as
	declare @actual datetime;
	set		@actual = dbo.GetDateTimeValue();

	exec ssunit.AssertDateTimeNotEqualTo '2003-03-03 03:03:03.030', @actual;
go

create procedure test._@Test@_AssertDateTimeNotEqualTo_ShouldFail_WhenValuesSimilar
as
	declare @actual datetime;
	set		@actual = dbo.GetDateTimeValue();

	exec ssunit.AssertDateTimeNotEqualTo '2001-01-01 01:01:01.010', @actual;
go

create procedure test._@Test@_AssertDateTimeNotEqualTo_ShouldFail_WhenExpectedValueIsNull
as
	declare @actual datetime;
	set		@actual = dbo.GetDateTimeValue();

	exec ssunit.AssertDateTimeNotEqualTo null, @actual;
go

create procedure test._@Test@_AssertDateTimeNotEqualTo_ShouldFail_WhenActualValueIsNull
as
	declare @actual datetime;
	set		@actual = null;

	exec ssunit.AssertDateTimeNotEqualTo '2003-03-03 03:03:03.030', @actual;
go

create procedure test._@Test@_AssertDateTimeIsNull_ShouldPass_WhenValueIsNull
as
	declare @actual datetime;
	set		@actual = null;

	exec ssunit.AssertDateTimeIsNull @actual;
go

create procedure test._@Test@_AssertDateTimeIsNull_ShouldFail_WhenValueIsNotNull
as
	declare @actual datetime;
	set		@actual = '2001-01-01 01:01:01.010';

	exec ssunit.AssertDateTimeIsNull @actual;
go

create procedure test._@Test@_AssertDateTimeLessThan_ShouldPass_WhenValueLessThan
as
	declare @actual datetime;
	set		@actual = dbo.GetDateTimeValue();

	exec ssunit.AssertDateTimeLessThan '2999-12-31', @actual;
go

create procedure test._@Test@_AssertDateTimeLessThan_ShouldFail_WhenValueNotLessThan
as
	declare @actual datetime;
	set		@actual = dbo.GetDateTimeValue();

	exec ssunit.AssertDateTimeLessThan '1999-12-31', @actual;
go

create procedure test._@Test@_AssertDateTimeLessThan_ShouldFail_WhenValuesAreEqual
as
	declare @actual datetime;
	set		@actual = dbo.GetDateTimeValue();

	exec ssunit.AssertDateTimeLessThan '2001-01-01 01:01:01.010', @actual;
go

create procedure test._@Test@_AssertDateTimeLessThan_ShouldFail_WhenExpectedValueIsNull
as
	declare @actual datetime;
	set		@actual = dbo.GetDateTimeValue();

	exec ssunit.AssertDateTimeLessThan null, @actual;
go

create procedure test._@Test@_AssertDateTimeLessThan_ShouldFail_WhenActualValueIsNull
as
	declare @actual datetime;
	set		@actual = null;

	exec ssunit.AssertDateTimeLessThan '2001-01-01 01:01:01.010', @actual;
go

create procedure test._@Test@_AssertDateTimeGreaterThan_ShouldPass_WhenValueGreaterThan
as
	declare @actual datetime;
	set		@actual = dbo.GetDateTimeValue();

	exec ssunit.AssertDateTimeGreaterThan '1999-12-31', @actual;
go

create procedure test._@Test@_AssertDateTimeGreaterThan_ShouldFail_WhenValueNotGreaterThan
as
	declare @actual datetime;
	set		@actual = dbo.GetDateTimeValue();

	exec ssunit.AssertDateTimeGreaterThan '2999-12-31', @actual;
go

create procedure test._@Test@_AssertDateTimeGreaterThan_ShouldFail_WhenValuesAreEqual
as
	declare @actual datetime;
	set		@actual = dbo.GetDateTimeValue();

	exec ssunit.AssertDateTimeGreaterThan '2001-01-01 01:01:01.010', @actual;
go

create procedure test._@Test@_AssertDateTimeGreaterThan_ShouldFail_WhenExpectedValueIsNull
as
	declare @actual datetime;
	set		@actual = dbo.GetDateTimeValue();

	exec ssunit.AssertDateTimeGreaterThan null, @actual;
go

create procedure test._@Test@_AssertDateTimeGreaterThan_ShouldFail_WhenActualValueIsNull
as
	declare @actual datetime;
	set		@actual = null;

	exec ssunit.AssertDateTimeGreaterThan '2001-01-01 01:01:01.010', @actual;
go

create procedure test._@Test@_AssertDateTimeLessThanOrEqualTo_ShouldPass_WhenValueLessThan
as
	declare @actual datetime;
	set		@actual = dbo.GetDateTimeValue();

	exec ssunit.AssertDateTimeLessThanOrEqualTo '2999-12-31', @actual;
go

create procedure test._@Test@_AssertDateTimeLessThanOrEqualTo_ShouldPass_WhenValuesAreEqual
as
	declare @actual datetime;
	set		@actual = dbo.GetDateTimeValue();

	exec ssunit.AssertDateTimeLessThanOrEqualTo '2001-01-01 01:01:01.010', @actual;
go

create procedure test._@Test@_AssertDateTimeLessThanOrEqualTo_ShouldFail_WhenValueNotLessThan
as
	declare @actual datetime;
	set		@actual = dbo.GetDateTimeValue();

	exec ssunit.AssertDateTimeLessThanOrEqualTo '1999-12-31', @actual;
go

create procedure test._@Test@_AssertDateTimeLessThanOrEqualTo_ShouldFail_WhenExpectedValueIsNull
as
	declare @actual datetime;
	set		@actual = dbo.GetDateTimeValue();

	exec ssunit.AssertDateTimeLessThanOrEqualTo null, @actual;
go

create procedure test._@Test@_AssertDateTimeLessThanOrEqualTo_ShouldFail_WhenActualValueIsNull
as
	declare @actual datetime;
	set		@actual = null;

	exec ssunit.AssertDateTimeLessThanOrEqualTo '2001-01-01 01:01:01.010', @actual;
go

create procedure test._@Test@_AssertDateTimeGreaterThanOrEqualTo_ShouldPass_WhenValueGreaterThan
as
	declare @actual datetime;
	set		@actual = dbo.GetDateTimeValue();

	exec ssunit.AssertDateTimeGreaterThanOrEqualTo '1999-12-31', @actual;
go

create procedure test._@Test@_AssertDateTimeGreaterThanOrEqualTo_ShouldPass_WhenValuesAreEqual
as
	declare @actual datetime;
	set		@actual = dbo.GetDateTimeValue();

	exec ssunit.AssertDateTimeGreaterThanOrEqualTo '2001-01-01 01:01:01.010', @actual;
go

create procedure test._@Test@_AssertDateTimeGreaterThanOrEqualTo_ShouldFail_WhenValueNotGreaterThan
as
	declare @actual datetime;
	set		@actual = dbo.GetDateTimeValue();

	exec ssunit.AssertDateTimeGreaterThanOrEqualTo '2999-12-31', @actual;
go

create procedure test._@Test@_AssertDateTimeGreaterThanOrEqualTo_ShouldFail_WhenExpectedValueIsNull
as
	declare @actual datetime;
	set		@actual = dbo.GetDateTimeValue();

	exec ssunit.AssertDateTimeGreaterThanOrEqualTo null, @actual;
go

create procedure test._@Test@_AssertDateTimeGreaterThanOrEqualTo_ShouldFail_WhenActualValueIsNull
as
	declare @actual datetime;
	set		@actual = null;

	exec ssunit.AssertDateTimeGreaterThanOrEqualTo '2001-01-01 01:01:01.010', @actual;
go

exec ssunit.RunTests;
