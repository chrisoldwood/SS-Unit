/**
 * \file   AssertDateTimeNotEqualTo.ssunit.sql
 * \brief  The AssertDateTimeNotEqualTo stored procedure.
 * \author Chris Oldwood
 */

if (object_id('ssunit.AssertDateTimeNotEqualTo') is not null)
	drop procedure ssunit.AssertDateTimeNotEqualTo;
go

/**
 * Asserts that the two DateTimes are not equivalent.
 */

create procedure ssunit.AssertDateTimeNotEqualTo
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
	else if (@expected <> @actual)
	begin
		exec ssunit.AssertPass;
	end
	else
	begin
		set @reason = ssunit.FormatDateTimeCompareFailure('Values similar', @expected, @actual);

		exec ssunit.AssertFail @reason;
	end
go
