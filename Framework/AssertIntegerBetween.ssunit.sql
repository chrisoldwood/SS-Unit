/**
 * \file
 * \brief  The AssertIntegerBetween stored procedure.
 * \author Chris Oldwood
 */

if (object_id('ssunit.AssertIntegerBetween') is not null)
	drop procedure ssunit.AssertIntegerBetween;
go

/**
 * Asserts that the integer value is within the specified range.
 */

create procedure ssunit.AssertIntegerBetween
(
	@lower		int,	--!< The expected value lower bound.
	@upper		int,	--!< The expected value upper bound.
	@actual		int		--!< The actual value.
)
as
	declare @reason ssunit.TextMessage;
	declare @lowerAsString ssunit.TextMessage;
	declare @upperAsString ssunit.TextMessage;
	declare @actualAsString ssunit.TextMessage;

	if ( (@lower is null) or (@upper is null) or (@actual is null) )
	begin
		set @lowerAsString = isnull(convert(varchar(max), @lower), '(null)');
		set @upperAsString = isnull(convert(varchar(max), @upper), '(null)');
		set @actualAsString  = isnull(convert(varchar(max), @actual), '(null)');

		set @reason = 'Comparison with NULL.'
					+ ' Lower: ' + @lowerAsString 
					+ ' Upper: ' + @upperAsString 
					+ ' Actual: '   + @actualAsString;

		exec ssunit.AssertFail @reason;
	end
	else if (@upper < @lower)
	begin
		set @lowerAsString = isnull(convert(varchar(max), @lower), '(null)');
		set @upperAsString = isnull(convert(varchar(max), @upper), '(null)');

		set @reason = 'Upper bound < lower bound.'
					+ ' Lower: ' + @lowerAsString 
					+ ' Upper: ' + @upperAsString;

		exec ssunit.AssertFail @reason;
	end
	else if ( (@actual >= @lower) and (@actual <= @upper) )
	begin
		exec ssunit.AssertPass;
	end
	else
	begin
		set @lowerAsString = isnull(convert(varchar(max), @lower), '(null)');
		set @upperAsString = isnull(convert(varchar(max), @upper), '(null)');
		set @actualAsString  = isnull(convert(varchar(max), @actual), '(null)');

		set @reason = 'Value out of range.'
					+ ' Lower: ' + @lowerAsString 
					+ ' Upper: ' + @upperAsString 
					+ ' Actual: '   + @actualAsString;

		exec ssunit.AssertFail @reason;
	end
go
