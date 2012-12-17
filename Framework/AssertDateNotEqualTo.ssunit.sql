/**
 * \file
 * \brief  The AssertDateNotEqualTo stored procedure.
 * \author Chris Oldwood
 */

if (object_id('ssunit.AssertDateNotEqualTo') is not null)
	drop procedure ssunit.AssertDateNotEqualTo;
go

/**
 * Asserts that the two Dates are not equivalent.
 */

create procedure ssunit.AssertDateNotEqualTo
(
	@expected	date,	--!< The expected value.
	@actual		date	--!< The actual value.
)
as
	declare @reason ssunit.TextMessage;

	if ( (@expected is null) or (@actual is null) )
	begin
		set @reason = ssunit_impl.FormatDateNullFailure(@expected, @actual);

		exec ssunit.AssertFail @reason;
	end
	else if (@actual <> @expected)
	begin
		exec ssunit.AssertPass;
	end
	else
	begin
		set @reason = ssunit_impl.FormatDateCompareFailure('Actual/Expected values were equal', @expected, @actual);

		exec ssunit.AssertFail @reason;
	end
go
