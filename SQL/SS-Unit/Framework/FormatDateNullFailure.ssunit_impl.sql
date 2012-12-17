/**
 * \file
 * \brief  The FormatDateNullFailure user-defined function.
 * \author Chris Oldwood
 */

if (object_id('ssunit_impl.FormatDateNullFailure') is not null)
	drop function ssunit_impl.FormatDateNullFailure;
go

/**
 * Formats the message for a failed Date comparison with NULL.
 */

create function ssunit_impl.FormatDateNullFailure
(
	@expected	date,	--!< The expected value.
	@actual		date	--!< The actual value.
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
