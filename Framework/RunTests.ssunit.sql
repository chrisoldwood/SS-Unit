/*******************************************************************************
**! \file   RunTests.sql
**! \brief  The RunTests stored procedure.
**! \author Chris Oldwood
**/

if (object_id('ssunit.RunTests') is not null)
	drop procedure ssunit.RunTests;
go

/*******************************************************************************
** Runs the suite of unit tests.
**/

create procedure ssunit.RunTests
as
	set nocount on;

	-- Clear out any old results.
	exec ssunit.TestResult_Clear;

	declare @testSchemaId int;

	-- Find the ID of the 'test' schema.
	select	@testSchemaId = schema_id
	from	sys.schemas s
	where	s.name = 'test';

	-- Find all unit test stored procedures.
	select	p.name as TestProcedure
	into	#Tests
	from	sys.procedures p
	where	p.schema_id = @testSchemaId
	and		p.name like '[_]@Test@[_]%';

	-- For all tests...
	declare TestCursor cursor local fast_forward
	for
	select	TestProcedure
	from	#Tests;

	open TestCursor;

	while (1 = 1)
	begin
		declare @testProcedure varchar(128);

		fetch	next
		from	TestCursor
		into	@testProcedure;

		if (@@fetch_status <> 0)
			break;

		-- Run the test.
		declare @qualifiedProcedure varchar(133);
		set		@qualifiedProcedure = 'test.' + @testProcedure;

		exec ssunit.CurrentTest_SetTest @procedure = @qualifiedProcedure
		exec ssunit.RunTest	@qualifiedProcedure;

		-- Drop the unit test procedure.
		declare @statement varchar(max);
		set		@statement = 'drop procedure ' + @qualifiedProcedure;

		exec(@statement);
	end
	
	close TestCursor;
	deallocate TestCursor;

	-- Display the result of each test.
	if (ssunit.IsInteractive() = 1)
	begin
		select	ssunit.TestOutcome_ToString(r.Outcome)			as [Outcome],
				replace(r.TestProcedure, 'test._@Test@_', '')	as [Test Name],
				isnull(r.FailureReason, '')						as [Failure Reason]
		from	ssunit.TestResult r
		order	by r.TestOrder;
	end
	else
	begin
		select	convert(varchar( 7), ssunit.TestOutcome_ToString(r.Outcome))		as [Outcome],
				convert(varchar(35), replace(r.TestProcedure, 'test._@Test@_', ''))	as [Test Name],
				convert(varchar(35), isnull(r.FailureReason, ''))					as [Failure Reason]
		from	ssunit.TestResult r
		order	by r.TestOrder;
	end

	-- Separate the results/summary.
	if (ssunit.IsInteractive() = 0)
	begin
		select '';
	end

	-- Display a summary of the test results.
	select	isnull([Passed],  0) as [Passed],
			isnull([FAILED],  0) as [Failed],
			isnull([Unknown], 0) as [Unknown]
	from
	(
			select	ssunit.TestOutcome_ToString(r.Outcome)	as [Outcome],
					count(*)								as [Total]
			from	ssunit.TestResult r
			group	by r.Outcome
	)
	as SourceTable
	pivot
	(
			sum([Total])
			for [Outcome] in ([Passed], [FAILED], [Unknown])
	)
	as PivotTable;
go
