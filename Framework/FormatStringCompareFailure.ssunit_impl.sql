/**
 * \file
 * \brief  The FormatStringCompareFailure user-defined function.
 * \author Chris Oldwood
 */

if (object_id('ssunit_impl.FormatStringCompareFailure') is not null)
	drop function ssunit_impl.FormatStringCompareFailure;
go

/**
 * Formats the message for a failed comparison between two Strings.
 */

create function ssunit_impl.FormatStringCompareFailure
(
	@error		ssunit.TextMessage,		--!< The short error message.
	@expected	varchar(max),			--!< The expected value.
	@actual		varchar(max)			--!< The actual value.
)
	returns ssunit.TextMessage
as
begin
	declare @expectedAsString ssunit.TextMessage;
	set		@expectedAsString = isnull(@expected, '(null)');

	declare @actualAsString ssunit.TextMessage;
	set		@actualAsString  = isnull(@actual, '(null)');

	declare @reason ssunit.TextMessage;

	set @reason = @error + ' -'
				+ ' Expected: ''' + @expectedAsString + ''''
				+ ' Actual: '''   + @actualAsString   + '''';

	return @reason
end
go
