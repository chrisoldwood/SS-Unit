/**
 * \file
 * \brief  The AssertRealNotEqualTo stored procedure.
 * \author Chris Oldwood
 */

if (object_id('ssunit.AssertRealNotEqualTo') is not null)
	drop procedure ssunit.AssertRealNotEqualTo;
go

/**
 * Asserts that the two real numbers are not equivalent.
 */

create procedure ssunit.AssertRealNotEqualTo
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
	else if (@actual <> @expected)
	begin
		exec ssunit.AssertPass;
	end
	else
	begin
		set @reason = ssunit_impl.FormatRealCompareFailure('Actual/Expected values were equal', @expected, @actual, default);

		exec ssunit.AssertFail @reason;
	end
go
