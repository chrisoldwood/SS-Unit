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
 * NB: The error is compared with the LIKE operator.
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

	-- Drop the helper procedure.
	declare @statement varchar(max);
	set		@statement = 'drop procedure ' + @procedure;

	exec(@statement);
go
