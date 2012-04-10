/**
 * \file
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
		set @reason = ssunit_impl.FormatDateTimeNullFailure(@expected, @actual);

		exec ssunit.AssertFail @reason;
	end
	else if (@actual <> @expected)
	begin
		exec ssunit.AssertPass;
	end
	else
	begin
		set @reason = ssunit_impl.FormatDateTimeCompareFailure('Actual/Expected values were equal', @expected, @actual);

		exec ssunit.AssertFail @reason;
	end
go
