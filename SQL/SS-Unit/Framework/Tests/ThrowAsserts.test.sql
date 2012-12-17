/**
 * \file
 * \brief  Unit tests for the error throwing assert procedures.
 * \author Chris Oldwood
 */

create procedure test._@Helper@_RaiseAnError
as
	raiserror('test error', 16, 1);
go

create procedure test._@Helper@_DontRaiseAnError
as
	-- Do nothing.
go

create procedure test._@Helper@_RaiseDifferentError
as
	raiserror('different error', 16, 1);
go

create procedure test._@Test@_AssertThrew_ShouldPassTheTest_WhenErrorRaised
as
	exec ssunit.AssertThrew 'test error', 'test._@Helper@_RaiseAnError';
go

create procedure test._@Test@_AssertThrew_ShouldFailTheTest_WhenNoErrorRaised
as
	exec ssunit.AssertThrew 'test error', 'test._@Helper@_DontRaiseAnError';
go

create procedure test._@Test@_AssertThrew_ShouldFailTheTest_WhenDifferentErrorRaised
as
	exec ssunit.AssertThrew 'test error', 'test._@Helper@_RaiseDifferentError';
go

create procedure test._@Test@_AssertThrewAnyError_ShouldPassTheTest_WhenAnyErrorRaised
as
	exec ssunit.AssertThrewAnyError 'test._@Helper@_RaiseAnError';
go

create procedure test._@Test@_AssertThrewAnyError_ShouldFailTheTest_WhenNoErrorRaised
as
	exec ssunit.AssertThrewAnyError 'test._@Helper@_DontRaiseAnError';
go

exec ssunit.RunTests;
