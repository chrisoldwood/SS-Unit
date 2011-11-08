/**
 * \file   AssertDateTimeLessThan.ssunit.sql
 * \brief  The AssertDateTimeLessThan stored procedure.
 * \author Chris Oldwood
 */

if (object_id('ssunit.AssertDateTimeLessThan') is not null)
	drop procedure ssunit.AssertDateTimeLessThan;
go

/**
 * Asserts that one DateTime is less than another.
 */

create procedure ssunit.AssertDateTimeLessThan
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
	else if (@actual < @expected)
	begin
		exec ssunit.AssertPass;
	end
	else
	begin
		set @reason = ssunit.FormatDateTimeCompareFailure('Actual was greater than or equal to Expected', @expected, @actual);

		exec ssunit.AssertFail @reason;
	end
go
