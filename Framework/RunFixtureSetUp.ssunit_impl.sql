/**
 * \file
 * \brief  The RunFixtureSetUp stored procedure.
 * \author Chris Oldwood
 */

if (object_id('ssunit_impl.RunFixtureSetUp') is not null)
	drop procedure ssunit_impl.RunFixtureSetUp;
go

/**
 * Runs the test fixture set-up procedure.
 */

create procedure ssunit_impl.RunFixtureSetUp
(
	@procedure		ssunit.ProcedureName		--!< The set-up procedure.
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
		set		@error = 'Error raised in fixture set-up ''' + @procedure + ''' - '
					   + error_message();

		exec ssunit.AssertFail @error;

	end catch
go
