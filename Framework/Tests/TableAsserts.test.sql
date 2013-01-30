/**
 * \file
 * \brief  Unit tests for the table assert procedures.
 * \author Chris Oldwood
 */

exec ssunit.TestSchema_Clear;
go

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
		FirstColumn		int null,
		SecondColumn	varchar(100) null,
	);

	create table test.Expected
	(
		FirstColumn		int null,
		SecondColumn	varchar(100) null,
	);

	create table test.DifferentSchema
	(
		Different		DateTime not null,
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

create procedure test._@Test@_$TableComparison$_AssertTableEqualTo_ShouldPass_WhenTablesEquivalent
as
	insert into test.Actual   values (42, 'forty-two');
	insert into test.Expected values (42, 'forty-two');

	exec ssunit.AssertTableEqualTo 'test.Expected', 'test.Actual';
go

create procedure test._@Test@_$TableComparison$_AssertTableEqualTo_ShouldPass_WhenTablesEmpty
as
	exec ssunit.AssertTableEqualTo 'test.Expected', 'test.Actual';
go

create procedure test._@Test@_$TableComparison$_AssertTableEqualTo_ShouldFail_WhenTablesDiffer
as
	insert into test.Actual   values (43, 'forty-three');
	insert into test.Expected values (42, 'forty-two');

	exec ssunit.AssertTableEqualTo 'test.Expected', 'test.Actual';
go

create procedure test._@Test@_$TableComparison$_AssertTableEqualTo_ShouldPass_WhenTablesMatchNullValues
as
	insert into test.Actual   values (null, null);
	insert into test.Expected values (null, null);

	exec ssunit.AssertTableEqualTo 'test.Expected', 'test.Actual';
go

create procedure test._@Test@_$TableComparison$_AssertTableEqualTo_ShouldFail_WhenTableSchemasDiffer
as
	insert into test.DifferentSchema values ('2001-01-01');
	insert into test.Expected        values (42, 'forty-two');

	exec ssunit.AssertTableEqualTo 'test.Expected', 'test.DifferentSchema';
go

create procedure test._@FixtureSetUp@_$TableSchema$_
as
	create table test.TableSchema
	(
		[First Column]		int null,
		[Second Column]		varchar(100) null,
	);

	create table test.TableWithManyColumns
	(
		ColumnNumber01  int null,
		ColumnNumber02  int null,
		ColumnNumber03  int null,
		ColumnNumber04  int null,
		ColumnNumber05  int null,
		ColumnNumber06  int null,
		ColumnNumber07  int null,
		ColumnNumber08  int null,
		ColumnNumber09  int null,
		ColumnNumber10  int null,
	);
go

create procedure test._@FixtureTearDown@_$TableSchema$_
as
	drop table test.TableWithManyColumns;
	drop table test.TableSchema;
go

create procedure test._@Test@_$TableSchema$_FormatTableColumnList_ShouldReturnColumnNamesEscaped
as
	declare @expected ssunit_impl.List = '[First Column],[Second Column]';
	declare @actual ssunit_impl.List = ssunit_impl.FormatTableColumnList('test.TableSchema');

	exec ssunit.AssertStringEqualTo @expected, @actual;
go

create procedure test._@Test@_$TableSchema$_FormatTableColumnList_ShouldHandleTableWithManyColumns
as
	declare @actual ssunit_impl.List = ssunit_impl.FormatTableColumnList('test.TableWithManyColumns');

	exec ssunit.AssertStringLike '%ColumnNumber01%', @actual;
	exec ssunit.AssertStringLike '%ColumnNumber10%', @actual;
go

exec ssunit.RunTests;
