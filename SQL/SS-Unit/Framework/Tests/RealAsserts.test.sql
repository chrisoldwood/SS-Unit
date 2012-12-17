/**
 * \file
 * \brief  Unit tests for the AssertReal* functions.
 * \author Chris Oldwood
 */

create procedure test._@Test@_AssertRealEqualTo_ShouldPass_WhenLargeValuesAreEqual
as
	declare @actual real = 42.0;

	exec ssunit.AssertRealEqualTo 42.0, @actual;
go

create procedure test._@Test@_AssertRealEqualTo_ShouldPass_WhenSmallValuesAreEqual
as
	declare @actual real = 0.42;

	exec ssunit.AssertRealEqualTo 0.42, @actual;
go

create procedure test._@Test@_AssertRealTimeEqualTo_ShouldFail_WhenAbsToleranceIsNegative
as
	declare @actual real = 42.5;
	declare @absTolerance real = -1.0;

	exec ssunit.AssertRealEqualTo 42.0, @actual, @absTolerance;
go

create procedure test._@Test@_AssertRealEqualTo_ShouldPass_WhenLargeValueWithinAbsTolerance
as
	declare @actual real = 42.5;
	declare @absTolerance real = 1.0;

	exec ssunit.AssertRealEqualTo 42.0, @actual, @absTolerance;
go

create procedure test._@Test@_AssertRealEqualTo_ShouldPass_WhenSmallValueWithinAbsTolerance
as
	declare @actual real = 0.425;
	declare @absTolerance real = 0.01;

	exec ssunit.AssertRealEqualTo 0.42, @actual, @absTolerance;
go

create procedure test._@Test@_AssertRealEqualTo_ShouldPass_WhenNegativeValueWithinAbsTolerance
as
	declare @actual real = -42.5;
	declare @absTolerance real = 1.0;

	exec ssunit.AssertRealEqualTo -42.0, @actual, @absTolerance;
go

create procedure test._@Test@_AssertRealEqualTo_ShouldFail_WhenValuesDiffer
as
	declare @actual real = 42.0;

	exec ssunit.AssertRealEqualTo 43.0, @actual;
go

create procedure test._@Test@_AssertRealEqualTo_ShouldFail_WhenValueOutsideAbsTolerance
as
	declare @actual real = 42.0;
	declare @absTolerance real = 1.0;

	exec ssunit.AssertRealEqualTo 43.1, @actual, @absTolerance;
go

create procedure test._@Test@_AssertRealEqualTo_ShouldFail_WhenExpectedValueIsNull
as
	declare @actual real = 42.0;

	exec ssunit.AssertRealEqualTo null, @actual;
go

create procedure test._@Test@_AssertRealEqualTo_ShouldFail_WhenActualValueIsNull
as
	declare @actual real = null;

	exec ssunit.AssertRealEqualTo 42.0, @actual;
go

create procedure test._@Test@_AssertRealNotEqualTo_ShouldPass_WhenValuesDiffer
as
	declare @actual real = 42.0;

	exec ssunit.AssertRealNotEqualTo 43, @actual;
go

create procedure test._@Test@_AssertRealNotEqualTo_ShouldFail_WhenValuesAreEqual
as
	declare @actual real = 42.0;

	exec ssunit.AssertRealNotEqualTo 42.0, @actual;
go

create procedure test._@Test@_AssertRealNotEqualTo_ShouldFail_WhenExpectedValueIsNull
as
	declare @actual real = 42.0;

	exec ssunit.AssertRealNotEqualTo null, @actual;
go

create procedure test._@Test@_AssertRealNotEqualTo_ShouldFail_WhenActualValueIsNull
as
	declare @actual real = null;

	exec ssunit.AssertRealNotEqualTo 43, @actual;
go

create procedure test._@Test@_AssertRealIsNull_ShouldPass_WhenValueIsNull
as
	declare @actual real = null;

	exec ssunit.AssertRealIsNull @actual;
go

create procedure test._@Test@_AssertRealIsNull_ShouldFail_WhenValueIsNotNull
as
	declare @actual real = 42.0;

	exec ssunit.AssertRealIsNull @actual;
go

create procedure test._@Test@_AssertRealIsNotNull_ShouldFail_WhenValueIsNull
as
	declare @actual real = null;

	exec ssunit.AssertRealIsNotNull @actual;
go

create procedure test._@Test@_AssertRealIsNotNull_ShouldPass_WhenValueIsNotNull
as
	declare @actual real = 42.0;

	exec ssunit.AssertRealIsNotNull @actual;
go

create procedure test._@Test@_AssertRealLessThan_ShouldPass_WhenValueLessThan
as
	declare @actual real = 42.0;

	exec ssunit.AssertRealLessThan 43.0, @actual;
go

create procedure test._@Test@_AssertRealLessThan_ShouldFail_WhenValueNotLessThan
as
	declare @actual real = 42.0;

	exec ssunit.AssertRealLessThan 41, @actual;
go

create procedure test._@Test@_AssertRealLessThan_ShouldFail_WhenValuesAreEqual
as
	declare @actual real = 42.0;

	exec ssunit.AssertRealLessThan 42.0, @actual;
go

create procedure test._@Test@_AssertRealLessThan_ShouldFail_WhenExpectedValueIsNull
as
	declare @actual real = 42.0;

	exec ssunit.AssertRealLessThan null, @actual;
go

create procedure test._@Test@_AssertRealLessThan_ShouldFail_WhenActualValueIsNull
as
	declare @actual real = null;

	exec ssunit.AssertRealLessThan 42.0, @actual;
go

create procedure test._@Test@_AssertRealGreaterThan_ShouldPass_WhenValueGreaterThan
as
	declare @actual real = 42.0;

	exec ssunit.AssertRealGreaterThan 41.0, @actual;
