/*******************************************************************************
**! \file   IsInteractive.ssunit.sql
**! \brief  The IsInteractive user-defined function.
**! \author Chris Oldwood
**/

if (object_id('ssunit.IsInteractive') is not null)
	drop function ssunit.IsInteractive;
go

/*******************************************************************************
** Queries if the test run is in an interactive tool (e.g. SSMS) or not.
**/

create function ssunit.IsInteractive() returns bit
as
begin
	declare	@application sysname;
	set		@application = app_name();

	declare @isInteractive bit;
	set		@isInteractive = 0;

	if (@application like '%Microsoft SQL Server Management Studio%')
		set @isInteractive = 1;

	return @isInteractive
end
go
