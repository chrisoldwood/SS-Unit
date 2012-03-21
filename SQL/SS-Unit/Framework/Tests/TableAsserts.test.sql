/**
 * \file   TableAsserts.test.sql
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

declare @displayWidth int = case when (isnumeric('$(DisplayWidth)') = 0) then 80 else convert(int, '$(DisplayWidth)') end;

exec ssunit.RunTests @displayWidth = @displayWidth;
