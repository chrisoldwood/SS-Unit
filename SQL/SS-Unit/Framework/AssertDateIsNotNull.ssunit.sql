/**
 * \file
 * \brief  The AssertDateIsNotNull stored procedure.
 * \author Chris Oldwood
 */

if (object_id('ssunit.AssertDateIsNotNull') is not null)
	drop procedure ssunit.AssertDateIsNotNull;
go

/**
 * Asserts that the Date value is not null.
 */

create procedure ssunit.AssertDateIsNotNull
(
	@actual		date		--!< The actual value.
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
