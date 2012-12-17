/**
 * \file
 * \brief  The AssertDateIsNull stored procedure.
 * \author Chris Oldwood
 */

if (object_id('ssunit.AssertDateIsNull') is not null)
	drop procedure ssunit.AssertDateIsNull;
go

/**
 * Asserts that the Date value is null.
 */

create procedure ssunit.AssertDateIsNull
(
	@actual		date		--!< The actual value.
)
as
	if (@actual is null)
	begin
		exec ssunit.AssertPass;
	end
	else
	begin
		declare @actualAsString ssunit.TextMessage;
		set		@actualAsString  = isnull(convert(varchar(max), @actual, 121), '(null)');

		declare @reason ssunit.TextMessage;
		set		@reason = 'Actual was not NULL -'
						+ ' Actual: '   + @actualAsString;

		exec ssunit.AssertFail @reason;
	end
go
