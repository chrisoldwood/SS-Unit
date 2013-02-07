/**
 * \file
 * \brief  The Version user-defined function.
 * \author Chris Oldwood
 */

if (object_id('ssunit.Version') is not null)
	drop function ssunit.Version;
go

/**
 * Retrieves the version number of SS-Unit.
 * \note See the Version UDT documentation for more details on the format.
 */

create function ssunit.Version()
	returns ssunit.Version
as
begin
	return 150;
end
go
