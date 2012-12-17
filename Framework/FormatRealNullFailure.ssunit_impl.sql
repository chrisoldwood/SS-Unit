/**
 * \file
 * \brief  The FormatRealNullFailure user-defined function.
 * \author Chris Oldwood
 */

if (object_id('ssunit_impl.FormatRealNullFailure') is not null)
	drop function ssunit_impl.FormatRealNullFailure;
go

/**
 * Formats the message for a failed real number comparison with NULL.
 */

create function ssunit_impl.FormatRealNullFailure
(
	@expected	real,	--!< The expected value.
	@actual		real	--!< The actual value.
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
