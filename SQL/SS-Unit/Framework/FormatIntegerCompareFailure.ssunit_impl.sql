/**
 * \file   FormatIntegerCompareFailure.ssunit.sql
 * \brief  The FormatIntegerCompareFailure user-defined function.
 * \author Chris Oldwood
 */

if (object_id('ssunit.FormatIntegerCompareFailure') is not null)
	drop function ssunit.FormatIntegerCompareFailure;
go

/**
 * Formats the message for a failed comparison between two integers.
 */

create function ssunit.FormatIntegerCompareFailure
(
	@error		ssunit.TextMessage,	--!< The short error message.
	@expected	int,				--!< The expected value.
	@actual		int					--!< The actual value.
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

	return @reason
end
go
