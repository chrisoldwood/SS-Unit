/**
 * \file   AssertNotImplemented.ssunit.sql
 * \brief  The AssertNotImplemented stored procedure.
 * \author Chris Oldwood
 */

if (object_id('ssunit.AssertNotImplemented') is not null)
	drop procedure ssunit.AssertNotImplemented;
go

/**
 * Fails the test with the reason that it has not been implemented.
 */

create procedure ssunit.AssertNotImplemented
as
	exec ssunit.AssertFail 'Not implemented';
go
