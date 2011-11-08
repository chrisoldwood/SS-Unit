/**
 * \file   AssertStringNotEqualTo.ssunit.sql
 * \brief  The AssertStringNotEqualTo stored procedure.
 * \author Chris Oldwood
 */

if (object_id('ssunit.AssertStringNotEqualTo') is not null)
	drop procedure ssunit.AssertStringNotEqualTo;
go

/**
 * Asserts that the two Strings are not equivalent.
 */

create procedure ssunit.AssertStringNotEqualTo
(
	@expected	varchar(max),	--!< The expected value.
	@actual		varchar(max)	--!< The actual value.
)
as
	declare @reason ssunit.TextMessage;

	if ( (@expected is null) or (@actual is null) )
	begin
		set @reason = ssunit.FormatStringNullFailure(@expected, @actual);

		exec ssunit.AssertFail @reason;
	end
	else if (@actual <> @expected)
	begin
		exec ssunit.AssertPass;
	end
	else
	begin
		set @reason = ssunit.FormatStringCompareFailure('Actual/Expected values were equal', @expected, @actual);

		exec ssunit.AssertFail @reason;
	end
go
