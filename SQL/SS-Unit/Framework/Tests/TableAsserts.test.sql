/**
 * \file
 * \brief  Unit tests for the table assert procedures.
 * \author Chris Oldwood
 */

create procedure test._@TestSetUp@_$Table$_
as
	create table test.TestTable
	(
		TestColumn int not null
	);

	create table test.TestTableWithIndexes
	(
		TestColumn1 int not null,
		TestColumn2 int not null
	);

	create unique index TestTableWithIndexes_TestColumn1 on test.TestTableWithIndexes(TestColumn1);
	create unique index TestTableWithIndexes_TestColumn2 on test.TestTableWithIndexes(TestColumn2);
go

create procedure test._@TestTearDown@_$Table$_
as
	drop table test.TestTableWithIndexes;
	drop table test.TestTable;
go

create procedure test._@Test@_$Table$_AssertTableRowCountEqualTo_ShouldFail_WhenTableNameIsNull
as
	exec ssunit.AssertTableRowCountEqualTo 0, null;
go

create procedure test._@Test@_$Table$_AssertTableRowCountEqualTo_ShouldFail_WhenExpectedCountIsNull
as
	exec ssunit.AssertTableRowCountEqualTo null, 'test.TestTable';
go

create procedure test._@Test@_$Table$_AssertTableRowCountEqualTo_ShouldPass_WhenRowCountMatches
as
	insert into test.TestTable values(0);

	exec ssunit.AssertTableRowCountEqualTo 1, 'test.TestTable';
go

create procedure test._@Test@_$Table$_AssertTableRowCountEqualTo_ShouldPass_WhenTableHasIndexes
as
	insert into test.TestTableWithIndexes values(0, 0);
	insert into test.TestTableWithIndexes values(1, 1);

	exec ssunit.AssertTableRowCountEqualTo 2, 'test.TestTableWithIndexes';
go

create procedure test._@Test@_$Table$_AssertTableRowCountEqualTo_ShouldFail_WhenRowCountDiffers
as
	insert into test.TestTable values(0);

	exec ssunit.AssertTableRowCountEqualTo 0, 'test.TestTable';
go

create procedure test._@Test@_$Table$_AssertTableEmpty_ShouldFail_WhenTableNameIsNull
as
	exec ssunit.AssertTableIsEmpty null;
go

create procedure test._@Test@_$Table$_AssertTableEmpty_ShouldPass_WhenTableIsEmpty
as
	truncate table test.TestTable;

	exec ssunit.AssertTableIsEmpty 'test.TestTable';
go

create procedure test._@Test@_$Table$_AssertTableEmpty_ShouldFail_WhenTableIsNotEmpty
as
	insert into test.TestTable values(0);

	exec ssunit.AssertTableIsEmpty 'test.TestTable';
go

create procedure test._@FixtureSetUp@_$TableComparison$_
as
	create table test.Actual
	(
		FirstColumn		int not null,
		SecondColumn	varchar(100) null,
	);

	create table test.Expected
	(
		FirstColumn		int not null,
		SecondColumn	varchar(100) null,
	);
go

create procedure test._@FixtureTearDown@_$TableComparison$_
as
	drop table test.Expected;
	drop table test.Actual;
go

create procedure test._@TestTearDown@_$TableComparison$_
as
	delete from test.Expected;
	delete from test.Actual;
go

create procedure test._@Test@_$TableComparison$_AssertTableEqualTo_ShouldPass_WhenTableEquivalent
as
	insert into test.Actual   values (42, 'forty-two');
	insert into test.Expected values (42, 'forty-two');

	exec ssunit.AssertTableEqualTo 'test.Expected', 'test.Actual';
go

create procedure test._@Test@_$TableComparison$_AssertTableEqualTo_ShouldFail_WhenTablesDiffer
as
	insert into test.Actual   values (43, 'forty-three');
	insert into test.Expected values (42, 'forty-two');

	exec ssunit.AssertTableEqualTo 'test.Expected', 'test.Actual';
go

exec ssunit.RunTests @testNameFilter = '%TableComparison%';
