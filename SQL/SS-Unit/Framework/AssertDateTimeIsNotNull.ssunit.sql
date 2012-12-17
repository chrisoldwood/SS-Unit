/**
 * \file
 * \brief  The AssertDateTimeIsNotNull stored procedure.
 * \author Chris Oldwood
 */

if (object_id('ssunit.AssertDateTimeIsNotNull') is not null)
	drop procedure ssunit.AssertDateTimeIsNotNull;
go

/**
 * Asserts that the DateTime value is not null.
 */

create procedure ssunit.AssertDateTimeIsNotNull
(
	@actual		datetime		--!< The actual value.
)
as
	if (@actual is not null)
	begin
		exec ssunit.AssertPass;
	end
	else
	begin
		declare @reason ssunit.TextMessage;
		set		@reason = 'Actual was NULL';

		exec ssunit.AssertFail @reason;
	end
go
