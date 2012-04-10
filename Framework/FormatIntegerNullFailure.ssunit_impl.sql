/**
 * \file   FormatIntegerNullFailure.ssunit.sql
 * \brief  The FormatIntegerNullFailure user-defined function.
 * \author Chris Oldwood
 */

if (object_id('ssunit.FormatIntegerNullFailure') is not null)
	drop function ssunit.FormatIntegerNullFailure;
go

/**
 * Formats the message for a failed integer comparison with NULL.
 */

create function ssunit.FormatIntegerNullFailure
(
	@expected	int,	--!< The expected value.
	@actual		int		--!< The actual value.
)
	returns ssunit.TextMessage
as
begin
	declare @expectedAsString ssunit.TextMessage;
	set		@expectedAsString = isnull(convert(varchar(max), @expected), '(null)');

	declare @actualAsString ssunit.TextMessage;
	set		@actualAsString  = isnull(convert(varchar(max), @actual), '(null)');

	declare @reason ssunit.TextMessage;

	set @reason = 'Comparison with NULL.'
				+ ' Expected: ' + @expectedAsString 
				+ ' Actual: '   + @actualAsString;

	return @reason
end
go
