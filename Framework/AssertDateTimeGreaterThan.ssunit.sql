/**
 * \file
 * \brief  The AssertDateTimeGreaterThanOrEqualTo stored procedure.
 * \author Chris Oldwood
 */

if (object_id('ssunit.AssertDateTimeGreaterThanOrEqualTo') is not null)
	drop procedure ssunit.AssertDateTimeGreaterThanOrEqualTo;
go

/**
 * Asserts that one DateTime is greater than or equal to another.
 */

create procedure ssunit.AssertDateTimeGreaterThanOrEqualTo
(
	@expected	datetime,	--!< The expected value.
	@actual		datetime	--!< The actual value.
)
as
	declare @reason ssunit.TextMessage;

	if ( (@expected is null) or (@actual is null) )
	begin
		set @reason = ssunit_impl.FormatDateTimeNullFailure(@expected, @actual);

		exec ssunit.AssertFail @reason;
	end
	else if (@actual >= @expected)
	begin
		exec ssunit.AssertPass;
	end
	else
	begin
		set @reason = ssunit_impl.FormatDateTimeCompareFailure('Actual was less than Expected', @expected, @actual);

		exec ssunit.AssertFail @reason;
	end
go
