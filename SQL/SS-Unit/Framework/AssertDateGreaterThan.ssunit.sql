/**
 * \file
 * \brief  The AssertDateGreaterThanOrEqualTo stored procedure.
 * \author Chris Oldwood
 */

if (object_id('ssunit.AssertDateGreaterThanOrEqualTo') is not null)
	drop procedure ssunit.AssertDateGreaterThanOrEqualTo;
go

/**
 * Asserts that one Date is greater than or equal to another.
 */

create procedure ssunit.AssertDateGreaterThanOrEqualTo
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
	else if (@actual >= @expected)
	begin
		exec ssunit.AssertPass;
	end
	else
	begin
		set @reason = ssunit_impl.FormatDateCompareFailure('Actual was less than Expected', @expected, @actual);

		exec ssunit.AssertFail @reason;
	end
go
