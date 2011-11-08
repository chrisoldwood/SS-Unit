/**
 * \file
 * \brief  Tests for the fixture features such as SetUp & TearDown.
 * \author Chris Oldwood
 */

create procedure test._@Test@_FixturelessTest_ShouldExecuteAnd_ShouldPass
as
	exec ssunit.AssertPass;
go

create procedure test._@Test@_GetFixtureName_ShouldReturnNull_WhenNoNameExists
as
	declare @actual ssunit.FixtureName = ssunit.GetFixtureName('test._@Test@_NoFixtureName');

	exec ssunit.AssertStringIsNull @actual;
go

create procedure test._@Test@_GetFixtureName_ShouldReturnName_WhenNameExists
as
	declare @expected ssunit.FixtureName = 'FixtureName';
	declare @testName ssunit.ProcedureName = 'test._@Test@_$' + @expected + '$_TestName';

	declare @actual ssunit.FixtureName = ssunit.GetFixtureName(@testName);

	exec ssunit.AssertStringEqualTo @expected, @actual;
go

create procedure test._@Test@_GetFixtureName_ShouldReturnNull_WhenFixtureNameMalformed
as
	declare @actual ssunit.FixtureName = ssunit.GetFixtureName('test._@Test@_$FixtureName_');

	exec ssunit.AssertStringIsNull @actual;

	set @actual = ssunit.GetFixtureName('test._@Test@_FixtureName$_');

	exec ssunit.AssertStringIsNull @actual;
go

create procedure test._@FixtureSetUp@_$Fixture1$_FixtureSetUp
as
	create table test.TestCounter
	(
		Value	int
	);

	insert into test.TestCounter(Value) values(1);
go

create procedure test._@FixtureTearDown@_$Fixture1$_FixtureTearDown
as
	drop table test.TestCounter;
go

create procedure test._@TestSetUp@_$Fixture1$_TestSetUp
as
	update test.TestCounter
	set	   Value = Value + 10;
go

create procedure test._@TestTearDown@_$Fixture1$_TestTearDown
as
	update test.TestCounter
	set	   Value = Value + 100;
go

create procedure test._@Test@_$Fixture1$_ShouldPass_WhenTestSetUpAndTearDownAreInvoked_1
as
	declare @value int;
	select	@value = Value from test.TestCounter;

	declare @passed bit = case when (@value = 11 or @value = 121) then 1 else 0 end;

	exec ssunit.AssertTrue @passed;
go

create procedure test._@Test@_$Fixture1$_ShouldPass_WhenTestSetUpAndTearDownAreInvoked_2
as
	declare @value int;
	select	@value = Value from test.TestCounter;

	declare @passed bit = case when (@value = 11 or @value = 121) then 1 else 0 end;

	exec ssunit.AssertTrue @passed;
go

create procedure test._@TestSetUp@_$Fixture2$_TestSetUp
as
	raiserror('error raised from test set up', 16, 1);
go

create procedure test._@Test@_$Fixture2$_TestShouldFail_WhenErrorThrownFromTestSetUp
as
	exec ssunit.AssertFail 'Test should not have been invoked';
go

create procedure test._@TestTearDown@_$Fixture3$_TestTearDown
as
	raiserror('error raised from test tear down', 16, 1);
go

create procedure test._@Test@_$Fixture3$_TestShouldFail_WhenErrorThrownFromTestTearDown
as
	exec ssunit.AssertPass;
go

declare @displayWidth int = case when (isnumeric('$(DisplayWidth)') = 0) then 80 else convert(int, '$(DisplayWidth)') end;

exec ssunit.RunTests @displayWidth = @displayWidth;
