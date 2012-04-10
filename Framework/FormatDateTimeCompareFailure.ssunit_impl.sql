/**
 * \file   FormatDateTimeCompareFailure.ssunit.sql
 * \brief  The FormatDateTimeCompareFailure user-defined function.
 * \author Chris Oldwood
 */

if (object_id('ssunit.FormatDateTimeCompareFailure') is not null)
	drop function ssunit.FormatDateTimeCompareFailure;
go

/**
 * Formats the message for a failed comparison between two DateTimes.
 */

create function ssunit.FormatDateTimeCompareFailure
(
	@error		ssunit.TextMessage,	--!< The short error message.
	@expected	datetime,			--!< The expected value.
	@actual		datetime			--!< The actual value.
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
