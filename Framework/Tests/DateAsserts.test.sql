/**
 * \file
 * \brief  Unit tests for the AssertDate* functions.
 * \author Chris Oldwood
 */

create procedure test._@Test@_AssertDateEqualTo_ShouldPass_WhenValuesSimilar
as
	declare @actual datetime;
	set		@actual = dbo.GetDateValue();

	exec ssunit.AssertDateEqualTo '2001-01-01', @actual;
go

create procedure test._@Test@_AssertDateEqualTo_ShouldFail_WhenValuesDiffer
as
	declare @actual datetime;
	set		@actual = dbo.GetDateValue();

	exec ssunit.AssertDateEqualTo '2003-03-03', @actual;
go

create procedure test._@Test@_AssertDateEqualTo_ShouldFail_WhenExpectedValueIsNull
as
	declare @actual datetime;
	set		@actual = dbo.GetDateValue();

	exec ssunit.AssertDateEqualTo null, @actual;
go

create procedure test._@Test@_AssertDateEqualTo_ShouldFail_WhenActualValueIsNull
as
	declare @actual datetime;
	set		@actual = null;

	exec ssunit.AssertDateEqualTo '2001-01-01', @actual;
go

create procedure test._@Test@_AssertDateNotEqualTo_ShouldPass_WhenValuesDiffer
as
	declare @actual datetime;
	set		@actual = dbo.GetDateValue();

	exec ssunit.AssertDateNotEqualTo '2003-03-03', @actual;
go

create procedure test._@Test@_AssertDateNotEqualTo_ShouldFail_WhenValuesSimilar
as
	declare @actual datetime;
	set		@actual = dbo.GetDateValue();

	exec ssunit.AssertDateNotEqualTo '2001-01-01', @actual;
go

create procedure test._@Test@_AssertDateNotEqualTo_ShouldFail_WhenExpectedValueIsNull
as
	declare @actual datetime;
	set		@actual = dbo.GetDateValue();

	exec ssunit.AssertDateNotEqualTo null, @actual;
go

create procedure test._@Test@_AssertDateNotEqualTo_ShouldFail_WhenActualValueIsNull
as
	declare @actual datetime;
	set		@actual = null;

	exec ssunit.AssertDateNotEqualTo '2003-03-03', @actual;
go

create procedure test._@Test@_AssertDateIsNull_ShouldPass_WhenValueIsNull
as
	declare @actual datetime;
	set		@actual = null;

	exec ssunit.AssertDateIsNull @actual;
go

create procedure test._@Test@_AssertDateIsNull_ShouldFail_WhenValueIsNotNull
as
	declare @actual datetime;
	set		@actual = '2001-01-01';

	exec ssunit.AssertDateIsNull @actual;
go

create procedure test._@Test@_AssertDateIsNotNull_ShouldFail_WhenValueIsNull
as
	declare @actual datetime;
	set		@actual = null;

	exec ssunit.AssertDateIsNotNull @actual;
go

create procedure test._@Test@_AssertDateIsNotNull_ShouldPass_WhenValueIsNotNull
as
	declare @actual datetime;
	set		@actual = '2001-01-01';

	exec ssunit.AssertDateIsNotNull @actual;
go

create procedure test._@Test@_AssertDateLessThan_ShouldPass_WhenValueLessThan
as
	declare @actual datetime;
	set		@actual = dbo.GetDateValue();

	exec ssunit.AssertDateLessThan '2999-12-31', @actual;
go

create procedure test._@Test@_AssertDateLessThan_ShouldFail_WhenValueNotLessThan
as
	declare @actual datetime;
	set		@actual = dbo.GetDateValue();

	exec ssunit.AssertDateLessThan '1999-12-31', @actual;
go

create procedure test._@Test@_AssertDateLessThan_ShouldFail_WhenValuesAreEqual
as
	declare @actual datetime;
	set		@actual = dbo.GetDateValue();

	exec ssunit.AssertDateLessThan '2001-01-01', @actual;
go

create procedure test._@Test@_AssertDateLessThan_ShouldFail_WhenExpectedValueIsNull
as
	declare @actual datetime;
	set		@actual = dbo.GetDateValue();

	exec ssunit.AssertDateLessThan null, @actual;
go

create procedure test._@Test@_AssertDateLessThan_ShouldFail_WhenActualValueIsNull
as
	declare @actual datetime;
	set		@actual = null;

	exec ssunit.AssertDateLessThan '2001-01-01', @actual;
