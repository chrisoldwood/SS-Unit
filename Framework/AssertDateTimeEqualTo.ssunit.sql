/**
 * \file
 * \brief  The AssertDateTimeEqualTo stored procedure.
 * \author Chris Oldwood
 */

if (object_id('ssunit.AssertDateTimeEqualTo') is not null)
	drop procedure ssunit.AssertDateTimeEqualTo;
go

/**
 * Asserts that the two DateTimes are equivalent.
 */

create procedure ssunit.AssertDateTimeEqualTo
(
	@expected		datetime,	--!< The expected value.
	@actual			datetime,	--!< The actual value.
	@toleranceInMs	int = null	--!< The tolerance in milliseconds.
)
as
	declare @reason ssunit.TextMessage;

	if ( (@expected is null) or (@actual is null) )
	begin
		set @reason = ssunit_impl.FormatDateTimeNullFailure(@expected, @actual);

		exec ssunit.AssertFail @reason;
	end
	else if ( (@toleranceInMs is not null) and (@toleranceInMs < 0) )
	begin
		exec ssunit.AssertFail 'Tolerance must be a postive integer';
	end
	else
	begin

		if (@toleranceInMs is null)
		begin

			if (@actual = @expected)
			begin
				exec ssunit.AssertPass;
			end
			else
			begin
				set @reason = ssunit_impl.FormatDateTimeCompareFailure('Actual/Expected values differ', @expected, @actual);

				exec ssunit.AssertFail @reason;
			end

		end
		else
		begin

			declare @lowerBound datetime = @expected;
			declare @upperBound datetime = @expected;

			set @lowerBound = dateadd(millisecond, -@toleranceInMs, @lowerBound);
			set @upperBound = dateadd(millisecond,  @toleranceInMs, @upperBound);

			if ( (@actual >= @lowerBound) and (@actual <= @upperBound) )
			begin
				exec ssunit.AssertPass;
			end
			else
			begin
				declare @lowerAsString ssunit.TextMessage;
				set		@lowerAsString = isnull(convert(varchar(max), @lowerBound, 121), '(null)');

				declare @upperAsString ssunit.TextMessage;
				set		@upperAsString = isnull(convert(varchar(max), @upperBound, 121), '(null)');

				declare @actualAsString ssunit.TextMessage;
				set		@actualAsString  = isnull(convert(varchar(max), @actual, 121), '(null)');

				set @reason = 'Actual/Expected values differ -'
							+ ' Expected: ' + @lowerAsString + ' to ' + @upperAsString
							+ ' Actual: '   + @actualAsString;

				exec ssunit.AssertFail @reason;
			end

		end

	end
go
