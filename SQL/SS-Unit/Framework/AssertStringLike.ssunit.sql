/**
 * \file   AssertStringLike.ssunit.sql
 * \brief  The AssertStringLike stored procedure.
 * \author Chris Oldwood
 */

if (object_id('ssunit.AssertStringLike') is not null)
	drop procedure ssunit.AssertStringLike;
go

/**
 * Asserts that the regular expression matches the string.
 */

create procedure ssunit.AssertStringLike
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
	else if (@actual like @regex)
	begin
		exec ssunit.AssertPass;
	end
	else
	begin
		set @reason = 'No match found.'
					+ ' Regex: '  + @regexAsString
					+ ' String: ' + @actualAsString;

		exec ssunit.AssertFail @reason;
	end
go
