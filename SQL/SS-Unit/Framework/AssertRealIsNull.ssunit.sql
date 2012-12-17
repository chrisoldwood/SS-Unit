/**
 * \file
 * \brief  The AssertRealIsNull stored procedure.
 * \author Chris Oldwood
 */

if (object_id('ssunit.AssertRealIsNull') is not null)
	drop procedure ssunit.AssertRealIsNull;
go

/**
 * Asserts that the real number value is null.
 */

create procedure ssunit.AssertRealIsNull
(
	@actual		real	--!< The actual value.
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