go

create procedure test._@Test@_AssertRealGreaterThan_ShouldFail_WhenValueNotGreaterThan
as
	declare @actual real = 42.0;

	exec ssunit.AssertRealGreaterThan 43.0, @actual;
go

create procedure test._@Test@_AssertRealGreaterThan_ShouldFail_WhenValuesAreEqual
as
	declare @actual real = 42.0;

	exec ssunit.AssertRealGreaterThan 42.0, @actual;
go

create procedure test._@Test@_AssertRealGreaterThan_ShouldFail_WhenExpectedValueIsNull
as
	declare @actual real = 42.0;

	exec ssunit.AssertRealGreaterThan null, @actual;
go

create procedure test._@Test@_AssertRealGreaterThan_ShouldFail_WhenActualValueIsNull
as
	declare @actual real = null;

	exec ssunit.AssertRealGreaterThan 42.0, @actual;
go

create procedure test._@Test@_AssertRealLessThanOrEqualTo_ShouldPass_WhenValueLessThan
as
	declare @actual real = 42.0;

	exec ssunit.AssertRealLessThanOrEqualTo 43, @actual;
go

create procedure test._@Test@_AssertRealLessThanOrEqualTo_ShouldPass_WhenValuesAreEqual
as
	declare @actual real = 42.0;

	exec ssunit.AssertRealLessThanOrEqualTo 42.0, @actual;
go

create procedure test._@Test@_AssertRealLessThanOrEqualTo_ShouldFail_WhenValueNotLessThan
as
	declare @actual real = 42.0;

	exec ssunit.AssertRealLessThanOrEqualTo 41, @actual;
go

create procedure test._@Test@_AssertRealLessThanOrEqualTo_ShouldFail_WhenExpectedValueIsNull
as
	declare @actual real = 42.0;

	exec ssunit.AssertRealLessThanOrEqualTo null, @actual;
go

create procedure test._@Test@_AssertRealLessThanOrEqualTo_ShouldFail_WhenActualValueIsNull
as
	declare @actual real = null;

	exec ssunit.AssertRealLessThanOrEqualTo 42.0, @actual;
go

create procedure test._@Test@_AssertRealGreaterThanOrEqualTo_ShouldPass_WhenValueGreaterThan
as
	declare @actual real = 42.0;

	exec ssunit.AssertRealGreaterThanOrEqualTo 41, @actual;
go

create procedure test._@Test@_AssertRealGreaterThanOrEqualTo_ShouldPass_WhenValuesAreEqual
as
	declare @actual real = 42.0;

	exec ssunit.AssertRealGreaterThanOrEqualTo 42.0, @actual;
go

create procedure test._@Test@_AssertRealGreaterThanOrEqualTo_ShouldFail_WhenValueNotGreaterThan
as
	declare @actual real = 42.0;

	exec ssunit.AssertRealGreaterThanOrEqualTo 43.0, @actual;
go

create procedure test._@Test@_AssertRealGreaterThanOrEqualTo_ShouldFail_WhenExpectedValueIsNull
as
	declare @actual real = 42.0;

	exec ssunit.AssertRealGreaterThanOrEqualTo null, @actual;
go

create procedure test._@Test@_AssertRealGreaterThanOrEqualTo_ShouldFail_WhenActualValueIsNull
as
	declare @actual real = null;

	exec ssunit.AssertRealGreaterThanOrEqualTo 42.0, @actual;
go

create procedure test._@Test@_AssertRealBetween_ShouldFail_WhenLowerValueIsNull
as
	declare @actual real = 42.0;

	exec ssunit.AssertRealBetween null, 43.0, @actual;
go

create procedure test._@Test@_AssertRealBetween_ShouldFail_WhenUpperValueIsNull
as
	declare @actual real = 42.0;

	exec ssunit.AssertRealBetween 41.0, null, @actual;
go

create procedure test._@Test@_AssertRealBetween_ShouldFail_WhenActualValueIsNull
as
	declare @actual real = null;

	exec ssunit.AssertRealBetween 41.0, 43.0, @actual;
go

create procedure test._@Test@_AssertRealBetween_ShouldFail_WhenUpperBoundLessThanLowerBound
as
	declare @actual real = 42.0;

	exec ssunit.AssertRealBetween 43, 41, @actual;
go

create procedure test._@Test@_AssertRealBetween_ShouldFail_WhenActualValueIsLessThanLowerBound
as
	declare @actual real = 40.0;

	exec ssunit.AssertRealBetween 41.0, 43.0, @actual;
go

create procedure test._@Test@_AssertRealBetween_ShouldFail_WhenActualValueIsGreaterThanUpperBound
as
	declare @actual real = 44.0;

	exec ssunit.AssertRealBetween 41.0, 43.0, @actual;
go

create procedure test._@Test@_AssertRealBetween_ShouldPass_WhenActualValueIsEqualToLowerBound
as
	declare @actual real = 41.0;

	exec ssunit.AssertRealBetween 41.0, 43.0, @actual;
go

create procedure test._@Test@_AssertRealBetween_ShouldPass_WhenActualValueIsEqualToUpperBound
as
	declare @actual real = 43.0;

	exec ssunit.AssertRealBetween 41.0, 43.0, @actual;
go

create procedure test._@Test@_AssertRealBetween_ShouldPass_WhenActualValueIsEqualToLowerAndUpperBounds
as
	declare @actual real = 42.0;

	exec ssunit.AssertRealBetween 42.0, 42.0, @actual;
go

create procedure test._@Test@_AssertRealBetween_ShouldPass_WhenValueAndRangeIsNegative
as
	declare @actual real = -42.0;

	exec ssunit.AssertRealBetween -43.0, -41.0, @actual;
go

exec ssunit.RunTests;
