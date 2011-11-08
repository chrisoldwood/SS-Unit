/**
 * \file   AssertDateTimeEqualTo.ssunit.sql
 * \brief  The AssertDateTimeEqualTo stored procedure.
 * \author Chris Oldwood
 */

if (object_id('ssunit.AssertDateTimeEqualTo') is not null)
	drop procedure ssunit.AssertDateTimeEqualTo;
go

/**
 * Asserts that the two DateTimes are equivalent.
 */

create procedure ssunit.AssertDateTimeEqualTo
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
	else if (@actual = @expected)
	begin
		exec ssunit.AssertPass;
	end
	else
	begin
		set @reason = ssunit.FormatDateTimeCompareFailure('Actual/Expected values differ', @expected, @actual);

		exec ssunit.AssertFail @reason;
	end
go
