/**
 * \file
 * \brief  The AssertDateEqualTo stored procedure.
 * \author Chris Oldwood
 */

if (object_id('ssunit.AssertDateEqualTo') is not null)
	drop procedure ssunit.AssertDateEqualTo;
go

/**
 * Asserts that the two Dates are equivalent.
 */

create procedure ssunit.AssertDateEqualTo
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
	else if (@actual = @expected)
	begin
		exec ssunit.AssertPass;
	end
	else
	begin
		set @reason = ssunit_impl.FormatDateCompareFailure('Actual/Expected values differ', @expected, @actual);

		exec ssunit.AssertFail @reason;
	end
go
