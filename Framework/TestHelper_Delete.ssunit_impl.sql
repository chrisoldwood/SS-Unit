/**
 * \file
 * \brief  The TestHelper_Delete stored procedure.
 * \author Chris Oldwood
 */

if (object_id('ssunit_impl.TestHelper_Delete') is not null)
	drop procedure ssunit_impl.TestHelper_Delete;
go

/**
 * Deletes the test helper procedures.
 */

create procedure ssunit_impl.TestHelper_Delete
(
	@schemaName		ssunit.SchemaName		--!< The schema used for the tests.
)
as
	declare @testSchemaId int;

	select	@testSchemaId = schema_id
	from	sys.schemas s
	where	s.name = @schemaName;

	declare ProcedureCursor cursor local fast_forward
	for
	select	(@schemaName + '.' + p.name) as ProcedureName
	from	sys.procedures p
	where	p.schema_id = @testSchemaId
	and		p.name like '[_]@Helper@[_]%';

	open ProcedureCursor;

	while (1 = 1)
	begin
		declare @procedure ssunit.ProcedureName;

		fetch	next
		from	ProcedureCursor
		into	@procedure;

		if (@@fetch_status <> 0)
			break;

		exec('drop procedure ' + @procedure);
	end

	close ProcedureCursor;
	deallocate ProcedureCursor;
go
