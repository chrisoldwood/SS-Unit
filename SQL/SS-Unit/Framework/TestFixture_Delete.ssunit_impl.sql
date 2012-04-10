/**
 * \file
 * \brief  The TestFixture_Delete stored procedure.
 * \author Chris Oldwood
 */

if (object_id('ssunit_impl.TestFixture_Delete') is not null)
	drop procedure ssunit_impl.TestFixture_Delete;
go

/**
 * Deletes the test fixture helper procedures.
 */

create procedure ssunit_impl.TestFixture_Delete
(
	@schemaName		ssunit.SchemaName,		--!< The schema used for the tests.
	@fixtureName	ssunit_impl.FixtureName		--!< The name of the fixture.
)
as
	declare @testSchemaId int;

	select	@testSchemaId = schema_id
	from	sys.schemas s
	where	s.name = @schemaName;

	declare @fixtureFilter ssunit.ProcedureName = '%[_]$' + @fixtureName + '$[_]%';

	declare ProcedureCursor cursor local fast_forward
	for
	select	(@schemaName + '.' + p.name) as ProcedureName
	from	sys.procedures p
	where	p.schema_id = @testSchemaId
	and		p.name like @fixtureFilter;

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
