/**
 * \file
 * \brief  The AssertRealIsNotNull stored procedure.
 * \author Chris Oldwood
 */

if (object_id('ssunit.AssertRealIsNotNull') is not null)
	drop procedure ssunit.AssertRealIsNotNull;
go

/**
 * Asserts that the real number value is not null.
 */

create procedure ssunit.AssertRealIsNotNull
(
	@actual		real	--!< The actual value.
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
