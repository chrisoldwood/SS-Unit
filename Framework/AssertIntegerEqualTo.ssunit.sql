/**
 * \file
 * \brief  The AssertIntegerEqualTo stored procedure.
 * \author Chris Oldwood
 */

if (object_id('ssunit.AssertIntegerEqualTo') is not null)
	drop procedure ssunit.AssertIntegerEqualTo;
go

/**
 * Asserts that the two integers are equivalent.
 */

create procedure ssunit.AssertIntegerEqualTo
(
	@expected	int,	--!< The expected value.
	@actual		int		--!< The actual value.
)
as
	declare @reason ssunit.TextMessage;

	if ( (@expected is null) or (@actual is null) )
	begin
		set @reason = ssunit_impl.FormatIntegerNullFailure(@expected, @actual);

		exec ssunit.AssertFail @reason;
	end
	else if (@actual = @expected)
	begin
		exec ssunit.AssertPass;
	end
	else
	begin
		set @reason = ssunit_impl.FormatIntegerCompareFailure('Actual/Expected values differ', @expected, @actual);

		exec ssunit.AssertFail @reason;
	end
go
