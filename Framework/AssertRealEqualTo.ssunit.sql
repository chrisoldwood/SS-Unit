/**
 * \file
 * \brief  The AssertRealEqualTo stored procedure.
 * \author Chris Oldwood
 */

if (object_id('ssunit.AssertRealEqualTo') is not null)
	drop procedure ssunit.AssertRealEqualTo;
go

/**
 * Asserts that the two real numbers are equivalent.
 *
 * If no tolerance is specified the numbers must match exactly which may be
 * acceptable in a unit test where you can pick contrived values that are
 * representable.
 */

create procedure ssunit.AssertRealEqualTo
(
	@expected		real,			--!< The expected value.
	@actual			real,			--!< The actual value.
	@absTolerance	real = null		--!< The absolute tolerance.
)
as
	declare @reason ssunit.TextMessage;

	if ( (@expected is null) or (@actual is null) )
	begin
		set @reason = ssunit_impl.FormatRealNullFailure(@expected, @actual);

		exec ssunit.AssertFail @reason;
	end
	else if ( (@absTolerance is not null) and (@absTolerance < 0.0) )
	begin
		exec ssunit.AssertFail 'Tolerance must be a postive real number';
	end
	else
	begin
		if (@actual = @expected)
		begin
			exec ssunit.AssertPass;
		end
		else if (@absTolerance is not null)
		begin
			declare @lowerBound real = @expected - @absTolerance;
			declare @upperBound real = @expected + @absTolerance;

			if ( (@actual >= @lowerBound) and (@actual <= @upperBound) )
			begin
				exec ssunit.AssertPass;
			end
			else
			begin
				set @reason = ssunit_impl.FormatRealCompareFailure('Actual/Expected values differ', @expected, @actual, @absTolerance);

				exec ssunit.AssertFail @reason;
			end
		end
		else
		begin
			set @reason = ssunit_impl.FormatRealCompareFailure('Actual/Expected values differ', @expected, @actual, @absTolerance);

			exec ssunit.AssertFail @reason;
		end
	end
go
