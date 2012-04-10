/**
 * \file
 * \brief  The AssertStringIsNull stored procedure.
 * \author Chris Oldwood
 */

if (object_id('ssunit.AssertStringIsNull') is not null)
	drop procedure ssunit.AssertStringIsNull;
go

/**
 * Asserts that the String value is null.
 */

create procedure ssunit.AssertStringIsNull
(
	@actual		varchar(max)	--!< The actual value.
)
as
	if (@actual is null)
	begin
		exec ssunit.AssertPass;
	end
	else
	begin
		declare @actualAsString ssunit.TextMessage;
		set		@actualAsString  = isnull(@actual, '(null)');

		declare @reason ssunit.TextMessage;
		set		@reason = 'Actual was not NULL -'
						+ ' Actual: ''' + @actualAsString +'''';

		exec ssunit.AssertFail @reason;
	end
go
