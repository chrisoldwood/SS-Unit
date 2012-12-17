/**
 * \file
 * \brief  The AssertRealGreaterThanOrEqualTo stored procedure.
 * \author Chris Oldwood
 */

if (object_id('ssunit.AssertRealGreaterThanOrEqualTo') is not null)
	drop procedure ssunit.AssertRealGreaterThanOrEqualTo;
go

/**
 * Asserts that one real number is greater than or equal to another.
 */

create procedure ssunit.AssertRealGreaterThanOrEqualTo
(
	@expected	real,	--!< The expected value.
	@actual		real	--!< The actual value.
)
as
	declare @reason ssunit.TextMessage;

	if ( (@expected is null) or (@actual is null) )
	begin
		set @reason = ssunit_impl.FormatRealNullFailure(@expected, @actual);

		exec ssunit.AssertFail @reason;
	end
	else if (@actual >= @expected)
	begin
		exec ssunit.AssertPass;
	end
	else
	begin
		set @reason = ssunit_impl.FormatRealCompareFailure('Actual was less than Expected', @expected, @actual, default);

		exec ssunit.AssertFail @reason;
	end
go
