/**
 * \file
 * \brief  The FormatDateCompareFailure user-defined function.
 * \author Chris Oldwood
 */

if (object_id('ssunit_impl.FormatDateCompareFailure') is not null)
	drop function ssunit_impl.FormatDateCompareFailure;
go

/**
 * Formats the message for a failed comparison between two Dates.
 */

create function ssunit_impl.FormatDateCompareFailure
(
	@error		ssunit.TextMessage,	--!< The short error message.
	@expected	date,				--!< The expected value.
	@actual		date				--!< The actual value.
)
	returns ssunit.TextMessage
as
begin
	declare @expectedAsString ssunit.TextMessage;
	set		@expectedAsString = isnull(convert(varchar(max), @expected, 121), '(null)');

	declare @actualAsString ssunit.TextMessage;
	set		@actualAsString  = isnull(convert(varchar(max), @actual, 121), '(null)');

	declare @reason ssunit.TextMessage;

	set @reason = @error + ' -'
				+ ' Expected: ' + @expectedAsString 
				+ ' Actual: '   + @actualAsString;

	return @reason
end
go
