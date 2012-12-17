/**
 * \file
 * \brief  The AssertStringIsNotNull stored procedure.
 * \author Chris Oldwood
 */

if (object_id('ssunit.AssertStringIsNotNull') is not null)
	drop procedure ssunit.AssertStringIsNotNull;
go

/**
 * Asserts that the String value is not null.
 */

create procedure ssunit.AssertStringIsNotNull
(
	@actual		varchar(max)	--!< The actual value.
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
