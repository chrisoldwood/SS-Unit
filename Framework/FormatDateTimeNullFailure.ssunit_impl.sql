/**
 * \file
 * \brief  The FormatDateTimeNullFailure user-defined function.
 * \author Chris Oldwood
 */

if (object_id('ssunit_impl.FormatDateTimeNullFailure') is not null)
	drop function ssunit_impl.FormatDateTimeNullFailure;
go

/**
 * Formats the message for a failed DateTime comparison with NULL.
 */

create function ssunit_impl.FormatDateTimeNullFailure
(
	@expected	datetime,	--!< The expected value.
	@actual		datetime	--!< The actual value.
)
	returns ssunit.TextMessage
as
begin
	declare @expectedAsString ssunit.TextMessage;
	set		@expectedAsString = isnull(convert(varchar(max), @expected, 121), '(null)');

	declare @actualAsString ssunit.TextMessage;
	set		@actualAsString  = isnull(convert(varchar(max), @actual, 121), '(null)');

	declare @reason ssunit.TextMessage;

	set @reason = 'Comparison with NULL.'
				+ ' Expected: ' + @expectedAsString 
				+ ' Actual: '   + @actualAsString;

	return @reason
end
go
