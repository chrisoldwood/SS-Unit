/**
 * \file
 * \brief  The FormatResultTestName user-defined function.
 * \author Chris Oldwood
 */

if (object_id('ssunit_impl.FormatResultTestName') is not null)
	drop function ssunit_impl.FormatResultTestName;
go

/**
 * Formats the test name for inclusion in the test results.
 *
 * This strips the schema, test and fixture attributes to just leave the
 * unadorned name which is hopefully the more useful part.
 */

create function ssunit_impl.FormatResultTestName
(
	@procedure	ssunit.ProcedureName	--!< The name of the unit test procedure
)
	returns ssunit.ProcedureName
as
begin
	declare @index int = charindex('.', @procedure);

	if (@index <> 0)
	begin
		set @procedure = substring(@procedure, @index+1, len(@procedure)-@index);
	end

	declare @fixtureName ssunit_impl.FixtureName = ssunit_impl.GetFixtureName(@procedure);

	if (@fixtureName is not null)
	begin
		set @procedure = replace(@procedure, '_$' + @fixtureName + '$_', '');
	end

	set @procedure = replace(@procedure, '_@test@_', '');

	-- If we've already stripped the fixture attribute we may have also
	-- removed the leading or trailing '_' from the TEST attribute too.
	if (@fixtureName is not null)
	begin
		set @procedure = replace(@procedure, '@test@_', '');
		set @procedure = replace(@procedure, '_@test@', '');
	end

	return @procedure;
end
go
