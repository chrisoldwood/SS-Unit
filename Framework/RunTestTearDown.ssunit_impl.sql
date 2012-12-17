/**
 * \file
 * \brief  The RunTestTearDown stored procedure.
 * \author Chris Oldwood
 */

if (object_id('ssunit_impl.RunTestTearDown') is not null)
	drop procedure ssunit_impl.RunTestTearDown;
go

/**
 * Runs the per-test tear-down procedure.
 */

create procedure ssunit_impl.RunTestTearDown
(
	@procedure		ssunit.ProcedureName		--!< The tear-down procedure.
)
as
	begin try

		exec @procedure;

	end try
	begin catch

		if (@@trancount != 0)
		begin
			rollback transaction;
		end

		declare @error ssunit.TextMessage;
		set		@error = 'Error raised in per-test tear-down ''' + @procedure + ''' - '
					   + error_message();

		exec ssunit.AssertFail @error;

	end catch
go
