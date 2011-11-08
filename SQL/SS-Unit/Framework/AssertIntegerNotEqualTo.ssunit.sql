/**
 * \file   AssertIntegerNotEqualTo.ssunit.sql
 * \brief  The AssertIntegerNotEqualTo stored procedure.
 * \author Chris Oldwood
 */

if (object_id('ssunit.AssertIntegerNotEqualTo') is not null)
	drop procedure ssunit.AssertIntegerNotEqualTo;
go

/**
 * Asserts that the two integers are not equivalent.
 */

create procedure ssunit.AssertIntegerNotEqualTo
(
	@expected	int,	--!< The expected value.
	@actual		int		--!< The actual value.
)
as
	declare @reason ssunit.TextMessage;

	if ( (@expected is null) or (@actual is null) )
	begin
		set @reason = ssunit.FormatIntegerNullFailure(@expected, @actual);

		exec ssunit.AssertFail @reason;
	end
	else if (@actual <> @expected)
	begin
		exec ssunit.AssertPass;
	end
	else
	begin
		set @reason = ssunit.FormatIntegerCompareFailure('Actual/Expected values were equal', @expected, @actual);

		exec ssunit.AssertFail @reason;
	end
go
