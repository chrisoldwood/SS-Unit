/**
 * \file
 * \brief  The GetAttributeName user-defined function.
 * \author Chris Oldwood
 */

if (object_id('ssunit_impl.GetAttributeName') is not null)
	drop function ssunit_impl.GetAttributeName;
go

/**
 * Retrieves the name of the attribute from the procedure, if present.
 */

create function ssunit_impl.GetAttributeName
(
	@procedure	ssunit.ProcedureName	--!< The name of the procedure
)
	returns ssunit_impl.AttributeName
as
begin
	declare @name ssunit_impl.AttributeName = null;

	declare @startIndex int = charindex('_@', @procedure);

	if (@startIndex <> 0)
	begin
		declare @endIndex int = charindex('@_', @procedure, @startIndex);

		if (@endIndex <> 0)
		begin
			return substring(@procedure, @startIndex+2, @endIndex-@startIndex-2);
		end
	end

	return @name;
end
go
