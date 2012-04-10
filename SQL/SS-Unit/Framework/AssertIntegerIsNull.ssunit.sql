/**
 * \file
 * \brief  The AssertIntegerIsNull stored procedure.
 * \author Chris Oldwood
 */

if (object_id('ssunit.AssertIntegerIsNull') is not null)
	drop procedure ssunit.AssertIntegerIsNull;
go

/**
 * Asserts that the integer value is null.
 */

create procedure ssunit.AssertIntegerIsNull
(
	@actual		int		--!< The actual value.
)
as
	if (@actual is null)
	begin
		exec ssunit.AssertPass;
	end
	else
	begin
		declare @actualAsString ssunit.TextMessage;
		set		@actualAsString  = isnull(convert(varchar(max), @actual), '(null)');

		declare @reason ssunit.TextMessage;
		set		@reason = 'Actual was not NULL -'
						+ ' Actual: '   + @actualAsString;

		exec ssunit.AssertFail @reason;
	end
go
