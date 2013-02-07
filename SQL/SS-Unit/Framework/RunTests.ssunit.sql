/**
 * \file
 * \brief  The RunTests stored procedure.
 * \author Chris Oldwood
 */

if (object_id('ssunit.RunTests') is not null)
	drop procedure ssunit.RunTests;
go

/**
 * Runs the suite of unit tests.
 *
 * By default all tests are assumed to be in a schema called 'test'.
 */

create procedure ssunit.RunTests
(
	@schemaName		ssunit.SchemaName = null,			--!< The schema used for the tests.
	@displayWidth	int = null,							--!< The width of the console in batch mode.
	@reportResults	ssunit.ReportCondition = null,		--!< Return the per-test results?
	@reportSummary	ssunit.ReportCondition = null,		--!< Return the test result summary?
	@isInteractive	bit = null,							--!< Override the output mode.
	@testNameFilter	ssunit.ProcedureName = null,		--!< The full or partial name of a test to run.
	@tearDownFirst	ssunit.Bool = null					--!< Run the tear-downs before fixture set-up?
)
as
	set nocount on;

	-- Configure runner.
	if (@schemaName is null)
		select @schemaName = SchemaName from ssunit_impl.Configuration c;

	if (@displayWidth is null)
		select @displayWidth = c.DisplayWidth from ssunit_impl.Configuration c;

	if (@reportResults is null)
		select @reportResults = c.ReportResults from ssunit_impl.Configuration c;

	if (@reportSummary is null)
		select @reportSummary = c.ReportSummary from ssunit_impl.Configuration c;

	if (@isInteractive is null)
		set @isInteractive = ssunit.IsInteractive();

	if (@tearDownFirst is null)
		select @tearDownFirst = c.TearDownFirst from ssunit_impl.Configuration c;

	-- Clear out any old results.
	exec ssunit_impl.TestResult_Clear;

	declare @testSchemaId int;

	-- Find the ID of the tests schema.
	select	@testSchemaId = schema_id
	from	sys.schemas s
	where	s.name = @schemaName;

	-- Validate all attribute names on procedures.
	declare @name ssunit_impl.AttributeName;

	select	@name = (@schemaName + '.' + p.name)
	from	sys.procedures p
	where	p.schema_id = @testSchemaId
	and		p.name like '%[_]@%@[_]%'
	and		ssunit_impl.GetAttributeName(p.name) <> 'Test'
	and		ssunit_impl.GetAttributeName(p.name) <> 'TestSetUp'
	and		ssunit_impl.GetAttributeName(p.name) <> 'TestTearDown'
	and		ssunit_impl.GetAttributeName(p.name) <> 'FixtureSetUp'
	and		ssunit_impl.GetAttributeName(p.name) <> 'FixtureTearDown'
	and		ssunit_impl.GetAttributeName(p.name) <> 'Helper'

	if (@name is not null)
	begin
		raiserror('Unknown SS-Unit attribute on procedure ''%s''', 16, 1, @name);
	end

	-- Find all unit test stored procedures.
	select	(@schemaName + '.' + p.name) as TestProcedure,
			ssunit_impl.GetFixtureName(p.name) as FixtureName
	into	#Tests
	from	sys.procedures p
	where	p.schema_id = @testSchemaId
	and		p.name like '%[_]@Test@[_]%'
	order	by FixtureName;

	-- Find all unit test fixtures.
	select	ssunit_impl.GetFixtureName(p.name) as FixtureName,
			count(*) as TestCount
	into	#Fixtures
	from	sys.procedures p
	where	p.schema_id = @testSchemaId
	and		p.name like '%[_]@Test@[_]%'
	group	by ssunit_impl.GetFixtureName(p.name)

	declare @currentFixture ssunit_impl.FixtureName = '[none]',
			@fixtureTestCount int = 0,
			@fixtureSetUpProcedure ssunit.ProcedureName,
			@fixtureTearDownProcedure ssunit.ProcedureName,
			@testSetUpProcedure ssunit.ProcedureName,
			@testTearDownProcedure ssunit.ProcedureName;

	-- For all tests...
	declare TestCursor cursor local fast_forward
	for
	select	TestProcedure,FixtureName
	from	#Tests;

	open TestCursor;

	while (1 = 1)
	begin
		declare @testProcedure ssunit.ProcedureName,
				@fixtureName ssunit_impl.FixtureName;

		fetch	next
		from	TestCursor
		into	@testProcedure, @fixtureName;

		if (@@fetch_status <> 0)
			break;

		-- First test of different fixture?
		if (isnull(@fixtureName, '') <> isnull(@currentFixture, ''))
		begin
			select	@fixtureTestCount = TestCount
			from	#Fixtures
			where	isnull(FixtureName, '') = isnull(@fixtureName, '');

			declare @fixtureFilter ssunit.ProcedureName = '%[_]$' + @fixtureName + '$[_]%';

			if (exists(	select	1
						from	sys.procedures p
						where	p.schema_id = @testSchemaId
						and		p.name like @fixtureFilter
						and
						(
								p.name like '%[_]@FixtureSetUp@[_]%'
							or	p.name like '%[_]@FixtureTearDown@[_]%'
							or	p.name like '%[_]@TestSetUp@[_]%'
							or	p.name like '%[_]@TestTearDown@[_]%'
						)
						group	by substring(p.name, charindex('_@', p.name)+2, charindex('@_', p.name)-(charindex('_@', p.name)+2))
						having	count(*) > 1
				))
			begin
				raiserror('Duplicate Fixture/Test SetUp/TearDown procedure defined', 16, 1);
			end

			select	@fixtureSetUpProcedure = (@schemaName + '.' + p.name)
			from	sys.procedures p
			where	p.schema_id = @testSchemaId
			and		p.name like @fixtureFilter
			and		p.name like '%[_]@FixtureSetUp@[_]%'

			select	@fixtureTearDownProcedure = (@schemaName + '.' + p.name)
			from	sys.procedures p
			where	p.schema_id = @testSchemaId
			and		p.name like @fixtureFilter
			and		p.name like '%[_]@FixtureTearDown@[_]%'

			select	@testSetUpProcedure = (@schemaName + '.' + p.name)
			from	sys.procedures p
			where	p.schema_id = @testSchemaId
			and		p.name like @fixtureFilter
			and		p.name like '%[_]@TestSetUp@[_]%'

			select	@testTearDownProcedure = (@schemaName + '.' + p.name)
			from	sys.procedures p
			where	p.schema_id = @testSchemaId
			and		p.name like @fixtureFilter
			and		p.name like '%[_]@TestTearDown@[_]%'

			set @currentFixture = @fixtureName;
		end

		exec ssunit_impl.CurrentTest_SetTest @procedure = @testProcedure;

		-- Set-up the test fixture
		if (@tearDownFirst = ssunit.True())
		begin
			if (@testTearDownProcedure is not null)
			begin
				exec ssunit_impl.RunTestTearDown @procedure = @testTearDownProcedure;
			end

			if (@fixtureTearDownProcedure is not null)
			begin
				exec ssunit_impl.RunFixtureTearDown @procedure = @fixtureTearDownProcedure;
			end
		end

		if (@fixtureSetUpProcedure is not null)
		begin
			exec ssunit_impl.RunFixtureSetUp @procedure = @fixtureSetUpProcedure;

			set @fixtureSetUpProcedure = null;
		end

		-- Run the test.
		if ( (@testNameFilter is null) or (@testProcedure like @testNameFilter) )
		begin
			exec ssunit_impl.RunTest @procedure = @testProcedure,
									 @setUpProcedure = @testSetUpProcedure,
									 @tearDownProcedure = @testTearDownProcedure;
		end

		-- Drop the unit test procedure.
		exec('drop procedure ' + @testProcedure);

		if (@currentFixture is not null)
		begin
			set @fixtureTestCount = @fixtureTestCount - 1;
		end

		-- Cleanup fixture, if last test for fixture.
		if (@fixtureTestCount = 0)
		begin
			if (@fixtureTearDownProcedure is not null)
			begin
				exec ssunit_impl.RunFixtureTearDown @procedure = @fixtureTearDownProcedure;

				set @fixtureTearDownProcedure = null;
			end

			if (@currentFixture is not null)
			begin
				exec ssunit_impl.TestFixture_Delete @schemaName, @currentFixture;
			end

			set @testSetUpProcedure = null;
			set @testTearDownProcedure = null;
		end
	end

	close TestCursor;
	deallocate TestCursor;

	-- Remove any additional helper procedures.
	exec ssunit_impl.TestHelper_Delete @schemaName;

	-- Any failures?
	declare @failures int;
	select	@failures = count(*)
	from	ssunit_impl.TestResult r
	where	r.Outcome = ssunit_impl.TestOutcome_Failed();

	-- Toggle outputs based on failure count.
	if ( (@reportResults = ssunit.ReportCondition_OnFailure()) and (@failures != 0))
		set @reportResults = ssunit.ReportCondition_Always();

	if ( (@reportSummary = ssunit.ReportCondition_OnFailure()) and (@failures != 0))
		set @reportSummary = ssunit.ReportCondition_Always();

	-- Display the result of each test.
	if (@reportResults = ssunit.ReportCondition_Always())
	begin
		if (@isInteractive = 1)
		begin
			select	ssunit_impl.TestOutcome_ToString(r.Outcome)			as [Outcome],
					ssunit_impl.FormatResultTestName(r.TestProcedure)	as [Test Name],
					isnull(r.FailureReason, '')							as [Failure Reason]
			from	ssunit_impl.TestResult r
			order	by r.TestOrder;
		end
		else
		begin
			declare @outcomeWidth   int = 8;
			declare @procedureWidth int = (@displayWidth - @outcomeWidth) / 2;
			declare @reasonWidth    int = (@displayWidth - (@outcomeWidth + @procedureWidth));

			declare @query varchar(max) =
			  'select convert(varchar(' + convert(varchar, @outcomeWidth-1)   + '), ssunit_impl.TestOutcome_ToString(r.Outcome))       as [Outcome], '
			+ '       convert(varchar(' + convert(varchar, @procedureWidth-1) + '), ssunit_impl.FormatResultTestName(r.TestProcedure)) as [Test Name], '
			+ '       convert(varchar(' + convert(varchar, @reasonWidth-1)    + '), isnull(r.FailureReason, ''''))                     as [Failure Reason] '
			+ 'from   ssunit_impl.TestResult r '
			+ 'order  by r.TestOrder; ';

			exec(@query);
			--print @query;
		end
	end

	-- Separate the results/summary.
	if ((@reportResults = ssunit.ReportCondition_Always()) and (@reportSummary = ssunit.ReportCondition_Always()))
	begin
		if (@isInteractive = 0)
		begin
			select '';
		end
	end

	-- Display a summary of the test results.
	if (@reportSummary = ssunit.ReportCondition_Always())
	begin
		select	isnull([Passed],  0) as [Passed],
				isnull([FAILED],  0) as [Failed],
				isnull([Unknown], 0) as [Unknown]
		from
		(
				select	ssunit_impl.TestOutcome_ToString(r.Outcome)	as [Outcome],
						count(*)									as [Total]
				from	ssunit_impl.TestResult r
				group	by r.Outcome
		)
		as SourceTable
		pivot
		(
				sum([Total])
				for [Outcome] in ([Passed], [FAILED], [Unknown])
		)
		as PivotTable;
	end

	-- Signal test run failure only in batch mode.
	if ( (@isInteractive = 0) and (@failures != 0) )
	begin
		raiserror('One or more unit tests failed', 16, 1);
	end
go
