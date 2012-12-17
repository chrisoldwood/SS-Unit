/**
 * \file
 * \brief  The AssertRealGreaterThan stored procedure.
 * \author Chris Oldwood
 */

if (object_id('ssunit.AssertRealGreaterThan') is not null)
	drop procedure ssunit.AssertRealGreaterThan;
go

/**
 * Asserts that one real number is greater than another.
 */

create procedure ssunit.AssertRealGreaterThan
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
	else if (@actual > @expected)
	begin
		exec ssunit.AssertPass;
	end
	else
	begin
		set @reason = ssunit_impl.FormatRealCompareFailure('Actual was less than or equal to Expected', @expected, @actual, default);

		exec ssunit.AssertFail @reason;
	end
go