go

create procedure test._@Test@_AssertDateGreaterThan_ShouldPass_WhenValueGreaterThan
as
	declare @actual datetime;
	set		@actual = dbo.GetDateValue();

	exec ssunit.AssertDateGreaterThan '1999-12-31', @actual;
go

create procedure test._@Test@_AssertDateGreaterThan_ShouldFail_WhenValueNotGreaterThan
as
	declare @actual datetime;
	set		@actual = dbo.GetDateValue();

	exec ssunit.AssertDateGreaterThan '2999-12-31', @actual;
go

create procedure test._@Test@_AssertDateGreaterThan_ShouldFail_WhenValuesAreEqual
as
	declare @actual datetime;
	set		@actual = dbo.GetDateValue();

	exec ssunit.AssertDateGreaterThan '2001-01-01', @actual;
go

create procedure test._@Test@_AssertDateGreaterThan_ShouldFail_WhenExpectedValueIsNull
as
	declare @actual datetime;
	set		@actual = dbo.GetDateValue();

	exec ssunit.AssertDateGreaterThan null, @actual;
go

create procedure test._@Test@_AssertDateGreaterThan_ShouldFail_WhenActualValueIsNull
as
	declare @actual datetime;
	set		@actual = null;

	exec ssunit.AssertDateGreaterThan '2001-01-01', @actual;
go

create procedure test._@Test@_AssertDateLessThanOrEqualTo_ShouldPass_WhenValueLessThan
as
	declare @actual datetime;
	set		@actual = dbo.GetDateValue();

	exec ssunit.AssertDateLessThanOrEqualTo '2999-12-31', @actual;
go

create procedure test._@Test@_AssertDateLessThanOrEqualTo_ShouldPass_WhenValuesAreEqual
as
	declare @actual datetime;
	set		@actual = dbo.GetDateValue();

	exec ssunit.AssertDateLessThanOrEqualTo '2001-01-01', @actual;
go

create procedure test._@Test@_AssertDateLessThanOrEqualTo_ShouldFail_WhenValueNotLessThan
as
	declare @actual datetime;
	set		@actual = dbo.GetDateValue();

	exec ssunit.AssertDateLessThanOrEqualTo '1999-12-31', @actual;
go

create procedure test._@Test@_AssertDateLessThanOrEqualTo_ShouldFail_WhenExpectedValueIsNull
as
	declare @actual datetime;
	set		@actual = dbo.GetDateValue();

	exec ssunit.AssertDateLessThanOrEqualTo null, @actual;
go

create procedure test._@Test@_AssertDateLessThanOrEqualTo_ShouldFail_WhenActualValueIsNull
as
	declare @actual datetime;
	set		@actual = null;

	exec ssunit.AssertDateLessThanOrEqualTo '2001-01-01', @actual;
go

create procedure test._@Test@_AssertDateGreaterThanOrEqualTo_ShouldPass_WhenValueGreaterThan
as
	declare @actual datetime;
	set		@actual = dbo.GetDateValue();

	exec ssunit.AssertDateGreaterThanOrEqualTo '1999-12-31', @actual;
go

create procedure test._@Test@_AssertDateGreaterThanOrEqualTo_ShouldPass_WhenValuesAreEqual
as
	declare @actual datetime;
	set		@actual = dbo.GetDateValue();

	exec ssunit.AssertDateGreaterThanOrEqualTo '2001-01-01', @actual;
go

create procedure test._@Test@_AssertDateGreaterThanOrEqualTo_ShouldFail_WhenValueNotGreaterThan
as
	declare @actual datetime;
	set		@actual = dbo.GetDateValue();

	exec ssunit.AssertDateGreaterThanOrEqualTo '2999-12-31', @actual;
go

create procedure test._@Test@_AssertDateGreaterThanOrEqualTo_ShouldFail_WhenExpectedValueIsNull
as
	declare @actual datetime;
	set		@actual = dbo.GetDateValue();

	exec ssunit.AssertDateGreaterThanOrEqualTo null, @actual;
go

create procedure test._@Test@_AssertDateGreaterThanOrEqualTo_ShouldFail_WhenActualValueIsNull
as
	declare @actual datetime;
	set		@actual = null;

	exec ssunit.AssertDateGreaterThanOrEqualTo '2001-01-01', @actual;
go

exec ssunit.RunTests;
