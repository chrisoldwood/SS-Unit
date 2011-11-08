/**
 * \file   AssertDateTimeGreaterThan.ssunit.sql
 * \brief  The AssertDateTimeGreaterThan stored procedure.
 * \author Chris Oldwood
 */

if (object_id('ssunit.AssertDateTimeGreaterThan') is not null)
	drop procedure ssunit.AssertDateTimeGreaterThan;
go

/**
 * Asserts that one DateTime is greater than another.
 */

create procedure ssunit.AssertDateTimeGreaterThan
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
	else if (@actual > @expected)
	begin
		exec ssunit.AssertPass;
	end
	else
	begin
		set @reason = ssunit.FormatDateTimeCompareFailure('Actual was less than or equal to Expected', @expected, @actual);

		exec ssunit.AssertFail @reason;
	end
go
