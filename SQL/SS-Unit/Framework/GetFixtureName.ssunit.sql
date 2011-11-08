/**
 * \file   GetFixtureName.ssunit.sql
 * \brief  The GetFixtureName user-defined function.
 * \author Chris Oldwood
 */

if (object_id('ssunit.GetFixtureName') is not null)
	drop function ssunit.GetFixtureName;
go

/**
 * Retrieves the name of the test fixture from the test name, if present.
 */

create function ssunit.GetFixtureName
(
	@procedure	ssunit.ProcedureName	--!< The name of the unit test procedure
)
	returns ssunit.FixtureName
as
begin
	declare @name ssunit.FixtureName = null;

	declare @startIndex int = charindex('_$', @procedure);

	if (@startIndex <> 0)
	begin
		declare @endIndex int = charindex('$_', @procedure, @startIndex);

		if (@endIndex <> 0)
		begin
			return substring(@procedure, @startIndex+2, @endIndex-@startIndex-2);
		end
	end

	return @name;
end
go
