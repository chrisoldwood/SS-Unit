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
go

create procedure test._@TestTearDown@_$Table$_
as
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

exec ssunit.RunTests;
