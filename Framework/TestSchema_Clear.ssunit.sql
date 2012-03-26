/**
 * \file   TestSchema_Clear.ssunit.sql
 * \brief  The TestSchema_Clear stored procedure.
 * \author Chris Oldwood
 */

if (object_id('ssunit.TestSchema_Clear') is not null)
	drop procedure ssunit.TestSchema_Clear;
go

/**
 * Clears the named schema of all objects.
 *
 * This helper procedure makes it easier to avoid those nasty errors that crop
 * up when there are bugs in the setup/teardown procedures or your tests when
 * you're first writing them. It deletes all objects from the schema so that
 * when you run your test script you can guarentee that you're starting from a
 * clean slate.
 *
 * \Note By default it clears all objects from the default test schema which is
 * called 'test'.
 */

create procedure ssunit.TestSchema_Clear
(
	@schemaName		ssunit.SchemaName = null	--!< The schema used for the tests.
)
as
	-- Get the configueration
	if (@schemaName is null)
		select @schemaName = SchemaName from ssunit.Configuration c;

	declare @testSchemaId int;

	-- Find the ID of the tests schema.
	select	@testSchemaId = schema_id
	from	sys.schemas s
	where	s.name = @schemaName;

	-- For all objects in the schema...
	declare ObjectCursor cursor local fast_forward
	for
	select	(@schemaName + '.' + o.name) as TestObject,
			o.type                       as ObjectType
	from	sys.objects o
	where	o.schema_id = @testSchemaId

	open ObjectCursor;

	while (1 = 1)
	begin
		declare @objectName sysname;
		declare @objectType char(1);

		fetch	next
		from	ObjectCursor
		into	@objectName, @objectType;

		if (@@fetch_status <> 0)
			break;

		-- Procedure?
		if (@objectType = 'P')
		begin
			exec('drop procedure ' + @objectName);
		end
		else if (@objectType = 'F')
		begin
			exec('drop function ' + @objectName);
		end
		else if (@objectType = 'U')
		begin
			exec('drop table ' + @objectName);
		end
		else
		begin
			print 'TestSchema_Clear - unknown object - type: ''' + @objectType + ''' name: ''' + @objectName +'''';
		end
	end

	close ObjectCursor;
	deallocate ObjectCursor;
go
