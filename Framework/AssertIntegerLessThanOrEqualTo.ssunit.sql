/**
 * \file   AssertIntegerLessThanOrEqualTo.ssunit.sql
 * \brief  The AssertIntegerLessThanOrEqualTo stored procedure.
 * \author Chris Oldwood
 */

if (object_id('ssunit.AssertIntegerLessThanOrEqualTo') is not null)
	drop procedure ssunit.AssertIntegerLessThanOrEqualTo;
go

/**
 * Asserts that one integer is less than or equal to another.
 */

create procedure ssunit.AssertIntegerLessThanOrEqualTo
(
	@expected	int,	--!< The expected value.
	@actual		int		--!< The actual value.
)
as
	declare @reason ssunit.TextMessage;

	if ( (@expected is null) or (@actual is null) )
	begin
		set @reason = ssunit.FormatIntegerNullFailure(@expected, @actual);

		exec ssunit.AssertFail @reason;
	end
	else if (@actual <= @expected)
	begin
		exec ssunit.AssertPass;
	end
	else
	begin
		set @reason = ssunit.FormatIntegerCompareFailure('Actual was greater than Expected', @expected, @actual);

		exec ssunit.AssertFail @reason;
	end
go
