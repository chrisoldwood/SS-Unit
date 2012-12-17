/**
 * \file
 * \brief  The AssertRealLessThanOrEqualTo stored procedure.
 * \author Chris Oldwood
 */

if (object_id('ssunit.AssertRealLessThanOrEqualTo') is not null)
	drop procedure ssunit.AssertRealLessThanOrEqualTo;
go

/**
 * Asserts that one real number is less than or equal to another.
 */

create procedure ssunit.AssertRealLessThanOrEqualTo
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
	else if (@actual <= @expected)
	begin
		exec ssunit.AssertPass;
	end
	else
	begin
		set @reason = ssunit_impl.FormatRealCompareFailure('Actual was greater than Expected', @expected, @actual, default);

		exec ssunit.AssertFail @reason;
	end
go
