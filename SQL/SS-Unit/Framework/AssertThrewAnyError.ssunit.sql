/**
 * \file
 * \brief  The AssertThrewAnyError stored procedure.
 * \author Chris Oldwood
 */

if (object_id('ssunit.AssertThrewAnyError') is not null)
	drop procedure ssunit.AssertThrewAnyError;
go

/**
 * Asserts that the test raised any error at all.
 *
 * \Note The helper procedure should contain the '_@Helper@_' attribute in its
 * name so that it is dropped automatically by the framework at the end of the
 * test run to save dropping it manually.
 */

create procedure ssunit.AssertThrewAnyError
(
	@procedure	ssunit.ProcedureName	--!< The helper procedure to run.
)
as
	exec ssunit.AssertThrew '%', @procedure;
go
