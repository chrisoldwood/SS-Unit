/**
 * \file
 * \brief  Unit tests for the fundamental assert procedures.
 * \author Chris Oldwood
 */

create procedure test._@Test@_AssertPass_ShouldPassTheTest
as
	exec ssunit.AssertPass;
go

create procedure test._@Test@_AssertFail_ShouldFailTheTest
as
	exec ssunit.AssertFail 'the reason for failure';
go

create procedure test._@Test@_MissingAssert_ShouldLeaveTheTestInconclusive
as
	-- Do nothing.
go

create procedure test._@Test@_RaisedError_ShouldFailTheTest
as
	raiserror('unexpected error raised', 16, 1);
go

create procedure test._@Test@_AssertFail_ShouldFailTheTest_WhenTestAlreadyPassed
as
	exec ssunit.AssertPass;
	exec ssunit.AssertFail 'a fail overrides a pass';
go

create procedure test._@Test@_AssertPass_ShouldFail_WhenTestAlreadyFailed
as
	exec ssunit.AssertFail 'a fail overrides a pass';
	exec ssunit.AssertPass;
go

create procedure test._@Test@_AssertFail_ShouldFail_AndReportFirstFailure
as
	exec ssunit.AssertFail '1st failure reported';
	exec ssunit.AssertFail '2nd failure reported';
go

create procedure test._@Test@_AssertTrue_ShouldPass_WhenValueIsTrue
as
	declare @actual bit;
	set		@actual = 1;

	exec ssunit.AssertTrue @actual;
go

create procedure test._@Test@_AssertTrue_ShouldFail_WhenValueIsFalse
as
	declare @actual bit;
	set		@actual = 0;

	exec ssunit.AssertTrue @actual;
go

create procedure test._@Test@_AssertFalse_ShouldPass_WhenValueIsFalse
as
	declare @actual bit;
	set		@actual = 0;

	exec ssunit.AssertFalse @actual;
go

create procedure test._@Test@_AssertFalse_ShouldFail_WhenValueIsTrue
as
	declare @actual bit;
	set		@actual = 1;

	exec ssunit.AssertFalse @actual;
go

create procedure test._@Test@_AssertNotImplemented_ShouldFail
as
	exec ssunit.AssertNotImplemented;
go

exec ssunit.RunTests;
