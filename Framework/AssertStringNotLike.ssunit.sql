/**
 * \file   AssertStringNotLike.ssunit.sql
 * \brief  The AssertStringNotLike stored procedure.
 * \author Chris Oldwood
 */

if (object_id('ssunit.AssertStringNotLike') is not null)
	drop procedure ssunit.AssertStringNotLike;
go

/**
 * Asserts that the regular expression doesn't match the string.
 */

create procedure ssunit.AssertStringNotLike
(
	@regex	varchar(max),	--!< The regular expression.
	@actual	varchar(max)	--!< The string to search.
)
as
	declare @reason ssunit.TextMessage;

	declare @regexAsString ssunit.TextMessage;
	set		@regexAsString = isnull(@regex, '(null)');

	if (@regex is not null)
		set @regexAsString = '''' + @regexAsString + '''';

	declare @actualAsString ssunit.TextMessage;
	set		@actualAsString  = isnull(@actual, '(null)');

	if (@actual is not null)
		set @actualAsString = '''' + @actualAsString + '''';

	if ( (@regex is null) or (@actual is null) )
	begin
		set @reason = 'Comparison with NULL.'
					+ ' Regex: '  + @regexAsString
					+ ' String: ' + @actualAsString;

		exec ssunit.AssertFail @reason;
	end
	else if (@actual not like @regex)
	begin
		exec ssunit.AssertPass;
	end
	else
	begin
		set @reason = 'Match found.'
					+ ' Regex: '  + @regexAsString
					+ ' String: ' + @actualAsString;

		exec ssunit.AssertFail @reason;
	end
go
