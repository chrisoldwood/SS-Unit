/**
 * \file   FormatStringNullFailure.ssunit.sql
 * \brief  The FormatStringNullFailure user-defined function.
 * \author Chris Oldwood
 */

if (object_id('ssunit.FormatStringNullFailure') is not null)
	drop function ssunit.FormatStringNullFailure;
go

/**
 * Formats the message for a failed String comparison with NULL.
 */

create function ssunit.FormatStringNullFailure
(
	@expected	varchar(max),	--!< The expected value.
	@actual		varchar(max)	--!< The actual value.
)
	returns ssunit.TextMessage
as
begin
	declare @expectedAsString ssunit.TextMessage;
	set		@expectedAsString = isnull(@expected, '(null)');

	if (@expected is not null)
		set @expectedAsString = '''' + @expectedAsString + '''';

	declare @actualAsString ssunit.TextMessage;
	set		@actualAsString  = isnull(@actual, '(null)');

	if (@actual is not null)
		set @actualAsString = '''' + @actualAsString + '''';

	declare @reason ssunit.TextMessage;

	set @reason = 'Comparison with NULL.'
				+ ' Expected: ' + @expectedAsString
				+ ' Actual: '   + @actualAsString;

	return @reason
end
go
