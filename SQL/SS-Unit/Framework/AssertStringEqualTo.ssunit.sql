/**
 * \file
 * \brief  The AssertStringEqualTo stored procedure.
 * \author Chris Oldwood
 */

if (object_id('ssunit.AssertStringEqualTo') is not null)
	drop procedure ssunit.AssertStringEqualTo;
go

/**
 * Asserts that the two Strings are equivalent.
 */

create procedure ssunit.AssertStringEqualTo
(
	@expected	varchar(max),	--!< The expected value.
	@actual		varchar(max)	--!< The actual value.
)
as
	declare @reason ssunit.TextMessage;

	if ( (@expected is null) or (@actual is null) )
	begin
		set @reason = ssunit_impl.FormatStringNullFailure(@expected, @actual);

		exec ssunit.AssertFail @reason;
	end
	else if (@actual = @expected)
	begin
		exec ssunit.AssertPass;
	end
	else
	begin
		set @reason = ssunit_impl.FormatStringCompareFailure('Actual/Expected values differ', @expected, @actual);

		exec ssunit.AssertFail @reason;
	end
go
