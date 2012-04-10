/**
 * \file
 * \brief  The AssertFalse stored procedure.
 * \author Chris Oldwood
 */

if (object_id('ssunit.AssertFalse') is not null)
	drop procedure ssunit.AssertFalse;
go

/**
 * Asserts that the boolean value is false (i.e. 0).
 */

create procedure ssunit.AssertFalse
(
	@actual		bit		--!< The actual value.
)
as
	exec ssunit.AssertIntegerEqualTo 0, @actual;
go
