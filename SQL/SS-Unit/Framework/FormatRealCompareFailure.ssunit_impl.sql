/**
 * \file
 * \brief  The FormatRealCompareFailure user-defined function.
 * \author Chris Oldwood
 */

if (object_id('ssunit_impl.FormatRealCompareFailure') is not null)
	drop function ssunit_impl.FormatRealCompareFailure;
go

/**
 * Formats the message for a failed comparison between two integers.
 */

create function ssunit_impl.FormatRealCompareFailure
(
	@error			ssunit.TextMessage,		--!< The short error message.
	@expected		real,					--!< The expected value.
	@actual			real,					--!< The actual value.
	@absTolerance	real = null				--!< The absolute tolerance.
)
	returns ssunit.TextMessage
as
begin
	declare @expectedAsString ssunit.TextMessage;
	set		@expectedAsString = isnull(convert(varchar(max), @expected), '(null)');

	declare @actualAsString ssunit.TextMessage;
	set		@actualAsString  = isnull(convert(varchar(max), @actual), '(null)');

	declare @reason ssunit.TextMessage;

	set @reason = @error + ' -'
				+ ' Expected: ' + @expectedAsString 
				+ ' Actual: '   + @actualAsString;

	if (@absTolerance is not null)
	begin
		declare @toleranceAsString ssunit.TextMessage;
		set		@toleranceAsString = '+/- ' + convert(varchar(max), @absTolerance);

		set @reason = @reason
					+ ' (Tolerance: '
					+ @toleranceAsString
					+ ')'
	end

	return @reason
end
go
