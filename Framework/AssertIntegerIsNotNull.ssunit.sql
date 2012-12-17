/**
 * \file
 * \brief  The AssertIntegerIsNotNull stored procedure.
 * \author Chris Oldwood
 */

if (object_id('ssunit.AssertIntegerIsNotNull') is not null)
	drop procedure ssunit.AssertIntegerIsNotNull;
go

/**
 * Asserts that the integer value is not null.
 */

create procedure ssunit.AssertIntegerIsNotNull
(
	@actual		int		--!< The actual value.
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
