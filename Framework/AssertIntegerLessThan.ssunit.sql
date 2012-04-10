/**
 * \file
 * \brief  The AssertIntegerLessThan stored procedure.
 * \author Chris Oldwood
 */

if (object_id('ssunit.AssertIntegerLessThan') is not null)
	drop procedure ssunit.AssertIntegerLessThan;
go

/**
 * Asserts that one integer is less than another.
 */

create procedure ssunit.AssertIntegerLessThan
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
	else if (@actual < @expected)
	begin
		exec ssunit.AssertPass;
	end
	else
	begin
		set @reason = ssunit_impl.FormatIntegerCompareFailure('Actual was greater than or equal to Expected', @expected, @actual);

		exec ssunit.AssertFail @reason;
	end
go
