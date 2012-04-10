/**
 * \file
 * \brief  The AssertTrue stored procedure.
 * \author Chris Oldwood
 */

if (object_id('ssunit.AssertTrue') is not null)
	drop procedure ssunit.AssertTrue;
go

/**
 * Asserts that the boolean value is true (i.e. 1).
 */

create procedure ssunit.AssertTrue
(
	@actual		bit		--!< The actual value.
)
as
	exec ssunit.AssertIntegerEqualTo 1, @actual;
go
