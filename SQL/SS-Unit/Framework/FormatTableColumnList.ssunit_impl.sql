/**
 * \file
 * \brief  The FormatTableColumnList user-defined function.
 * \author Chris Oldwood
 */

if (object_id('ssunit_impl.FormatTableColumnList') is not null)
	drop function ssunit_impl.FormatTableColumnList;
go

/**
 * Formats the columns of a table into a comma-separated list.
 */

create function ssunit_impl.FormatTableColumnList
(
	@name	ssunit.TableName	--!< The name of the table.
)
	returns ssunit_impl.List
as
begin
	declare @columns ssunit_impl.List = '';

	declare columnCursor cursor local fast_forward
	for
	select	c.name
	from	sys.schemas s
	join	sys.tables t
	on		t.schema_id = s.schema_id
	join	sys.columns c
	on		c.object_id = t.object_id
	and		s.name + '.' + t.name = @name
	order	by c.column_id

	open columnCursor;

	while (1 = 1)
	begin
		declare @column sysname;

		fetch	next
		from	columnCursor
		into	@column;

		if (@@fetch_status <> 0)
			break;

		set @columns = @columns + @column + ',';
	end

	close columnCursor;
	deallocate columnCursor;

	if (len(@columns) <> 0)
		set @columns = substring(@columns, 1, len(@columns)-1);

	return @columns;
end
go
