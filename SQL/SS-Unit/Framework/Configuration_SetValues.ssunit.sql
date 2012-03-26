/**
 * \file   Configuration_SetValues.ssunit.sql
 * \brief  The Configuration table stored procedures.
 * \author Chris Oldwood
 */

if (object_id('ssunit.Configuration_SetSchemaNameDefault') is not null)
	drop procedure ssunit.Configuration_SetSchemaNameDefault;
go

if (object_id('ssunit.Configuration_SetDisplayWidthDefault') is not null)
	drop procedure ssunit.Configuration_SetDisplayWidthDefault;
go

if (object_id('ssunit.Configuration_SetReportResultsDefault') is not null)
	drop procedure ssunit.Configuration_SetReportResultsDefault;
go

if (object_id('ssunit.Configuration_SetReportSummaryDefault') is not null)
	drop procedure ssunit.Configuration_SetReportSummaryDefault;
go

/**
 * Sets the default schema name used for the tests.
 */

create procedure ssunit.Configuration_SetSchemaNameDefault
(
	@value	ssunit.SchemaName	--!< The configuration value.
)
as
	set nocount on;

	declare @error varchar(max);

	begin try

		if (@value is null)
			raiserror('Invalid schema name: (null)', 16, 1);
	
		update	ssunit.Configuration
		set		SchemaName = @value;

	end try
	begin catch

		if (@@trancount != 0)
			rollback transaction;

		set @error = 'Failed to set configuration value - '
				   + error_message();
		
		raiserror(@error, 16, 1);

	end catch
go

/**
 * Sets the default width for console output.
 */

create procedure ssunit.Configuration_SetDisplayWidthDefault
(
	@value	int					--!< The configuration value.
)
as
	set nocount on;

	declare @error varchar(max);

	begin try

		if (@value is null)
			raiserror('Invalid display width: (null)', 16, 1);
	
		if (@value <= 0)
		begin
			set @error = 'Invalid display width: ' + convert(varchar, @value);
			raiserror(@error, 16, 1);
		end
	
		update	ssunit.Configuration
		set		DisplayWidth = @value;

	end try
	begin catch

		if (@@trancount != 0)
			rollback transaction;

		set @error = 'Failed to set configuration value - '
				   + error_message();
		
		raiserror(@error, 16, 1);

	end catch
go

/**
 * Sets the default flag for reporting the per-test results.
 */

create procedure ssunit.Configuration_SetReportResultsDefault
(
	@value	ssunit.ReportCondition		--!< The configuration value.
)
as
	set nocount on;

	declare @error varchar(max);

	begin try

		if (@value is null)
			raiserror('Invalid ''report results'' flag: (null)', 16, 1);
	
		if (ssunit.ReportCondition_IsValid(@value) <> 1)
		begin
			set @error = 'Invalid ''report results'' flag: ' + convert(varchar, @value);

			raiserror(@error, 16, 1);
		end
	
		update	ssunit.Configuration
		set		ReportResults = @value;

	end try
	begin catch

		if (@@trancount != 0)
			rollback transaction;

		set @error = 'Failed to set configuration value - '
				   + error_message();
		
		raiserror(@error, 16, 1);

	end catch
go

/**
 * Sets the default flag for reporting the results summary.
 */

create procedure ssunit.Configuration_SetReportSummaryDefault
(
	@value	ssunit.ReportCondition		--!< The configuration value.
)
as
	set nocount on;

	declare @error varchar(max);

	begin try

		if (@value is null)
			raiserror('Invalid ''report summary'' flag: (null)', 16, 1);
	
		if (ssunit.ReportCondition_IsValid(@value) <> 1)
		begin
			set @error = 'Invalid ''report summary'' flag: ' + convert(varchar, @value);

			raiserror(@error, 16, 1);
		end
	
		update	ssunit.Configuration
		set		ReportSummary = @value;

	end try
	begin catch

		if (@@trancount != 0)
			rollback transaction;

		set @error = 'Failed to set configuration value - '
				   + error_message();
		
		raiserror(@error, 16, 1);

	end catch
go
