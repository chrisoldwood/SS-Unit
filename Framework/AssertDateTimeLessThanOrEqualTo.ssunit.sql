/**
 * \file   AssertDateTimeLessThanOrEqualTo.ssunit.sql
 * \brief  The AssertDateTimeLessThanOrEqualTo stored procedure.
 * \author Chris Oldwood
 */

if (object_id('ssunit.AssertDateTimeLessThanOrEqualTo') is not null)
	drop procedure ssunit.AssertDateTimeLessThanOrEqualTo;
go

/**
 * Asserts that one DateTime is less than or equal to another.
 */

create procedure ssunit.AssertDateTimeLessThanOrEqualTo
(
	@expected	datetime,	--!< The expected value.
	@actual		datetime	--!< The actual value.
)
as
	declare @reason ssunit.TextMessage;

	if ( (@expected is null) or (@actual is null) )
	begin
		set @reason = ssunit.FormatDateTimeNullFailure(@expected, @actual);

		exec ssunit.AssertFail @reason;
	end
	else if (@actual <= @expected)
	begin
		exec ssunit.AssertPass;
	end
	else
	begin
		set @reason = ssunit.FormatDateTimeCompareFailure('Actual was greater than Expected', @expected, @actual);

		exec ssunit.AssertFail @reason;
	end
go
