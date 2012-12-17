/**
 * \file
 * \brief  The RunTestSetUp stored procedure.
 * \author Chris Oldwood
 */

if (object_id('ssunit_impl.RunTestSetUp') is not null)
	drop procedure ssunit_impl.RunTestSetUp;
go

/**
 * Runs the per-test set-up procedure.
 */

create procedure ssunit_impl.RunTestSetUp
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
		set		@error = 'Error raised in per-test set-up ''' + @procedure + ''' - '
					   + error_message();

		exec ssunit.AssertFail @error;

	end catch
go
