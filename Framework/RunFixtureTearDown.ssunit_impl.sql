/**
 * \file
 * \brief  The RunFixtureTearDown stored procedure.
 * \author Chris Oldwood
 */

if (object_id('ssunit_impl.RunFixtureTearDown') is not null)
	drop procedure ssunit_impl.RunFixtureTearDown;
go

/**
 * Runs the test fixture tear-down procedure.
 */

create procedure ssunit_impl.RunFixtureTearDown
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
		set		@error = 'Error raised in fixture tear-down ''' + @procedure + ''' - '
					   + error_message();

		exec ssunit.AssertFail @error;

	end catch
go
