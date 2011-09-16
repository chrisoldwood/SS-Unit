/**
 * \file   AssertDateTimeIsNull.ssunit.sql
 * \brief  The AssertDateTimeIsNull stored procedure.
 * \author Chris Oldwood
 */

if (object_id('ssunit.AssertDateTimeIsNull') is not null)
	drop procedure ssunit.AssertDateTimeIsNull;
go

/**
 * Asserts that the DateTime value is null.
 */

create procedure ssunit.AssertDateTimeIsNull
(
	@actual		datetime		--!< The actual value.
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
		set		@reason = 'Value was not NULL -'
						+ ' Actual: '   + @actualAsString;

		exec ssunit.AssertFail @reason;
	end
go
