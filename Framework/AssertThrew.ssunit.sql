/**
 * \file   AssertThrew.ssunit.sql
 * \brief  The AssertThrew stored procedure.
 * \author Chris Oldwood
 */

if (object_id('ssunit.AssertThrew') is not null)
	drop procedure ssunit.AssertThrew;
go

/**
 * Asserts that the test raised an error that contained the specified message.
 * The error is compared with the LIKE operator and so can contain wildcard
 * characters.
 *
 * \Note The helper procedure should contain the '_@Helper@_' attribute in its
 * name so that it is dropped automatically by the framework at the end of the
 * test run to save dropping it manually.
 */

create procedure ssunit.AssertThrew
(
	@error		ssunit.TextMessage,		--!< The expected error message.
	@procedure	ssunit.ProcedureName	--!< The helper procedure to run.
)
as
	begin try

		exec @procedure;

		exec ssunit.AssertFail 'No error was raised';

	end try
	begin catch

		if (error_message() like @error)
		begin
			exec ssunit.AssertPass;
		end
		else
		begin
			declare @reason ssunit.TextMessage;
			set		@reason = 'The wrong error was raised. '
							+ ' Expected: "' + @error + '"'
							+ ' Actual: "' + error_message() + '"';

			exec ssunit.AssertFail @reason;
		end

	end catch
go
